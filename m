Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279180AbRKHNPz>; Thu, 8 Nov 2001 08:15:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279274AbRKHNPr>; Thu, 8 Nov 2001 08:15:47 -0500
Received: from [195.63.194.11] ([195.63.194.11]:61965 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S279180AbRKHNPi>; Thu, 8 Nov 2001 08:15:38 -0500
Message-ID: <3BEA91DA.6D204726@evision-ventures.com>
Date: Thu, 08 Nov 2001 15:08:26 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
Reply-To: dalecki@evision.ag
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: dalecki@evision.ag, Linus Torvalds <torvalds@transmeta.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Using %cr2 to reference "current"
In-Reply-To: <E161TWH-0004G9-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > somehow encouraged by the compiler comparisions between gcc and intel's
> > free compiler, which use the register passing for anything local
> > to the actual code, where the speed gains are up to 20% im currently
> 
> I was under the impression intels compiler was profoundly non-free ?
> 
> > quite inclined to do the redo and finish the experiment.
> > BTW.> It's not just asm fixpus that have to be done for this
> > to work. For example all the c files with -fno-omit-frame-pointer
> 
> 20% is a nice large number

I just wanted to note that I got already the wohle fixup until
the stage where the first schedule() occures during the kernel
initialization... printk and so on all seem to work nicely ;-).
Well the where some errors which had to be fixed until this.
For example the decompress_kernel function should have the
attribute asmlinkage and boot/compressed/misc.c should not export
enything else.

Further debugging will occur this evening...
