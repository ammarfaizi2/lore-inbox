Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312261AbSC2W4m>; Fri, 29 Mar 2002 17:56:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312275AbSC2W4b>; Fri, 29 Mar 2002 17:56:31 -0500
Received: from [195.39.17.254] ([195.39.17.254]:50311 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S312261AbSC2W4T>;
	Fri, 29 Mar 2002 17:56:19 -0500
Date: Fri, 29 Mar 2002 23:35:02 +0100
From: Pavel Machek <pavel@ucw.cz>
To: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.7 build breakage around blkpg.c
Message-ID: <20020329223501.GC9974@elf.ucw.cz>
In-Reply-To: <20020328035926.GA10467@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> What hit me?

gcc bug hit you. Workaround by adding volatile's to all local
variables in affected function.
							Pavel

> gcc -D__KERNEL__ -I/home/wli/src/linus/linux-2.5/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i386   -DKBUILD_BASENAME=blkpg  -c -o blkpg.o blkpg.c
> blkpg.c: In function `blk_ioctl':
> blkpg.c:311: Internal compiler error:
> blkpg.c:311: internal error--unrecognizable insn:
> (insn 898 1478 907 (set (reg/v:SI 3 %ebx)

-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
