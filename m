Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261449AbUKFTg7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261449AbUKFTg7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Nov 2004 14:36:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261450AbUKFTg7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Nov 2004 14:36:59 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:49418 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261449AbUKFTg5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Nov 2004 14:36:57 -0500
Date: Sat, 6 Nov 2004 20:36:08 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andries Brouwer <aebr@win.tue.nl>, Adam Heath <doogie@debian.org>,
       Chris Wedgwood <cw@f00f.org>, Christoph Hellwig <hch@infradead.org>,
       Timothy Miller <miller@techsource.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: support of older compilers
Message-ID: <20041106193605.GL1295@stusta.de>
References: <Pine.LNX.4.58.0411041050040.1229@gradall.private.brainfood.com> <Pine.LNX.4.58.0411041133210.2187@ppc970.osdl.org> <Pine.LNX.4.58.0411041546160.1229@gradall.private.brainfood.com> <Pine.LNX.4.58.0411041353360.2187@ppc970.osdl.org> <Pine.LNX.4.58.0411041734100.1229@gradall.private.brainfood.com> <Pine.LNX.4.58.0411041544220.2187@ppc970.osdl.org> <20041105014146.GA7397@pclin040.win.tue.nl> <Pine.LNX.4.58.0411050739190.2187@ppc970.osdl.org> <20041106120716.GA9144@pclin040.win.tue.nl> <Pine.LNX.4.58.0411060922260.2223@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0411060922260.2223@ppc970.osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 06, 2004 at 09:33:35AM -0800, Linus Torvalds wrote:
> 
> 
> On Sat, 6 Nov 2004, Andries Brouwer wrote:
> > 
> > -rw-r--r--  1 aeb users 3161708 2004-11-06 01:19 /boot/bzImage-2.6.9test
> > 
> > Probably I select more filesystems than you do.
> 
> Ugh, you're right. Doing a reasonably normal build without modules nets us
> 
> 	  205K mm/built-in.o                                            
> 	  336K kernel/built-in.o                                            
> 	  451K sound/built-in.o                                            
> 	  864K net/built-in.o                                            
> 	 1016K fs/built-in.o                                            
> 	  2.3M drivers/built-in.o                                            
> 
> which is kind of scary. Of course, in the drivers, about half a meg of
> that is just the PCI name translation, so some of it is trivial (and
> thrown away at boot), but most of it is just spread out in fat all over. 
> 
> It's hard to go on a diet.

It's even harder because some subsystem maintainers refuse to remove 
unused global functions that might be used at some point far in the 
future or that even are never intended for in-kernel usage...

> 		Linus

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

