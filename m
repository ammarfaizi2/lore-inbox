Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262736AbTHUOWh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 10:22:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262739AbTHUOWh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 10:22:37 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:27077 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262736AbTHUOWf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 10:22:35 -0400
Message-ID: <3F44D59B.8040502@pobox.com>
Date: Thu, 21 Aug 2003 10:22:19 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: akpm@digeo.com
Subject: Re: [PATCH] missing io_apic.h inclusions
References: <200308210912.h7L9CUtW029374@hera.kernel.org>
In-Reply-To: <200308210912.h7L9CUtW029374@hera.kernel.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux Kernel Mailing List wrote:
> diff -Nru a/arch/i386/kernel/acpi/boot.c b/arch/i386/kernel/acpi/boot.c
> --- a/arch/i386/kernel/acpi/boot.c	Thu Aug 21 02:12:34 2003
> +++ b/arch/i386/kernel/acpi/boot.c	Thu Aug 21 02:12:34 2003
> @@ -34,6 +34,7 @@
>  #if defined (CONFIG_X86_LOCAL_APIC)
>  #include <mach_apic.h>
>  #include <mach_mpparse.h>
> +#include <asm/io_apic.h>
>  #endif
>  
>  #define PREFIX			"ACPI: "
> diff -Nru a/arch/i386/kernel/setup.c b/arch/i386/kernel/setup.c
> --- a/arch/i386/kernel/setup.c	Thu Aug 21 02:12:34 2003
> +++ b/arch/i386/kernel/setup.c	Thu Aug 21 02:12:34 2003
> @@ -43,6 +43,7 @@
>  #include <asm/setup.h>
>  #include <asm/arch_hooks.h>
>  #include <asm/sections.h>
> +#include <asm/io_apic.h>
>  #include "setup_arch_pre.h"
>  #include "mach_resources.h"


Well, the first change looks pretty wrong just given the config option. 
  And, too, this was the false "build fix".  The correct build fix was 
committed, and this patch was not needed at all.  I'll grant that the 
patch to setup.c does make sense, though, even if it's not strictly needed.

	Jeff


