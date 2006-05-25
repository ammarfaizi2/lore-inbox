Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964864AbWEYDyc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964864AbWEYDyc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 23:54:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964881AbWEYDyc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 23:54:32 -0400
Received: from mail.suse.de ([195.135.220.2]:42987 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964864AbWEYDyb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 23:54:31 -0400
From: Andi Kleen <ak@suse.de>
To: Jon Mason <jdmason@us.ibm.com>
Subject: Re: [PATCH 1/4] x86-64: Calgary IOMMU - introduce iommu_detected
Date: Thu, 25 May 2006 05:54:23 +0200
User-Agent: KMail/1.9.1
Cc: Muli Ben-Yehuda <muli@il.ibm.com>, Muli Ben-Yehuda <mulix@mulix.org>,
       Linux-Kernel <linux-kernel@vger.kernel.org>, discuss@x86-64.org,
       Andrew Morton <akpm@osdl.org>
References: <20060525033408.GC7720@us.ibm.com>
In-Reply-To: <20060525033408.GC7720@us.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200605250554.23534.ak@suse.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 25 May 2006 05:34, Jon Mason wrote:
> swiotlb relies on the gart specific iommu_aperture variable to know if
> we discovered a hardware IOMMU before swiotlb initialization.  Introduce
> iommu_detected to do the same thing, but in a HW IOMMU neutral manner,
> in preparation for adding the Calgary HW IOMMU.

I applied them all.

But I think you broke the aperture setup. iommu_setup really
needs to be called early, otherwise aperture.c doesn't get
the right parameters.  I undid that change.

And please next time send against the latest tree. It required
quite some tweaking to apply.

-Andi
