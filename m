Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268799AbUHaSzP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268799AbUHaSzP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 14:55:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268802AbUHaSzP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 14:55:15 -0400
Received: from out001pub.verizon.net ([206.46.170.140]:62636 "EHLO
	out001.verizon.net") by vger.kernel.org with ESMTP id S268799AbUHaSyw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 14:54:52 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc1-mm2
Date: Tue, 31 Aug 2004 14:54:48 -0400
User-Agent: KMail/1.7
Cc: Andrew Morton <akpm@osdl.org>
References: <20040830235426.441f5b51.akpm@osdl.org>
In-Reply-To: <20040830235426.441f5b51.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200408311454.48673.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out001.verizon.net from [151.205.62.54] at Tue, 31 Aug 2004 13:54:49 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 31 August 2004 02:54, Andrew Morton wrote:
>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-
>rc1/2.6.9-rc1-mm2/
>
>Nothing particularly noteworthy here.  Some seriously bad scheduler
>performance with SMT and HT was fixed up, as was the
>fails-to-read-the-last-4k-of-a-file brown bag.
>
[...]

Couple of minor kconfig/compiler tummy aches:

scripts/kconfig/qconf arch/i386/Kconfig
Warning! Found recursive dependency: ACPI PCI_MMCONFIG ACPI ACPI_AC
Warning! Found recursive dependency: ACPI PCI_MMCONFIG ACPI 
ACPI_PROCESSOR X86_POWERNOW_K7_ACPI
Warning! Found recursive dependency: ACPI PCI_MMCONFIG ACPI 
ACPI_PROCESSOR X86_POWERNOW_K8_ACPI
Warning! Found recursive dependency: ACPI PCI_MMCONFIG ACPI ACPI_EC
Warning! Found recursive dependency: ACPI PCI_MMCONFIG ACPI 
ACPI_PROCESSOR X86_SPEEDSTEP_CENTRINO_ACPI
Warning! Found recursive dependency: DRM_I830 DRM_I915 DRM_I830

make modules_install
/usr/src/linux-2.6.9-rc1-mm2/scripts/Makefile.modinst:24: target 
`fs/nls/nls_koi8-r.ko' given more than once in the same rule.
/usr/src/linux-2.6.9-rc1-mm2/scripts/Makefile.modinst:24: target 
`fs/nls/nls_koi8-ru.ko' given more than once in the same rule.
/usr/src/linux-2.6.9-rc1-mm2/scripts/Makefile.modinst:24: target 
`fs/nls/nls_koi8-u.ko' given more than once in the same rule.

And, one other item that was minor till I had a stable system, and 
thats the apparently non-destruction of open paths when doing a 
reboot.  If *any* x based shells are open with a path to someplace,  
and I type a "rebootENTER" in one of them, then at umount time the 
kernel goes into its 3 tries and out routine, saying that partition 
so-and-so is busy.

But, I'm running on it, so like the Harley rider, it can't be all 
bad. :-)

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.24% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
