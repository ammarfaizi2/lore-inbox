Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262285AbRERJaK>; Fri, 18 May 2001 05:30:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262286AbRERJaA>; Fri, 18 May 2001 05:30:00 -0400
Received: from ams8uucp0.ams.ops.eu.uu.net ([212.153.111.69]:1952 "EHLO
	ams8uucp0.ams.ops.eu.uu.net") by vger.kernel.org with ESMTP
	id <S262285AbRERJ3q>; Fri, 18 May 2001 05:29:46 -0400
Date: Fri, 18 May 2001 11:17:44 +0200 (CEST)
From: kees <kees@schoen.nl>
To: "Andrea Dell'Amico" <adellam@link.it>
cc: linux-kernel@vger.kernel.org
Subject: Re: smp hangs with 2.2.19 kernel
In-Reply-To: <990095136.29185.5.camel@altrove>
Message-ID: <Pine.LNX.4.21.0105181112430.9618-100000@schoen3.schoen.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have solid hangs (no log) with SMP machine for some time. I swapped
almost all of the hardware (incl mobo).
Dual PIII 677 MHZ on MSI 694D mobo. I had the hangs with 2.2.19 AND now
also with 2.4.4. I linked the kdb in the kernel and when the lockup
occurred I was able the get some info (serial console).

This is the kdb output for linux-2.4.4

[1]kdb> rd
eax = 0x00000001 ebx = 0xc0c57bc0 ecx = 0x00000020 edx = 0x00000001 
esi = 0xc03de880 edi = 0x00000004 esp = 0xc2137ed0 eip = 0xc0108b6a 
ebp = 0xc2137edc xss = 0x00000018 xcs = 0x00000010 eflags = 0x00000002 
xds = 0xc1220018 xes = 0xc03d0018 origeax = 0x00000001 &regs = 0xc2137e9c
[1]kdb> 

[1]kdb> cpu
Currently on cpu 1
Available cpus: 0*, 1
[1]kdb> 

[1]kdb> bt
    EBP       EIP         Function(args)
0xc2137edc 0xc0108b6a handle_IRQ_event+0x2e (0x4, 0xc2137f10, 0xc0c57bc0, 0xc2a98005, 0x0)
                               kernel .text 0xc0100000 0xc0108b3c 0xc0108bc4
           0xc0108d9c do_IRQ+0xa8
                               kernel .text 0xc0100000 0xc0108cf4 0xc0108df0
           0xc0106e10 ret_from_intr
                               kernel .text 0xc0100000 0xc0106e10 0xc0106e30
Interrupt registers:
eax = 0x0000006b ebx = 0xc2a98005 ecx = 0xc2137fa0 edx = 0xc2a98001 
esi = 0x00000000 edi = 0xc12cc7e0 esp = 0xc2137f44 eip = 0xc013f183 
ebp = 0xc2137f68 xss = 0x00000018 xcs = 0x00000010 eflags = 0x00000216 
xds = 0xc2a90018 xes = 0xc2a90018 origeax = 0xffffff04 &regs = 0xc2137f10
           0xc013f183 path_walk+0x24f (0xc2a98006, 0xc2137fa0)
                               kernel .text 0xc0100000 0xc013ef34 0xc013f7f0
0xc2137f84 0xc013fcd0 __user_walk+0x3c (0x805c808, 0x9, 0xc2137fa0)
                               kernel .text 0xc0100000 0xc013fc94 0xc013fcf0
0xc2137fbc 0xc013c33b sys_newstat+0x17 (0x805c808, 0xbfffed28, 0x805c808, 0xbfffee34, 0x805c808)
                               kernel .text 0xc0100000 0xc013c324 0xc013c394
           0xc0106d37 system_call+0x37
                               kernel .text 0xc0100000 0xc0106d00 0xc0106d40
[1]kdb> 

What can I do next? I have the bt for all processes in a file.

regards

Kees

