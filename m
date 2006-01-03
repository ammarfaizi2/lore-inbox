Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964828AbWACVJf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964828AbWACVJf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 16:09:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964841AbWACVJd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 16:09:33 -0500
Received: from vvv.conterra.de ([212.124.44.162]:61119 "EHLO conterra.de")
	by vger.kernel.org with ESMTP id S964830AbWACVJD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 16:09:03 -0500
Message-ID: <43BAE7E3.6070504@conterra.de>
Date: Tue, 03 Jan 2006 22:08:51 +0100
From: =?ISO-8859-1?Q?Dieter_St=FCken?= <stueken@conterra.de>
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: X86_64 + VIA + 4g problems
References: <43B90A04.2090403@conterra.de> <p73k6difvm3.fsf@verdi.suse.de>	<43BA4C3D.4060206@conterra.de> <p731wzpjtvm.fsf@verdi.suse.de>
In-Reply-To: <p731wzpjtvm.fsf@verdi.suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, here are my last results for today:

using "iommu=allowed" did not work. System freezes during initialization
of the PDC20318, which is on the external PCI bus.

But swiotlb=force works well!

Using the patch for pci-gart.c currently works while reading data
on all 8 disks in parallel, reading data via NFS and writing this mail.

The pci-gart.c patch seems to disable dma. Is this the DMA my PCI devices
perform them self? As I learned, they may perform DMA even above 4g if all
works well. Thus I may be happy without any IOMMU. As I saw my system working
even without this patch, I will turn back to the original 2.6.15-rc7 an continue
running this torture test during this night.

Dieter.
-- 
Dieter Stüken, con terra GmbH, Münster
     stueken@conterra.de
     http://www.conterra.de/
     (0)251-7474-501
