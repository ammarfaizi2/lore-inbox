Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266338AbUAOIDS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 03:03:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266428AbUAOIDR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 03:03:17 -0500
Received: from p508A6ABA.dip.t-dialin.net ([80.138.106.186]:36739 "EHLO
	averell.firstfloor.org") by vger.kernel.org with ESMTP
	id S266338AbUAOIDQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 03:03:16 -0500
To: George Anzinger <george@mvista.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [discuss] Re: kgdb for x86_64 2.6 kernels
From: Andi Kleen <ak@muc.de>
Date: Thu, 15 Jan 2004 09:02:38 +0100
In-Reply-To: <1e3fi-4nG-5@gated-at.bofh.it> (George Anzinger's message of
 "Thu, 15 Jan 2004 01:10:08 +0100")
Message-ID: <m3ptdlwsf5.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.090013 (Oort Gnus v0.13) Emacs/21.2 (i586-suse-linux)
References: <1cd9t-4Su-65@gated-at.bofh.it> <1coR2-42n-19@gated-at.bofh.it>
	<1d3r0-1tw-3@gated-at.bofh.it> <1dbI9-89t-7@gated-at.bofh.it>
	<1dEqx-F0-1@gated-at.bofh.it> <1dMRc-6DQ-3@gated-at.bofh.it>
	<1e2Mk-6YA-17@gated-at.bofh.it> <1e2Mo-6YA-31@gated-at.bofh.it>
	<1e3fi-4nG-5@gated-at.bofh.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

George Anzinger <george@mvista.com> writes:

>> Raw USB?  Or some kind of USB to serial device?
>> Remember, USB needs interrupts to work, see the kdb patches for the
>> mess
>> that people have tried to go through to send usb data without interrupts
>> (doesn't really work...)
>
> I gave up on USB when I asked the following questions:

There is a special "USB debugport" specification available that allows
to drive USB very simply using PIO without too much set up. It should
be implemented in most chipsets by now because that other operating
system is using it.

See e.g. http://www.usb.org/developers/presentations/pres0602/john_keys.pdf

It works with a simple "debug dongle", that is identical to the 
USB networking cables that are often sold cheaply.

If you want to port kgdb to use USB I would use that. USB console
would also be very useful for debugging laptops and some systems
with no USB.

-Andi
