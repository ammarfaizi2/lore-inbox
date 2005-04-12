Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262075AbVDLJb4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262075AbVDLJb4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 05:31:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262076AbVDLJb4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 05:31:56 -0400
Received: from mail.sf-mail.de ([62.27.20.61]:28113 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S262075AbVDLJbw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 05:31:52 -0400
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/6]init call cleanup
Date: Tue, 12 Apr 2005 11:32:29 +0200
User-Agent: KMail/1.7.2
Cc: Li Shaohua <shaohua.li@intel.com>,
       ACPI-DEV <acpi-devel@lists.sourceforge.net>,
       Len Brown <len.brown@intel.com>, Pavel Machek <pavel@suse.cz>,
       Zwane Mwaikambo <zwane@linuxpower.ca>, Andrew Morton <akpm@osdl.org>
References: <1113283855.27646.428.camel@sli10-desk.sh.intel.com>
In-Reply-To: <1113283855.27646.428.camel@sli10-desk.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504121132.30027@bilbo.math.uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Li Shaohua wrote:
> Trival patch for CPU hotplug. In CPU identify  part, only did cleaup for
> intel CPUs. Need do for other CPUs if they support S3 SMP.
>
> @@ -405,7 +405,7 @@ void __init init_bsp_APIC(void)
>  	apic_write_around(APIC_LVT1, value);
>  }
>
> -void __init setup_local_APIC (void)
> +void __devinit setup_local_APIC (void)
                                  ^

>  {
>  	unsigned long oldvalue, value, ver, maxlvt;
>

Please remove this space while you are at it.

> @@ -556,7 +556,7 @@ void __init early_cpu_init(void)
>   * and IDT. We reload them nevertheless, this function acts as a
>   * 'CPU state barrier', nothing should get across.
>   */
> -void __init cpu_init (void)
> +void __devinit cpu_init (void)
>  {
>  	int cpu = smp_processor_id();
>  	struct tss_struct * t = &per_cpu(init_tss, cpu);

This one too.

Eike
