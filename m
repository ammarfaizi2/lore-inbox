Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750770AbVJ3O6U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750770AbVJ3O6U (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 09:58:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750777AbVJ3O6U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 09:58:20 -0500
Received: from ns1.suse.de ([195.135.220.2]:42708 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750770AbVJ3O6T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 09:58:19 -0500
From: Andi Kleen <ak@suse.de>
To: Nishanth Aravamudan <nacc@us.ibm.com>
Subject: Re: PCI-DMA: high address but no IOMMU
Date: Sun, 30 Oct 2005 15:59:15 +0100
User-Agent: KMail/1.8.2
Cc: Michael Madore <michael.madore@gmail.com>, linux-kernel@vger.kernel.org
References: <d4b6d3ea0510271047t413e9ea8l333a532c1a5f3d77@mail.gmail.com> <20051028015900.GB4141@us.ibm.com> <20051030142924.GA30183@us.ibm.com>
In-Reply-To: <20051030142924.GA30183@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510301559.15423.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 30 October 2005 15:29, Nishanth Aravamudan wrote:

> 
> Ah, silly me, I set IOMMU_DEBUG to Y at some point without realizing.
> Taking that away removed the issues and I now only get:
> 
> [    0.000000] Checking aperture...
> [    0.000000] CPU 0: aperture @ 4000000 size 32 MB
> [    0.000000] Aperture from northbridge cpu 0 too small (32 MB)
> [    0.000000] No AGP bridge found
> 
> ...
> 
> [   47.737770] PCI-DMA: Disabling IOMMU.
> 
> Which makes a lot more sense.

And everything works when you disable IOMMU_DEBUG? Is that the case
with the other reporters of this problem too?

-Andi
