Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266321AbUBQQgK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 11:36:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266323AbUBQQgK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 11:36:10 -0500
Received: from mail.timesys.com ([65.117.135.102]:63806 "EHLO
	exchange.timesys.com") by vger.kernel.org with ESMTP
	id S266321AbUBQQgG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 11:36:06 -0500
Message-ID: <403242DF.7030204@timesys.com>
Date: Tue, 17 Feb 2004 11:35:43 -0500
From: Pratik Solanki <pratik.solanki@timesys.com>
Organization: TimeSys Corporation
User-Agent: Mozilla Thunderbird 0.5 (X11/20040213)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
CC: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Minor cross-compile issues
References: <4027B7D3.2020107@timesys.com> <20040216205800.GC2977@mars.ravnborg.org>
In-Reply-To: <20040216205800.GC2977@mars.ravnborg.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 Feb 2004 16:29:11.0703 (UTC) FILETIME=[2CBB6A70:01C3F573]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/16/2004 03:58 PM, Sam Ravnborg wrote:

>On Mon, Feb 09, 2004 at 11:39:47AM -0500, Pratik Solanki wrote:
>  
>
>>Attached are 2 patches
>>
>>asm-boot.patch - Fixes include path for build.c so that it finds 
>>asm/boot.h. /usr/include/asm/boot.h may not be present when 
>>cross-compiling on a non-Linux machine.
>>    
>>
>OK - but see minor comemnt.
>
> 
>  
>
>>shell.patch - Use $(CONFIG_SHELL) instead of sh.
>>    
>>
>OK
>
>	Sam
>
>  
>
>>===== arch/i386/boot/Makefile 1.28 vs edited =====
>>--- 1.28/arch/i386/boot/Makefile	Thu Sep 11 06:01:23 2003
>>+++ edited/arch/i386/boot/Makefile	Thu Feb  5 15:56:28 2004
>>@@ -31,6 +31,8 @@
>> 
>> host-progs	:= tools/build
>> 
>>+HOSTCFLAGS_build.o := -I$(TOPDIR)/include
>>    
>>
>Do not use absolute paths here.
>
>  
>
>>+HOSTCFLAGS_build.o := -Iinclude
>>    
>>
>Is the preferred way to do it.
>  
>

Thanks Sam. Would you be checking in your proposed change or should I 
send a new patch?

Pratik.
