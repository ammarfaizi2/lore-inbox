Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129684AbQLJXna>; Sun, 10 Dec 2000 18:43:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129774AbQLJXnU>; Sun, 10 Dec 2000 18:43:20 -0500
Received: from web204.mail.yahoo.com ([128.11.68.104]:22285 "HELO
	web204.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S129684AbQLJXnE>; Sun, 10 Dec 2000 18:43:04 -0500
Message-ID: <20001210231233.25126.qmail@web204.mail.yahoo.com>
Date: Sun, 10 Dec 2000 15:12:33 -0800 (PST)
From: Jean Fekry Rizk <jeanfekry@yahoo.com>
Subject: Linking with kernel code (Makefile)
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kernel World,
I'm new to linux-kernel developement, so I would appreciate any help.

What I want to do:
    create a shared memory segment between user space and kernel space

How am I trying to do it from kernel:
    use the 'newseg' function from 'ipc/shm.c', or even the array shm_segs
directly.

The problem:
    I can't link with the array or the function, this also happens with
all functions that are not defined in 'ksyms'
    Even though I declared 'newseg' and 'shm_segs' as 'extern' in my file

I think my problem is in the Makefile.
I'm using linux-2.2.14
Here is the Makefile from the ipc folder
    O_TARGET:=ipc.o
    O_OBJS  :=util.o msg.o sem.o shm.o
    include  $(TOPDIR)/Rules.make
To compile my file 'mycode.c'- which uses newseg - I just added 'mycode.o'
to the O_OBJS line.
But while making bzImage, it gives the error unresolved external 'newseg'

So my question is how can I link to the kernel source code, or am I not
allowed to?

__________________________________________________
Do You Yahoo!?
Yahoo! Shopping - Thousands of Stores. Millions of Products.
http://shopping.yahoo.com/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
