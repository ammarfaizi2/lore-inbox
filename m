Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267544AbRGSMg1>; Thu, 19 Jul 2001 08:36:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267558AbRGSMgR>; Thu, 19 Jul 2001 08:36:17 -0400
Received: from delta.Colorado.EDU ([128.138.139.9]:49927 "EHLO
	ibg.colorado.edu") by vger.kernel.org with ESMTP id <S267544AbRGSMgK>;
	Thu, 19 Jul 2001 08:36:10 -0400
Message-Id: <200107191236.GAA389681@ibg.colorado.edu>
To: andrewm@uow.edu.au
cc: linux-kernel@vger.kernel.org
Subject: Re: Too much memory causes crash when reading/writing to disk
Organization: Institute for Behavioral Genetics
              University of Colorado
              Boulder, CO  80309-0447
X-Phone: +1 303 492 2843
X-FAX: +1 303 492 0852
X-URL: http://ibgwww.Colorado.EDU/~lessem/
X-Copyright: All original content is copyright 2001 Jeff Lessem.
X-Copyright: Quoted and non-original content may be copyright the
X-Copyright: original author or others.
Date: Thu, 19 Jul 2001 06:36:11 -0600
From: Jeff Lessem <Jeff.Lessem@Colorado.EDU>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Andrew Morton wrote:

>Again, spinning in the timer interrupt handler.  It does
>appear that the interrupt is not being negated.  Try -ac
>and other kernels if/when you can, but it does seem that
>the hardware is unwell.

Ok, this is terribly embarrassing.  As soon as you said it looked like
a hardware error, for some reason that made me think of grub, the boot
loader.  Sure enough, booting a kernel straight from floppy without
using any bootloader completely avoids the problem.  This is the
second time I have been bitten in the ass by grub.  (The first time
was on my notebook.  After involving Linus in debugging the pci and
yenta drivers, it was discovered that grub was setting up memory
wrong, so the kernel couldn't properly init the cardbus controller.)

So, lessons learned:

grub stable <  0.90.0 does not work on (some?) notebooks
grub stable <= 0.90.0 does not work on Dell 8450s.

I really like the feature set of grub, but I guess the simplicity of
lilo should not be undervalued.

Anyways, I am sorry for wasting your time, and appreciate the help you
have been in debugging this problem.  If you ever make it to Oxford,
UK or Boulder, CO, I know a research grant that will buy you a pint
(or more)...

--
Jeff Lessem.
