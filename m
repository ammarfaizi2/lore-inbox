Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262208AbSJZPAC>; Sat, 26 Oct 2002 11:00:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262213AbSJZPAC>; Sat, 26 Oct 2002 11:00:02 -0400
Received: from franka.aracnet.com ([216.99.193.44]:47839 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S262208AbSJZPAB>; Sat, 26 Oct 2002 11:00:01 -0400
Date: Sat, 26 Oct 2002 08:03:45 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: "Martin J. Bligh" <mbligh@aracnet.com>
To: Alan Cox <alan@redhat.com>, Dave Jones <davej@codemonkey.org.uk>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Double x86 initialise fix.
Message-ID: <3007933349.1035619425@[10.10.2.3]>
In-Reply-To: <3007712682.1035619204@[10.10.2.3]>
References: <3007712682.1035619204@[10.10.2.3]>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Isn't this always the case on x86 ?
>>> /me waits to hear gory details of some IBM monster.
>> 
>> It isnt. The boot CPU may be any number. In addition you can strap dual
>> pentium boxes to arbitrate for who is boot cpu (this is used for fault
>> tolerance).
> 
> Eh? I don't understand this, and I think Dave is right for all the
> IBM monsters I know of ;-) The *apicid* may not be 0 but the CPU
> numbers are dynamically assigned as we boot, so the boot CPU will
> always get 0, surely?

Indeed cscope indicates these are acutally hardcoded into the calls:

1 smpboot.c smp_callin    418 smp_store_cpu_info(cpuid);
2 smpboot.c smp_boot_cpus 989 smp_store_cpu_info(0);

The only thing that does smp_callin is a secondary ... so the boot
CPU has this hardcoded to 0 ... I think Dave's fine.

M.

