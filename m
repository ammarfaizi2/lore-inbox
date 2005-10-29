Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750971AbVJ2M2I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750971AbVJ2M2I (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 08:28:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750977AbVJ2M2I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 08:28:08 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:53896 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S1750971AbVJ2M2H
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 08:28:07 -0400
Subject: Re: Intel D945GNT crashes with AGP enabled
From: Marcel Holtmann <marcel@holtmann.org>
To: Dave Jones <davej@redhat.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1130585267.5360.12.camel@blade>
References: <1130506715.5345.7.camel@blade>
	 <20051028162806.GA4340@redhat.com>  <1130518160.5372.6.camel@blade>
	 <1130585267.5360.12.camel@blade>
Content-Type: text/plain
Date: Sat, 29 Oct 2005 14:27:52 +0200
Message-Id: <1130588872.24907.1.camel@blade>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

> And btw why can't I compile the intelfb on x86_64? I use the internal
> graphics card (8086:2772) of the D945GNT motherboard.
> 
> 0000:00:02.0 VGA compatible controller: Intel Corporation 945G Integrated Graphics Controller (rev 02)
> 
> The Kconfig file makes it unselectable on x86_64 system.
> 
> config FB_INTEL
>         tristate "Intel 830M/845G/852GM/855GM/865G support (EXPERIMENTAL)"
>         depends on FB && EXPERIMENTAL && PCI && X86 && !X86_64
> 
> It seems that the most recent support in this driver is for the 915G and
> not for the 945G. Are they so different that we need a complete new
> driver or is the !X86_64 a relict from old times?

it seems that the first problem is:

arch/x86_64/kernel/built-in.o: In function `pci_iommu_init':
pci-gart.c:(.init.text+0x8f0c): undefined reference to `agp_amd64_init'
pci-gart.c:(.init.text+0x8f1a): undefined reference to `agp_bridge'
pci-gart.c:(.init.text+0x8f1f): undefined reference to `agp_copy_info'
make: *** [.tmp_vmlinux1] Error 1

Is this fixable or will the intelfb never work on x86_64 system?

Regards

Marcel


