Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261685AbTISTRO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 15:17:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261686AbTISTRN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 15:17:13 -0400
Received: from screech.rychter.com ([212.87.11.114]:7324 "EHLO
	screech.rychter.com") by vger.kernel.org with ESMTP id S261685AbTISTRK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 15:17:10 -0400
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.22 USB problem (uhci)
References: <m2znh1pj5z.fsf@tnuctip.rychter.com>
	<20030919190628.GI6624@kroah.com>
X-Spammers-Please: blackholeme@rychter.com
From: Jan Rychter <jan@rychter.com>
Date: Fri, 19 Sep 2003 12:17:11 -0700
In-Reply-To: <20030919190628.GI6624@kroah.com> (Greg KH's message of "Fri,
 19 Sep 2003 12:06:28 -0700")
Message-ID: <m2d6dwr3k8.fsf@tnuctip.rychter.com>
User-Agent: Gnus/5.1003 (Gnus v5.10.3) XEmacs/21.4 (Rational FORTRAN, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Greg" == Greg KH <greg@kroah.com> writes:
 Greg> On Thu, Sep 18, 2003 at 08:10:48PM -0700, Jan Rychter wrote:
 >> Upon disconnecting an USB mouse from a 2.4.22, I get
 >>
 >> uhci.c: efe0: host controller halted. very bad
 >>
 >> and subsequently, the machine keeps on spinning in ACPI C2 state,
 >> never going into C3, as it should (since the mouse is the only USB
 >> device).
 >>
 >> If afterwards I do 'rmmod uhci; modprobe uhci', then the machine
 >> starts using the C3 state again.

 Greg> If you use the usb-uhci driver, does it also do this?

If you mean strange messages, no, it doesn't. Using usb-uhci it just
says "USB disconnect..." and everything looks fine.

As to C-states, usb-uhci prevents Linux from *ever* entering C3, being
effectively unusable on some laptops -- so there is no way I can see the
same symptoms with it.

--J.
