Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261270AbUBDNWB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 08:22:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261881AbUBDNWB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 08:22:01 -0500
Received: from galileo.bork.org ([66.11.174.156]:26032 "HELO galileo.bork.org")
	by vger.kernel.org with SMTP id S261270AbUBDNV6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 08:21:58 -0500
Date: Wed, 4 Feb 2004 08:21:57 -0500
From: Martin Hicks <mort@bork.org>
To: Uher Marek <Marek.Uher@t-mobile.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problem with NUMA kernel on IBM xSeries 455 server
Message-ID: <20040204132157.GA3387@localhost>
References: <6D2F48AA9477864682B4078EFF1BEAF1057F0B7D@RDMKSPE02.rdm.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6D2F48AA9477864682B4078EFF1BEAF1057F0B7D@RDMKSPE02.rdm.cz>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, Feb 04, 2004 at 01:46:33PM +0100, Uher Marek wrote:
> 
> 	Hi all,
> 
> I have a problem with running Linux on my IBM xSeries 455 server (4 x Intel 
> Xeon MP CPU 2.80GHz, 8 GB RAM). I have tried to compile kernel 2.6.2 with
> Summit/EXA (IBM x440) NUMA support, high memory support (64GB), NUMA memory
> allocation support, ACPI and ACPI NUMA support. When I have tried to make
> bzImage I have got this messages:
> 
> drivers/built-in.o(.init.text+0x1751): In function `acpi_parse_slit': 
> : undefined reference to `acpi_numa_slit_init'
> drivers/built-in.o(.init.text+0x176d): In function `acpi_parse_processor_affinit
> y':
> : undefined reference to `acpi_numa_processor_affinity_init'
> drivers/built-in.o(.init.text+0x1791): In function `acpi_parse_memory_affinity':
> : undefined reference to `acpi_numa_memory_affinity_init'
> drivers/built-in.o(.init.text+0x1850): In function `acpi_numa_init':
> : undefined reference to `acpi_numa_arch_fixup'
> make: *** [.tmp_vmlinux1] Error 1
> 
> Do you have any idea? I don't know what is wrong.

According to include/linux/acpi.h these functions are platform
dependent.  There are ia64 versions, but I don't see them for non-ia64
arches.

This is the problem.  I don't know anything about Summit, so maybe
someone else can better help you.  Perhaps there is an extra summit
patch somewhere?  Or maybe you must turn off ACPI for this machine,
although that seems unlikely.

mh

-- 
Martin Hicks || mort@bork.org || PGP/GnuPG: 0x4C7F2BEE
