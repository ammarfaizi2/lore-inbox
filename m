Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313083AbSEULrK>; Tue, 21 May 2002 07:47:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313118AbSEULrJ>; Tue, 21 May 2002 07:47:09 -0400
Received: from kim.it.uu.se ([130.238.12.178]:7555 "EHLO kim.it.uu.se")
	by vger.kernel.org with ESMTP id <S313083AbSEULrI>;
	Tue, 21 May 2002 07:47:08 -0400
From: Mikael Pettersson <mikpe@csd.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15594.13240.936204.105899@kim.it.uu.se>
Date: Tue, 21 May 2002 13:47:04 +0200
To: reneb@cistron.nl
Cc: linux-kernel@vger.kernel.org
Subject: Re: floppy always read-only in 2.5.12+
In-Reply-To: <slrnaekbvt.4u.reneb@orac.aais.org>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rene Blokland writes:
 > Hi, my desktop has a buildin floppy not an ide but and oldfasion one.
 > The mb is an ASUS p5a with an AMD k6 processor
 > When i try to do a dd to /dev/fd0 as root, it compaining about a Read-Only
 > filesystem.
 > Also lilo has this problem. is it a bug or did I miss something?
 > Thanks for your answer.

This has been discussed here on LKML before. The preliminary patch at
<http://www.csd.uu.se/~mikpe/linux/patches/2.5/patch-fix-floppy-2.5.16>
fixes the problem for me, but it may not be the "real" fix.

If you intend to mount the floppy as a file system you may also have
to patch fs/partitions/check.c:check_partition() similarly to how
fs/block_dev.c was patched. I haven't tested that bit yet.

/Mikael
