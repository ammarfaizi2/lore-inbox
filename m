Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261781AbVD0HHp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261781AbVD0HHp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 03:07:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261749AbVD0HGk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 03:06:40 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:12764 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261729AbVD0HBR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 03:01:17 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] cpuid x87 bit on AMD falsely marked as PNI
Date: Wed, 27 Apr 2005 10:00:29 +0300
User-Agent: KMail/1.5.4
Cc: Andi Kleen <ak@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.61.0504261851070.12903@montezuma.fsmlabs.com>
In-Reply-To: <Pine.LNX.4.61.0504261851070.12903@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504271000.29206.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 27 April 2005 04:20, Zwane Mwaikambo wrote:
> http://bugme.osdl.org/show_bug.cgi?id=4426
> 
> vendor_id       : AuthenticAMD
> cpu family      : 6
> model           : 10
> model name      : AMD Athlon(tm) XP
> stepping        : 0
> cpu MHz         : 2204.807
> <snipped>
> cpuid level     : 1
> wp              : yes
> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
> pat pse36 mmx fxsr sse pni syscall mmxext 3dnowext 3dnow
> bogomips        : 4358.14
> 
> We're marking bit 0 of extended function 0x80000001 cpuid as PNI support 
> on AMD processors, when it actually denotes x87 FPU present. Patch for 
> i386 and x86_64 below.

I just yesterday noticed that my Athlon (non-64bit) has 'pni' in CPU
flags and was very puzzled.

Thanks Zwane.
--
vda

