Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316755AbSGLS3l>; Fri, 12 Jul 2002 14:29:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316757AbSGLS3k>; Fri, 12 Jul 2002 14:29:40 -0400
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:57862 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S316755AbSGLS3j>; Fri, 12 Jul 2002 14:29:39 -0400
Date: Fri, 12 Jul 2002 20:32:20 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Dave Jones <davej@suse.de>
cc: Thunder from the hill <thunder@ngforever.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [CHECKER] 56 potential lock/unlock bugs in 2.5.8
In-Reply-To: <20020712200507.G16956@suse.de>
Message-ID: <Pine.LNX.4.44.0207122030040.8911-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 12 Jul 2002, Dave Jones wrote:

> (whilst on the subject of affs, and whilst I remember..)
> btw, affs has been failing fsx runs again for the last few kernels.
> truncating to largest ever: 0x13e76
> domapwrite: mmap: Invalid argument
> LOG DUMP (4 total operations):
> 1(1 mod 256): TRUNCATE UP   from 0x0 to 0x13e76
> 2(2 mod 256): WRITE 0x17098 thru 0x26857    (0xf7c0 bytes) HOLE
> 3(3 mod 256): READ  0xc73e thru 0x1b801 (0xf0c4 bytes)
> 4(4 mod 256): MAPWRITE 0x32e00 thru 0x331fc (0x3fd bytes)
> fsx: save_buffer: short write, 0x30ba8 bytes instead of 0x331fd

Which last few kernels? Was it a ffs or an ofs image? For ofs images you
have to call fsx with "-W -R" to disable mmap operations.

bye, Roman

