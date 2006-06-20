Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964806AbWFTHtO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964806AbWFTHtO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 03:49:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932497AbWFTHtN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 03:49:13 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:50117 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932316AbWFTHtM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 03:49:12 -0400
Message-ID: <4497A871.8000303@garzik.org>
Date: Tue, 20 Jun 2006 03:49:05 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>, Dave Jones <davej@redhat.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.17-git build breakage
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On the latest 'git pull', on x86-64 SMP 'make allmodconfig', I get the 
following build breakage:

1) myri10ge: needs iowrite64_copy from -mm

2) forcedeth: git tree conflict, Herbert sent a patch

3) pci-gart (ouch!) link: no fix seen yet

[...]
   LD      init/built-in.o
   LD      .tmp_vmlinux1
arch/x86_64/kernel/built-in.o: In function `pci_iommu_init':
arch/x86_64/kernel/pci-gart.c:619: undefined reference to `agp_amd64_init'
arch/x86_64/kernel/pci-gart.c:619: undefined reference to `agp_bridge'
arch/x86_64/kernel/pci-gart.c:619: undefined reference to `agp_copy_info'
make: *** [.tmp_vmlinux1] Error 1

