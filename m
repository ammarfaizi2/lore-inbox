Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291355AbSBGWcB>; Thu, 7 Feb 2002 17:32:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291382AbSBGWbo>; Thu, 7 Feb 2002 17:31:44 -0500
Received: from borderworlds.dk ([193.162.142.101]:45842 "HELO
	klingon.borderworlds.dk") by vger.kernel.org with SMTP
	id <S291381AbSBGWa1>; Thu, 7 Feb 2002 17:30:27 -0500
To: <linux-kernel@vger.kernel.org>
Subject: Re: Problems with iso9660 as initrd
In-Reply-To: <Pine.LNX.4.30.0202071316501.21862-100000@outback.escape.de>
From: Christian Laursen <xi@borderworlds.dk>
Date: 07 Feb 2002 23:30:24 +0100
In-Reply-To: <Pine.LNX.4.30.0202071316501.21862-100000@outback.escape.de>
Message-ID: <m3d6zglybj.fsf@borg.borderworlds.dk>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Kilian <kili@outback.escape.de> writes:

> On 6 Feb 2002, H. Peter Anvin wrote:
> 
> > > I am building a floppy using a compressed iso9660 filesystem as an
> > > initrd image.
> [...]
> > You definitely are... I don't think anyone else has ever tried running
> > a zisofs off a ramdisk before!
> 
> On for an initrd, it will never work, since initrd checks for minix, ext2
> and romfs only (see drivers/block/rd.c, identify_ramdisk_image()).

It seems you are right. To be more precise it will not work on a ramdisk at
all.

A normal ramdisk will just fail to mount when there's an iso9660 fs on it,
whereas an initrd seems to cause a panic.

I guess it would be nice to output a somewhat friendly error message instead.

Oh well...

After further research I decided to use romfs instead, since it can too be
generated quite easily with a script, and it works quite well.

-- 
Best regards
    Christian Laursen
