Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261591AbREPRwR>; Wed, 16 May 2001 13:52:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261965AbREPRv5>; Wed, 16 May 2001 13:51:57 -0400
Received: from smtpde02.sap-ag.de ([194.39.131.53]:2484 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S261591AbREPRvq>; Wed, 16 May 2001 13:51:46 -0400
From: Christoph Rohland <cr@sap.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rootfs (part 1)
In-Reply-To: <Pine.LNX.4.21.0105161010200.4738-100000@penguin.transmeta.com>
Organisation: SAP LinuxLab
Date: 16 May 2001 19:45:46 +0200
In-Reply-To: <Pine.LNX.4.21.0105161010200.4738-100000@penguin.transmeta.com>
Message-ID: <m3ofst5gs5.fsf@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SAP: out
X-SAP: out
X-SAP: out
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Wed, 16 May 2001, Linus Torvalds wrote:
> Looks ok, but it also feels like 2.5.x stuff to me. 
> 
> Also, there's the question of whether to make ramfs just built-in,
> or make _tmpfs_ built in - ramfs is certainly simpler, but tmpfs
> does the same things and you need that one for shared mappings etc.
> 
> Comments?

cr:/speicher/src/u4ac9 $ ls -l mm/shmem.o*
-rw-r--r--    1 cr       users      154652 Mai 16 19:27 mm/shmem.o-tmpfs
-rw-r--r--    1 cr       users      180764 Mai 16 19:24 mm/shmem.o+tmpfs
cr:/speicher/src/u4ac9 $ ls -l fs/ramfs/ramfs.o
-rw-r--r--    1 cr       users      141452 Mai 16 19:27 fs/ramfs/ramfs.o

So CONFIG_TMPFS adds 26k and ramfs 140k.

Greetings
		Christoph


