Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964842AbWEYD75@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964842AbWEYD75 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 23:59:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964893AbWEYD75
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 23:59:57 -0400
Received: from ns1.suse.de ([195.135.220.2]:10988 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964842AbWEYD74 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 23:59:56 -0400
From: Andi Kleen <ak@suse.de>
To: discuss@x86-64.org
Subject: Re: [discuss] [PATCH 3/4] x86-64: Calgary IOMMU - IOMMU abstractions
Date: Thu, 25 May 2006 05:59:50 +0200
User-Agent: KMail/1.9.1
Cc: Jon Mason <jdmason@us.ibm.com>, Muli Ben-Yehuda <muli@il.ibm.com>,
       Muli Ben-Yehuda <mulix@mulix.org>,
       Linux-Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
References: <20060525033631.GE7720@us.ibm.com>
In-Reply-To: <20060525033631.GE7720@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605250559.51076.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 /* Must execute after PCI subsystem */
-fs_initcall(pci_iommu_init);
+fs_initcall(gart_iommu_init);

This change is wrong too and even throws a warning. gart_iommu_init is already
called elsewhere.

-Andi

