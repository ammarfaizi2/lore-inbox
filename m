Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268438AbTBNPWj>; Fri, 14 Feb 2003 10:22:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268439AbTBNPWj>; Fri, 14 Feb 2003 10:22:39 -0500
Received: from franka.aracnet.com ([216.99.193.44]:9946 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S268438AbTBNPWh>; Fri, 14 Feb 2003 10:22:37 -0500
Date: Fri, 14 Feb 2003 07:32:18 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: suparna@in.ibm.com, fastboot@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [KEXEC][PATCH] Modified (smaller) x86 kexec hwfixes patch
Message-ID: <53360000.1045236737@[10.10.2.4]>
In-Reply-To: <m165rn8dpz.fsf@frodo.biederman.org>
References: <20030213161014.A14361@in.ibm.com>
 <m1heb8w737.fsf@frodo.biederman.org>
 <20030214085915.A1466@in.ibm.com><51710000.1045205264@[10.10.2.4]>
 <m165rn8dpz.fsf@frodo.biederman.org>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Running on my 4-way P3 test box (just SMP, not NUMA) kexec_test
>> prints this:
>> 
>> Synchronizing SCSI caches: 
>> Shutting down devices
>> Starting new kernel
>> kexec_test 1.8 starting...
>> eax: 0E1FB007 ebx: 0000011C ecx: 00000000 edx: 00000000
>> esi: 00000000 edi: 00000000 esp: 00000000 ebp: 00000000
>> idt: 00000000 C0000000
>> gdt: 0000006F 000000A0
>> Switching descriptors.
>> Descriptors changed.
>> Legacy pic setup.
>> In real mode.
>> 
>> Without that I just get:
>> 
>> Synchronizing SCSI caches: 
>> Shutting down devices
>> Starting new kernel
>> 
>> Can someone interpret?
> 
> Besides the fact that you cannot make BIOS calls, and kexec is working
> there is not much to say.  You cannot kexec another kernel?

Nope, if I just kexec the same 2.5.59 kernel+kexec patches that I'm booted
on it says: 

Synchronizing SCSI caches: 
Shutting down devices
Starting new kernel

Could you give me a high-level sketch of what you're doing? kexec -l loads
the new kernel, then what do you do? Drop back into real mode and jump to
the normal kernel entry point? Or decompress by hand, do some alternate
setup of the early page tables and try to jump in at the 32-bit entry point?

Is all I can assume from the above that I crash in the new kernel before
console_init()? Or should I expect something from the decompress code?

Thanks,

M.
