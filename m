Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262149AbREPXxn>; Wed, 16 May 2001 19:53:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262159AbREPXxc>; Wed, 16 May 2001 19:53:32 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:50189 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262149AbREPXxU>; Wed, 16 May 2001 19:53:20 -0400
Subject: Re: [PATCH] rootfs (part 1)
To: cr@sap.com (Christoph Rohland)
Date: Thu, 17 May 2001 00:49:15 +0100 (BST)
Cc: torvalds@transmeta.com (Linus Torvalds),
        viro@math.psu.edu (Alexander Viro), linux-kernel@vger.kernel.org
In-Reply-To: <m3ofst5gs5.fsf@linux.local> from "Christoph Rohland" at May 16, 2001 07:45:46 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E150B2Z-0004fV-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> cr:/speicher/src/u4ac9 $ ls -l mm/shmem.o*
> -rw-r--r--    1 cr       users      154652 Mai 16 19:27 mm/shmem.o-tmpfs
> -rw-r--r--    1 cr       users      180764 Mai 16 19:24 mm/shmem.o+tmpfs
> cr:/speicher/src/u4ac9 $ ls -l fs/ramfs/ramfs.o
> -rw-r--r--    1 cr       users      141452 Mai 16 19:27 fs/ramfs/ramfs.o
> 
> So CONFIG_TMPFS adds 26k and ramfs 140k.

I think you have a major tool problem.

bash-2.04$ size mm/shmem.o
   text	   data	    bss	    dec	    hex	filename
   7422	    572	      0	   7994	   1f3a	mm/shmem.o
bash-2.04$ size fs/ramfs/ramfs.o 
   text	   data	    bss	    dec	    hex	filename
   3185	    368	      0	   3553	    de1	fs/ramfs/ramfs.o

Never trust ls -l size for binaries, its very very unrelated.

So ramfs is 3553 bytes, shmem.o in total is 8K on current -ac.


