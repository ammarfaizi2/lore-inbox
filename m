Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264328AbTKUIak (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Nov 2003 03:30:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264330AbTKUIaj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Nov 2003 03:30:39 -0500
Received: from ns.sws.net.au ([61.95.69.3]:52485 "EHLO ns.sws.net.au")
	by vger.kernel.org with ESMTP id S264328AbTKUIag (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Nov 2003 03:30:36 -0500
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: 2.4.0-test9 and HDD LED
Date: Fri, 21 Nov 2003 19:30:30 +1100
User-Agent: KMail/1.5.4
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
References: <200311211327.00522.russell@coker.com.au> <20031121082027.A5090@flint.arm.linux.org.uk>
In-Reply-To: <20031121082027.A5090@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311211930.30241.russell@coker.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Nov 2003 19:20, Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> On Fri, Nov 21, 2003 at 01:27:00PM +1100, Russell Coker wrote:
> > When running 2.4.0-test9 on my Thinkpad T20 the HDD LED usually stays on
> > all the time.  It seems random, some boots the LED will operate normally,
> > but most boots the LED will go on continually.
>
> Is the HDD led separate from the floppy LED?  On my thinkpad, they're
> one of the same.

You are so smart!  I never even looked at the side to see whether the floppy 
disk access light was on.

The floppy disk access light (that's part of the floppy drive) was on as well 
as the system disk access light (I almost never use the floppy drive).

> If yes, I'd guess that you've built a kernel without floppy support
> built in.

You are correct.  "modprobe floppy" restored the operation of the disk access 
light to normal.

> The kernel used to turn the floppy motor off itself even
> without floppy support, but this has been removed.  IIRC it is now
> the responsibility of the boot loader to do this.

Hmm.  LILO bug then I guess.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

