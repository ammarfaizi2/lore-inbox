Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266846AbTAORrJ>; Wed, 15 Jan 2003 12:47:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266848AbTAORrI>; Wed, 15 Jan 2003 12:47:08 -0500
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:26117 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S266846AbTAORrI>; Wed, 15 Jan 2003 12:47:08 -0500
Message-ID: <3E258CE7.D5E34C6E@linux-m68k.org>
Date: Wed, 15 Jan 2003 17:31:35 +0100
From: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Russell King <rmk@arm.linux.org.uk>
CC: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] add module reference to struct tty_driver
References: <20030113054708.GA3604@kroah.com> <20030114200719.B4077@flint.arm.linux.org.uk> <20030114220859.GA17226@kroah.com> <20030115100001.D31372@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> 
> On Tue, Jan 14, 2003 at 02:08:59PM -0800, Greg KH wrote:
> > Woah!  Hm, this is going to cause lots of problems in drivers that have
> > been assuming that the BKL is grabbed during module unload, and during
> > open().  Hm, time to just fallback on the argument, "module unloading is
> > unsafe" :(
> 
> Note that its the same in 2.4 as well.  iirc, the BKL was removed from
> module loading/unloading sometime in the 2.3 timeline.

Um, my copy of 2.4 module.c still has lock_kernel()/unlock_kernel() all
over it and I'm quite sure that didn't change until 2.5.47.

bye, Roman


