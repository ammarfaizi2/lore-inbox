Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932514AbWACT4p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932514AbWACT4p (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 14:56:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932516AbWACT4p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 14:56:45 -0500
Received: from vvv.conterra.de ([212.124.44.162]:20668 "EHLO conterra.de")
	by vger.kernel.org with ESMTP id S932514AbWACT4o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 14:56:44 -0500
Message-ID: <43BAD6F4.6080605@conterra.de>
Date: Tue, 03 Jan 2006 20:56:36 +0100
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

Andi Kleen wrote:
> Does everything work (including the SKGE) driver
> when you boot with swiotlb=force ? 

Yes, it seems to work so far! I'm just reading some GB via NFS (while writing this
mail on the same host). I already performed some other test: without initializing the
network (and still without swiotlb=force) all my SATA controller seem to work properly.
I did a "dd bs=400M" on each in parallel. So I'm sure that each of my 4G was involved.
(also I'm not sure, if EACH of my 3 controllers really used something above 3G)

All this was still with an unpatched 2.6.15-rc7 and with IOMMU disabled.
So I could either try "iommu=allowed", as suggested by dmesg from
check_ioapic() or I may apply the suggested patch for pci-gart.c,
or both with and without network....

May be I report about soon, else tomorrow.

Dieter.
-- 
Dieter Stüken, con terra GmbH, Münster
     stueken@conterra.de
     http://www.conterra.de/
     (0)251-7474-501
