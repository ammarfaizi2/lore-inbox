Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263879AbTKGEzS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 23:55:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263883AbTKGEzS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 23:55:18 -0500
Received: from fw.osdl.org ([65.172.181.6]:28079 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263879AbTKGEzN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 23:55:13 -0500
Date: Thu, 6 Nov 2003 20:52:59 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: david nicol <whatever@davidnicol.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: funny crapping out in make bzImage
Message-Id: <20031106205259.283c8edf.rddunlap@osdl.org>
In-Reply-To: <1068177545.1013.234.camel@plaza.davidnicol.com>
References: <1068177545.1013.234.camel@plaza.davidnicol.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 06 Nov 2003 21:59:06 -0600 david nicol <whatever@davidnicol.com> wrote:

| 
| I had built test-6 -- do I need newer tools for test-9?
| 
| 
| make[1]: `arch/i386/kernel/asm-offsets.s' is up to date.
|   CHK     include/linux/compile.h
|   CC      fs/proc/array.o
| fs/proc/array.c: In function `proc_pid_stat':
| fs/proc/array.c:398: Unrecognizable insn:
| (insn/i 1337 1673 1667 (parallel[ 
|             (set (reg:SI 0 eax)
|                 (asm_operands ("") ("=a") 0[ 
|                         (reg:DI 1 edx)
|                     ] 
|                     [ 
|                         (asm_input:DI ("A"))
|                     ]  ("include/linux/times.h") 37))
|             (set (reg:SI 1 edx)
|                 (asm_operands ("") ("=d") 1[ 
|                         (reg:DI 1 edx)
|                     ] 
|                     [ 
|                         (asm_input:DI ("A"))
|                     ]  ("include/linux/times.h") 37))
|             (clobber (reg:QI 19 dirflag))
|             (clobber (reg:QI 18 fpsr))
|             (clobber (reg:QI 17 flags))
|         ] ) -1 (insn_list 1331 (nil))
|     (nil))
| fs/proc/array.c:398: confused by earlier errors, bailing out
| make[2]: *** [fs/proc/array.o] Error 1
| make[1]: *** [fs/proc] Error 2
| make: *** [fs] Error 2
| [david@plaza linux-2.6.0-test9
| -- 

This is gcc 2.96 ??
This problem has been reported multiple times.
Yes, you need a different gcc version, or there are a couple of
patches around that split up the code around line 398 into
smaller pieces that gcc 2.96 can handle.

--
~Randy
MOTD:  Always include version info.
