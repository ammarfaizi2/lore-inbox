Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264916AbUA0S5e (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 13:57:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265363AbUA0S5e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 13:57:34 -0500
Received: from gw2.cosmosbay.com ([195.115.130.129]:48092 "EHLO
	gw2.cosmosbay.com") by vger.kernel.org with ESMTP id S264916AbUA0S51
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 13:57:27 -0500
Message-ID: <4016B493.9050404@cosmosbay.com>
Date: Tue, 27 Jan 2004 19:57:23 +0100
From: dada1 <dada1@cosmosbay.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: linux-2.6.1 x86_64 : STACK_TOP and text/data
References: <OFCE30A640.024A04A1-ONC1256E28.003023EA-C1256E28.0030BF4E@de.ibm.com.suse.lists.linux.kernel>	<40162E9A.1080005@cosmosbay.com.suse.lists.linux.kernel> <p73k73dfdvs.fsf@nielsen.suse.de>
In-Reply-To: <p73k73dfdvs.fsf@nielsen.suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:

> STACK_TOP is only for 32bit a.out executables running on x86-64
>
>ELF 32bit and 64bit programs use different defaults.
>
>-Andi
>
>
>  
>
Hi Andi

I'm afraid not Andi

I changed include/asm-x86_64/a.out.h

#define STACK_TOP  0x10c0000000   /* instead of 0xc0000000 */

then, after reboot :

file /sbin/init
/sbin/init: ELF 64-bit LSB executable, AMD x86-64, version 1 (SYSV), for 
GNU/Linux 2.4.0, dynamically linked (uses shared libs), stripped


cat /proc/1/maps

00400000-00408000 r-xp 00000000 03:01 556032                             
/sbin/init
00508000-00509000 rw-p 00008000 03:01 556032                             
/sbin/init
00509000-0052a000 rwxp 00000000 00:00 0
10bfffe000-10c0000000 rwxp fffffffffffff000 00:00 0
2a95556000-2a95569000 r-xp 00000000 03:01 637734                         
/lib64/ld-2.3.2.so
2a95569000-2a9556a000 rw-p 00000000 00:00 0
2a95669000-2a9566a000 rw-p 00013000 03:01 637734                         
/lib64/ld-2.3.2.so
2a9566a000-2a957a2000 r-xp 00000000 03:01 637741                         
/lib64/libc-2.3.2.so
2a957a2000-2a9586a000 ---p 00138000 03:01 637741                         
/lib64/libc-2.3.2.so
2a9586a000-2a958a7000 rw-p 00100000 03:01 637741                         
/lib64/libc-2.3.2.so
2a958a7000-2a958ac000 rw-p 00000000 00:00 0

See you

