Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270801AbTGVLmN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 07:42:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270800AbTGVLmN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 07:42:13 -0400
Received: from firewall.mdc-dayton.com ([12.161.103.180]:19402 "EHLO
	firewall.mdc-dayton.com") by vger.kernel.org with ESMTP
	id S270809AbTGVLkM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 07:40:12 -0400
From: "Kathy Frazier" <kfrazier@mdc-dayton.com>
To: <no_spam@ntlworld.com>, <linux-kernel@vger.kernel.org>
Subject: RE: Missing interrupts?
Date: Tue, 22 Jul 2003 08:06:15 -0500
Message-ID: <PMEMILJKPKGMMELCJCIGKEGCCDAA.kfrazier@mdc-dayton.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
In-Reply-To: <200307212100.54433.no_spam@ntlworld.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

SA,

>How did you check that the driver was asserting the interrupt? (do you have
an
>additional way of monitoring it?)  I have yet to fully investigate my
problem
>and an additional tool to check if my board is actually asserting the
>interrupt (and to find out how far it gets) would be very handy,

We hooked up a logic analyzer to the board and saw that the interrupt was
being asserted.

>> Are you running these tests using the same board?  You might try moving
the
>> board for this device driver from the athlon PC to the pentium 4 PC just
to
>> insure it is not a problem with the board.

>Same board each time



>>...
>>....
>> Is the value in pi_stage.interrupt assigned from the irq element of the
>> pci_dev structure (returned by pci_find_device routine)?  This is the
>> preferred way to obtain your IRQ rather than look directly at your
device's
>> config space.

>I am currently inspecting the board config space - I will modify and test -
is
>it possible for the config space to be "wrong".

The kernel can re-map things.  See pci.txt in the Documentation directory of
the source tree.

>> Even though you are indicating that you will share the IRQ, have you
tried
>> adjusting BIOS settings or moving board to another slot to try to
establish
>> a unique IRQ for yourself?  That would at least prevent another device
>> driver from getting in your way.

>The card and driver share "nicely" with a random assortment of hardware on
the
>"good" machines - I will try to get it a unique (or at least different
>interrupt) on the bad machine (it current shares with usb on int 9 which
>never seems to get any interrupts) and see how this pans out

It's worth trying.  Just to know that nothing else is messing you up!

Good luck!
Kathy


