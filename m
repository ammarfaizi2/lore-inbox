Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422837AbWBIG7b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422837AbWBIG7b (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 01:59:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422838AbWBIG7b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 01:59:31 -0500
Received: from xenotime.net ([66.160.160.81]:9192 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1422837AbWBIG7b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 01:59:31 -0500
Date: Wed, 8 Feb 2006 23:00:09 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, ak@suse.de
Subject: Re: [PATCH/RFC] arch/x86_common: more formal reuse of i386+x86_64
 source code
Message-Id: <20060208230009.525ab514.rdunlap@xenotime.net>
In-Reply-To: <20060208225336.23539710.rdunlap@xenotime.net>
References: <20060208225336.23539710.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Feb 2006 22:53:36 -0800 Randy.Dunlap wrote:

> (not completed yet)
> (patch applies to 2.6.16-rc2)

oh, this really is an RFC.  I built x86_64 but haven't built i386 yet.
and the early_printk whitespace patch conflicts with this one.  :)

g/nite.


> Patch is 331 KB and is at
>   http://www.xenotime.net/linux/patches/x86-common1.patch
> 
> From: Randy Dunlap <rdunlap@xenotime.net>
> 
> Move lots of i386 & x86_64 common code into arch/x86_common/
> and modify Makefiles to use it from there.
> 
> Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
> ---
>  arch/i386/boot/edd.S                         |  176 --
>  arch/i386/boot/setup.S                       |    2
>  arch/i386/kernel/Makefile                    |    8
>  arch/i386/kernel/bootflag.c                  |   99 -
>  arch/i386/kernel/cpu/Makefile                |    2
>  arch/i386/kernel/cpu/intel_cacheinfo.c       |  655 ---------
>  arch/i386/kernel/cpuid.c                     |  245 ---
>  arch/i386/kernel/dmi_scan.c                  |  301 ----
>  arch/i386/kernel/early_printk.c              |    2
>  arch/i386/kernel/i8237.c                     |   67
>  arch/i386/kernel/microcode.c                 |  516 -------
>  arch/i386/kernel/msr.c                       |  326 ----
>  arch/i386/kernel/quirks.c                    |   51
>  arch/i386/mm/Makefile                        |    2
>  arch/i386/mm/hugetlbpage.c                   |  289 ----
>  arch/i386/pci/Makefile                       |   10
>  arch/i386/pci/acpi.c                         |   68
>  arch/i386/pci/common.c                       |  261 ---
>  arch/i386/pci/direct.c                       |  289 ----
>  arch/i386/pci/fixup.c                        |  467 ------
>  arch/i386/pci/i386.c                         |  295 ----
>  arch/i386/pci/irq.c                          | 1199 -----------------
>  arch/i386/pci/legacy.c                       |   56
>  arch/i386/pci/pci.h                          |   83 -
>  arch/x86_64/boot/setup.S                     |    2
>  arch/x86_64/kernel/Makefile                  |   16
>  arch/x86_64/kernel/early_printk.c            |  271 ---
>  arch/x86_64/mm/Makefile                      |    2
>  arch/x86_64/pci/Makefile                     |   19
>  arch/x86_common/boot/edd.S                   |  176 ++
>  arch/x86_common/kernel/bootflag.c            |   99 +
>  arch/x86_common/kernel/cpu/intel_cacheinfo.c |  655 +++++++++
>  arch/x86_common/kernel/cpuid.c               |  245 +++
>  arch/x86_common/kernel/dmi_scan.c            |  301 ++++
>  arch/x86_common/kernel/early_printk.c        |  271 +++
>  arch/x86_common/kernel/i8237.c               |   67
>  arch/x86_common/kernel/microcode.c           |  516 +++++++
>  arch/x86_common/kernel/msr.c                 |  326 ++++
>  arch/x86_common/kernel/quirks.c              |   51
>  arch/x86_common/mm/hugetlbpage.c             |  289 ++++
>  arch/x86_common/pci/acpi.c                   |   68
>  arch/x86_common/pci/common.c                 |  261 +++
>  arch/x86_common/pci/direct.c                 |  289 ++++
>  arch/x86_common/pci/fixup.c                  |  467 ++++++
>  arch/x86_common/pci/i386.c                   |  295 ++++
>  arch/x86_common/pci/irq.c                    | 1199 +++++++++++++++++
>  arch/x86_common/pci/legacy.c                 |   56
>  arch/x86_common/pci/pci.h                    |   83 +
>  48 files changed, 5759 insertions(+), 5734 deletions(-)
> 
> ---
> ~Randy


---
~Randy
