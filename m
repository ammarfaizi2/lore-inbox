Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S153876AbQC2E5Z>; Tue, 28 Mar 2000 23:57:25 -0500
Received: by vger.rutgers.edu id <S153902AbQC2E5R>; Tue, 28 Mar 2000 23:57:17 -0500
Received: from [209.128.87.2] ([209.128.87.2]:1531 "EHLO cyclades.com") by vger.rutgers.edu with ESMTP id <S153901AbQC2E5D>; Tue, 28 Mar 2000 23:57:03 -0500
Date: Tue, 28 Mar 2000 20:58:44 -0800 (PST)
From: Ivan Passos <lists@cyclades.com>
To: Linux Kernel List <linux-kernel@vger.rutgers.edu>
Subject: Modules and "Relocation overflow of type 4" (??)
Message-ID: <Pine.LNX.4.10.10003282058220.29457-100000@main.cyclades.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-kernel@vger.rutgers.edu


Hello,

I'm trying to run syncppp on Cobalt Qube2 boxen and it runs fine when I
build it as static (i.e., built-in to the kernel).

However, if I try to run it as a module ...

# gcc -D__KERNEL__ -I/usr/src/linux-2.0.34C52_SK/include -Wall
-Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strength-reduce -G 0
-mno-abicalls -fno-pic -mcpu=r8000 -mips2 -mmad -pipe -DMODULE  -c -o
syncppp.o syncppp.c

(no compilation errors)

# insmod syncppp.o

syncppp.o: Relocation overflow of type 4 for add_timer
syncppp.o: Relocation overflow of type 4 for del_timer
syncppp.o: Relocation overflow of type 4 for printk
syncppp.o: Relocation overflow of type 4 for printk
syncppp.o: Relocation overflow of type 4 for printk
syncppp.o: Relocation overflow of type 4 for printk
syncppp.o: Relocation overflow of type 4 for printk
syncppp.o: Relocation overflow of type 4 for printk
syncppp.o: Relocation overflow of type 4 for printk
syncppp.o: Relocation overflow of type 4 for netif_rx
syncppp.o: Relocation overflow of type 4 for kfree_skb
syncppp.o: Relocation overflow of type 4 for printk
syncppp.o: Relocation overflow of type 4 for add_timer
syncppp.o: Relocation overflow of type 4 for printk
syncppp.o: Relocation overflow of type 4 for printk
syncppp.o: Relocation overflow of type 4 for printk
syncppp.o: Relocation overflow of type 4 for printk
syncppp.o: Relocation overflow of type 4 for printk
syncppp.o: Relocation overflow of type 4 for printk
syncppp.o: Relocation overflow of type 4 for printk
syncppp.o: Relocation overflow of type 4 for printk
syncppp.o: Relocation overflow of type 4 for printk
syncppp.o: Relocation overflow of type 4 for printk
syncppp.o: Relocation overflow of type 4 for printk
syncppp.o: Relocation overflow of type 4 for printk
syncppp.o: Relocation overflow of type 4 for printk
syncppp.o: Relocation overflow of type 4 for printk
syncppp.o: Relocation overflow of type 4 for alloc_skb
syncppp.o: Relocation overflow of type 4 for memcpy
syncppp.o: Relocation overflow of type 4 for printk
syncppp.o: Relocation overflow of type 4 for printk
syncppp.o: Relocation overflow of type 4 for dev_queue_xmit
syncppp.o: Relocation overflow of type 4 for alloc_skb
syncppp.o: Relocation overflow of type 4 for printk
syncppp.o: Relocation overflow of type 4 for dev_queue_xmit
syncppp.o: Relocation overflow of type 4 for printk
syncppp.o: Relocation overflow of type 4 for add_timer
syncppp.o: Relocation overflow of type 4 for del_timer
syncppp.o: Relocation overflow of type 4 for kmalloc
syncppp.o: Relocation overflow of type 4 for memcpy
syncppp.o: Relocation overflow of type 4 for kfree
syncppp.o: Relocation overflow of type 4 for printk
syncppp.o: Relocation overflow of type 4 for printk
syncppp.o: Relocation overflow of type 4 for printk
syncppp.o: Relocation overflow of type 4 for sprintf
syncppp.o: Relocation overflow of type 4 for sprintf
syncppp.o: Relocation overflow of type 4 for printk
syncppp.o: Relocation overflow of type 4 for printk
syncppp.o: Relocation overflow of type 4 for printk
syncppp.o: Relocation overflow of type 4 for printk
syncppp.o: Relocation overflow of type 4 for dev_add_pack
syncppp.o: Relocation overflow of type 4 for dev_remove_pack


The kernel for the Cobalt Qube2 boxen is a Cobalt-crafted 2.0.34.

Does anybody have a clue on what could be the problem here???

Thanks in advance for your help.

Regards,
Ivan


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
