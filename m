Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279682AbRJYCVx>; Wed, 24 Oct 2001 22:21:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279683AbRJYCVo>; Wed, 24 Oct 2001 22:21:44 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:6140 "EHLO
	e33.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S279682AbRJYCVb>; Wed, 24 Oct 2001 22:21:31 -0400
Date: Wed, 24 Oct 2001 19:20:49 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Anton Petrusevich <casus@mail.ru>, linux-kernel@vger.kernel.org
Subject: Re: bios disables second cpu
Message-ID: <3223869972.1003951249@[10.10.1.2]>
In-Reply-To: <E15wZ4V-000Lbp-00@f10.mail.ru>
X-Mailer: Mulberry/2.0.5 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Something strange is going on. The server in question is dual P-III/850 on
> Intel 440GX+ board. Neither 2.4 nor 2.2 kernel doesn't see second cpu, but some
> APIC error. What's the problem? Here dmesg goes:
...
> Intel MultiProcessor Specification v1.1
>     Virtual Wire compatibility mode.
> OEM ID: INTEL    Product ID: Lancewood    APIC at: 0xFEE00000
> Processor #0 Pentium(tm) Pro APIC version 17
> I/O APIC #1 Version 17 at 0xFEC00000.
> Processors: 1

Looks like your MPS table is lacking. What happens if you do 
"phys_cpu_present_map = 3" at the end of smp_read_mpc() 
in arch/i386/kernel/mpparse.c ?

Martin.

