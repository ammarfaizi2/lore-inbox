Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262481AbUCLTos (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 14:44:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262470AbUCLTms
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 14:42:48 -0500
Received: from sea2-f60.sea2.hotmail.com ([207.68.165.60]:60430 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S262461AbUCLTjR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 14:39:17 -0500
X-Originating-IP: [217.132.113.208]
X-Originating-Email: [zstingx@hotmail.com]
From: "sting sting" <zstingx@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: do_brk() trace  mystery 
Date: Fri, 12 Mar 2004 21:39:15 +0200
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <Sea2-F60clKZMX3rQvx00046766@hotmail.com>
X-OriginalArrivalTime: 12 Mar 2004 19:39:16.0113 (UTC) FILETIME=[B4344810:01C40869]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
for debugging purpoese I had used the strace utilitty.
The command I had traced with starce was
"cat /proc/interrupts".

Well , I saw that there were not a few calls to the brk() system calls.

What I know is the brk() is a system call that is intended to enlarge 
procees
memory and is supposed to be called by the memory manager when sensing
that a process needs more memory.

But I did a search on the kernel tree fo do_brk()
and I found only 5 entries (in 2.6 kernel and also in 2.4.24).
One of the was the declaration in mm.h; the other was
implementation in mmap.c


Now the 2 others were in binfmt_out.c and in binfmt_elf.c

(in 2.4.20 it is also in ksyms.c ; in 2.6 it is not but it is in mm/nommu.c)


So the mystery is : who calls the brk() system call when I type
"cat /proc/interrupts"

It does not seem to me that it is  binfmt_out.c and in binfmt_elf.c (Or am I 
wrong)?


(BTW,searching for sys_mmap gives 2 results:
\linux-2.4.24\arch\i386\kernel\sys_i386.c
and the entry.s file)


regards,
Sting

_________________________________________________________________
Add photos to your messages with MSN 8. Get 2 months FREE*. 
http://join.msn.com/?page=features/featuredemail

