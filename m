Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283902AbRLEJiL>; Wed, 5 Dec 2001 04:38:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283903AbRLEJiC>; Wed, 5 Dec 2001 04:38:02 -0500
Received: from web21108.mail.yahoo.com ([216.136.227.110]:19974 "HELO
	web21108.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S283894AbRLEJhq>; Wed, 5 Dec 2001 04:37:46 -0500
Message-ID: <20011205093744.79645.qmail@web21108.mail.yahoo.com>
Date: Wed, 5 Dec 2001 01:37:44 -0800 (PST)
From: "Roy S.C. Ho" <scho1208@yahoo.com>
Subject: Re: question about kernel 2.4 ramdisk
To: Padraig Brady <padraig@antefacto.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3C0D2843.5060708@antefacto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Padraig,

Thanks for the patch. I applied it to fs/ramfs/inode.c
in 2.4.13-ac7 and compile it as a module in 2.4.2
(removepage was changed back to truncatepage, of
course), but it seems that memory leak still occured
(I have to stick to 2.4.2 as one of my production
systems uses it...) Any idea?

By the way, is it possible to use ramdisk with the
size larger than 600MB? /var/log/messages repeatedly
reported the following when I tried to mount a
ext2-formatted ramdisk of 600MB:

Dec  5 17:22:27 roy-home kernel: set_blocksize: dev
01:00 buffer_dirty 655360 size 1024
....
....
Dec  5 17:22:27 roy-home kernel: EXT2-fs: Magic
mismatch, very weird !

Many thanks,
Roy

--- Padraig Brady <padraig@antefacto.com> wrote:
> Roy S.C. Ho wrote:
> 
> > Hi, I am using linux kernel 2.4.2 and I have 1 GB
> ram.
> > I tried to boot the system with a ramdisk size of
> > 600MB. It was ok when I did "mke2fs" on it, but
> when I
> > mounted it, it failed (Magic number mismatch). I
> tried
> > this several times and found that all ramdisk
> sizes
> > larger than 513MB could cause trouble. Could
> anyone
> > please kindly give me some hints? I would like to
> have
> > a larger ramdisk (around 800MB).
> > 
> > (note: I tried ramfs but it seems to have memory
> > leakage when files are deleted and created
> frequently;
> > tmpfs is ok, but the pages may be swapped, which
> is
> > not desirable in my case...)
> 
> 
> does the patch attached fix your problem with ramfs?
> 
>  


__________________________________________________
Do You Yahoo!?
Buy the perfect holiday gifts at Yahoo! Shopping.
http://shopping.yahoo.com
