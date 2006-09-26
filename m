Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751204AbWIZMpr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751204AbWIZMpr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 08:45:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751308AbWIZMpq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 08:45:46 -0400
Received: from hellhawk.shadowen.org ([80.68.90.175]:27411 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S1751204AbWIZMpq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 08:45:46 -0400
Message-ID: <451920C8.6030909@shadowen.org>
Date: Tue, 26 Sep 2006 13:44:56 +0100
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060812)
MIME-Version: 1.0
To: Jeremy Fitzhardinge <jeremy@goop.org>
CC: Martin Bligh <mbligh@google.com>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>, LKML <linux-kernel@vger.kernel.org>,
       Ian Campbell <Ian.Campbell@XenSource.com>
Subject: Re: 2.6.18-mm1 compile failure on x86_64
References: <45185A93.7020105@google.com> <4518DC0B.10207@shadowen.org> <4518E4DF.8010007@goop.org>
In-Reply-To: <4518E4DF.8010007@goop.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeremy Fitzhardinge wrote:
> Andy Whitcroft wrote:
>> Martin Bligh wrote:
>>  
>>> http://test.kernel.org/abat/49037/debug/test.log.0  
>>>   AS      arch/x86_64/boot/bootsect.o
>>>   LD      arch/x86_64/boot/bootsect
>>>   AS      arch/x86_64/boot/setup.o
>>>   LD      arch/x86_64/boot/setup
>>>   AS      arch/x86_64/boot/compressed/head.o
>>>   CC      arch/x86_64/boot/compressed/misc.o
>>>   OBJCOPY arch/x86_64/boot/compressed/vmlinux.bin
>>> BFD: Warning: Writing section `.data.percpu' to huge (ie negative) file
>>> offset 0x804700c0.
>>> /usr/local/autobench/sources/x86_64-cross/gcc-3.4.0-glibc-2.3.2/bin/x86_64-unknown-linux-gnu-objcopy:
>>>
>>> arch/x86_64/boot/compressed/vmlinux.bin: File truncated
>>> make[2]: *** [arch/x86_64/boot/compressed/vmlinux.bin] Error 1
>>> make[1]: *** [arch/x86_64/boot/compressed/vmlinux] Error 2
>>> make: *** [bzImage] Error 2
>>> 09/25/06-09:13:48 Build the kernel. Failed rc = 2
>>> 09/25/06-09:13:49 build: kernel build Failed rc = 1
>>>
>>> Wierd. Same box compiled 2.6.18 fine.
>>>     
>>
>> Pretty sure this isn't a space problem, as we have just checked space
>> before the build and I've taken no action since then.  Someone did
>> mention "tool chain issue" when it was first spotted.  Will check with
>> them and see why they thought that.
>>   
> 
> Does this box have an older version of binutils (2.15?)?  If so, it
> might be getting upset over the patch "note-section" in Andi's queue.  I
> know it has been a bit problematic, but I don't know if the problems
> manifest in this way.

Sure does:

ii  binutils       2.14.90.0.7-8  The GNU assembler, linker and binary
utiliti

Thanks for the hint I'll try backing it out and see.

-apw
