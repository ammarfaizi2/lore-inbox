Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965934AbWKHWEn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965934AbWKHWEn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 17:04:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161361AbWKHWEm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 17:04:42 -0500
Received: from nf-out-0910.google.com ([64.233.182.186]:5901 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S965928AbWKHWEk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 17:04:40 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=sDDHg48vgka/i/PP9DqwXz/LiOHP6ZP8G9LmzAyF9OwbSlejkPIgJFws5zvez2hT4ca1bZdiZmRXtGJ6Lkt8O+NjCLrZqqQsCxCQ6HVOcirv8qbP/WdDaaV7ulr+65b5Tb2BKOOvvrIiB9ar6V8e3iEZGH9UtaK9zU9hLg/yvn0=
Date: Thu, 9 Nov 2006 01:04:35 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Dave Jones <davej@codemonkey.org.uk>, linux-kernel@vger.kernel.org
Subject: [PATCH] gx-suspmod: fix "&& 0xff" typo
Message-ID: <20061108220435.GA4972@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 arch/i386/kernel/cpu/cpufreq/gx-suspmod.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/i386/kernel/cpu/cpufreq/gx-suspmod.c
+++ b/arch/i386/kernel/cpu/cpufreq/gx-suspmod.c
@@ -473,7 +473,7 @@ static int __init cpufreq_gx_init(void)
 	pci_read_config_byte(params->cs55x0, PCI_MODON, &(params->on_duration));
 	pci_read_config_byte(params->cs55x0, PCI_MODOFF, &(params->off_duration));
         pci_read_config_dword(params->cs55x0, PCI_CLASS_REVISION, &class_rev);
-	params->pci_rev = class_rev && 0xff;
+	params->pci_rev = class_rev & 0xff;
 
 	if ((ret = cpufreq_register_driver(&gx_suspmod_driver))) {
 		kfree(params);

