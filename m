Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751155AbWFUTTs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751155AbWFUTTs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 15:19:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751236AbWFUTTs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 15:19:48 -0400
Received: from terminus.zytor.com ([192.83.249.54]:22914 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751155AbWFUTTr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 15:19:47 -0400
Message-ID: <44999BC5.7060702@zytor.com>
Date: Wed, 21 Jun 2006 12:19:33 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Martin Bligh <mbligh@mbligh.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, hpa@zytor.com
Subject: Re: 2.6.17-mm1
References: <44998DCB.1030703@mbligh.org> <20060621184814.GQ24595@inferi.kami.home>
In-Reply-To: <20060621184814.GQ24595@inferi.kami.home>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mattia Dongili wrote:
> On Wed, Jun 21, 2006 at 11:19:55AM -0700, Martin Bligh wrote:
>> Seems to dive into an endless loop in compile.
>>
>> http://test.kernel.org/abat/37068/debug/test.log.0
>>
>>   CHK     include/linux/compile.h
>>   UPD     include/linux/compile.h
>>   CC      init/version.o
>>   CC      init/initramfs.o
>>   CC      init/calibrate.o
>>   LD      init/built-in.o
>>   HOSTCC  usr/gen_init_cpio
>>   SYMLINK usr/include/asm -> include/asm-x86_64
>>   GEN     usr/klibc/syscalls/SYSCALLS.i
>>   GEN     usr/klibc/syscalls/syscalls.nrs
>>   GEN     usr/klibc/syscalls/typesize.c
>>   KLIBCCC usr/klibc/syscalls/typesize.o
>>   OBJCOPY usr/klibc/syscalls/typesize.bin
> [...]
>> etc etc. for ever.
>>
>> On both x86_64 and ppc64.
> 
> me too, on 586
> 
> .config is here: http://oioio.altervista.org/linux/config-2.6.17-mm1

I've uploaded the patch for this to:

http://www.kernel.org/pub/linux/kernel/people/hpa/klibc-2.6.17-mm1-circdep.patch

The klibc tree has additional fixes in it.

	-hpa
