Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262591AbTKVSFc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Nov 2003 13:05:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262569AbTKVSFc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Nov 2003 13:05:32 -0500
Received: from smtp5.wanadoo.fr ([193.252.22.26]:56813 "EHLO
	mwinf0504.wanadoo.fr") by vger.kernel.org with ESMTP
	id S262591AbTKVSFW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Nov 2003 13:05:22 -0500
Message-ID: <3FBFA6DA.3070707@wanadoo.fr>
Date: Sat, 22 Nov 2003 19:11:38 +0100
From: Remi Colinet <remi.colinet@wanadoo.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:1.0.1) Gecko/20020830
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test9-mm5 : compile error
References: <3FBF5C79.5050409@wanadoo.fr> <Pine.LNX.4.53.0311220946280.2498@montezuma.fsmlabs.com> <3FBF99E6.1070402@wanadoo.fr> <Pine.LNX.4.53.0311221218350.2498@montezuma.fsmlabs.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo wrote:

>On Sat, 22 Nov 2003, Remi Colinet wrote:
>
>  
>
>>>Index: linux-2.6.0-test9-mm5/arch/i386/kernel/process.c
>>>===================================================================
>>>RCS file: /build/cvsroot/linux-2.6.0-test9-mm5/arch/i386/kernel/process.c,v
>>>retrieving revision 1.1.1.1
>>>diff -u -p -B -r1.1.1.1 process.c
>>>--- linux-2.6.0-test9-mm5/arch/i386/kernel/process.c	21 Nov 2003 20:59:15 -0000	1.1.1.1
>>>+++ linux-2.6.0-test9-mm5/arch/i386/kernel/process.c	21 Nov 2003 22:20:00 -0000
>>>@@ -50,6 +50,7 @@
>>>#include <asm/desc.h>
>>>#include <asm/tlbflush.h>
>>>#include <asm/cpu.h>
>>>+#include <asm/atomic_kmap.h>
>>>#ifdef CONFIG_MATH_EMULATION
>>>#include <asm/math_emu.h>
>>>#endif
>>>      
>>>
>>Just a point : in the file arch/i383/process.c, I added the  following 
>>lines.
>>
>>#include <asm/tlbflush.h>
>>#include <asm/cpu.h>
>>    
>>
>
>That was already in there.
>
>  
>
>>My original processs.c file seems to be a little be bit different from 
>>yours (?).
>>The following line was already in the process.c file.
>>
>>+#include <asm/atomic_kmap.h>
>>    
>>
>
>Hmm that's strange, can you verify your tree and i'll do the same. There 
>are two discrepancies.
>-
>
I have dowloaded linux-2.6.0-test9.tar.bz2 and 2.6.0-test9-mm5.bz2. Here 
is the begining of my arch/i386/kernel/process.c file after applying the 
mm patch :

40
41 #include <asm/uaccess.h>
42 #include <asm/pgtable.h>
43 #include <asm/system.h>
44 #include <asm/io.h>
45 #include <asm/ldt.h>
46 #include <asm/processor.h>
47 #include <asm/i387.h>
48 #include <asm/irq.h>
49 #include <asm/desc.h>
50 #include <asm/atomic_kmap.h>
51 #ifdef CONFIG_MATH_EMULATION
52 #include <asm/math_emu.h>
53 #endif
54
55 #include <linux/irq.h>
56 #include <linux/err.h>
57

The following line

#include <asm/atomic_kmap.h>

is in 2.6.0-test9-mm5 and not in 2.6.0-test9[-bk25]

These following lines are neither in bk or mm trees.

#include <asm/tlbflush.h>
#include <asm/cpu.h>

Remi

