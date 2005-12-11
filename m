Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751354AbVLKMjv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751354AbVLKMjv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 07:39:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751355AbVLKMju
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 07:39:50 -0500
Received: from pilet.ens-lyon.fr ([140.77.167.16]:1235 "EHLO pilet.ens-lyon.fr")
	by vger.kernel.org with ESMTP id S1751354AbVLKMju (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 07:39:50 -0500
Date: Sun, 11 Dec 2005 13:39:57 +0100
From: Benoit Boissinot <bboissin@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-rc5-mm2
Message-ID: <20051211123957.GN8349@ens-lyon.fr>
References: <20051211041308.7bb19454.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051211041308.7bb19454.akpm@osdl.org>
X-Sieve: CMU Sieve 2.2
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/05, Andrew Morton <akpm@osdl.org> wrote:
>
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15-rc5/2.6.15-rc5-mm2/
>
> - Many new driver updates and architecture updates
>
> - New CPU scheduler policy: SCHED_BATCH.
>
> - New version of the hrtimers code.
>

Fix unused variable warning

Signed-off-by: Benoit Boissinot <benoit.boissinot@ens-lyon.org>

Index: linux/arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.c
===================================================================
--- linux.orig/arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.c
+++ linux/arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.c
@@ -305,10 +305,6 @@ acpi_cpufreq_cpu_init (
 	unsigned int		result = 0;
 	struct cpuinfo_x86 *c = &cpu_data[policy->cpu];
 
-	union acpi_object		arg0 = {ACPI_TYPE_BUFFER};
-	u32				arg0_buf[3];
-	struct acpi_object_list 	arg_list = {1, &arg0};
-
 	dprintk("acpi_cpufreq_cpu_init\n");
 
 	data = kzalloc(sizeof(struct cpufreq_acpi_io), GFP_KERNEL);
