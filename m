Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262029AbREPRz5>; Wed, 16 May 2001 13:55:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262047AbREPRzh>; Wed, 16 May 2001 13:55:37 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:9438 "HELO havoc.gtf.org")
	by vger.kernel.org with SMTP id <S262040AbREPRzf>;
	Wed, 16 May 2001 13:55:35 -0400
Message-ID: <3B02BF14.89695966@mandrakesoft.com>
Date: Wed, 16 May 2001 13:55:32 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Christoph Rohland <cr@sap.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rootfs (part 1)
In-Reply-To: <Pine.LNX.4.21.0105161010200.4738-100000@penguin.transmeta.com> <m3ofst5gs5.fsf@linux.local>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Rohland wrote:
> 
> Hi Linus,
> 
> On Wed, 16 May 2001, Linus Torvalds wrote:
> > Looks ok, but it also feels like 2.5.x stuff to me.
> >
> > Also, there's the question of whether to make ramfs just built-in,
> > or make _tmpfs_ built in - ramfs is certainly simpler, but tmpfs
> > does the same things and you need that one for shared mappings etc.
> >
> > Comments?
> 
> cr:/speicher/src/u4ac9 $ ls -l mm/shmem.o*
> -rw-r--r--    1 cr       users      154652 Mai 16 19:27 mm/shmem.o-tmpfs
> -rw-r--r--    1 cr       users      180764 Mai 16 19:24 mm/shmem.o+tmpfs
> cr:/speicher/src/u4ac9 $ ls -l fs/ramfs/ramfs.o
> -rw-r--r--    1 cr       users      141452 Mai 16 19:27 fs/ramfs/ramfs.o
> 
> So CONFIG_TMPFS adds 26k and ramfs 140k.

On what system?  I don't think this is a good measure...
> [jgarzik@rum linux_2_4]$ ls -l fs/ramfs/ramfs.o 
> -rw-r--r--    1 jgarzik  jgarzik      5830 May 15 09:29 fs/ramfs/ramfs.o
> [jgarzik@rum linux_2_4]$ ls -l mm/shmem.o (includes tmpfs)
> -rw-r--r--    1 jgarzik  jgarzik     17496 May 15 09:28 mm/shmem.o

-- 
Jeff Garzik      | Game called on account of naked chick
Building 1024    |
MandrakeSoft     |
