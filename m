Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262717AbVCPR67@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262717AbVCPR67 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 12:58:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262718AbVCPR67
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 12:58:59 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:45968 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262717AbVCPR6L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 12:58:11 -0500
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
Subject: Re: [PATCH] Xen/i386 cleanups - AGP bus/phys cleanups
Date: Wed, 16 Mar 2005 09:54:32 -0800
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, riel@redhat.com,
       kurt@garloff.de, Ian.Pratt@cl.cam.ac.uk, Christian.Limpach@cl.cam.ac.uk
References: <E1DBX0o-0000sV-00@mta1.cl.cam.ac.uk>
In-Reply-To: <E1DBX0o-0000sV-00@mta1.cl.cam.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503160954.33000.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, March 16, 2005 3:48 am, Keir Fraser wrote:
> This patch cleans up AGP driver treatment of bus/device memory. Every
> use of virt_to_phys/phys_to_virt should properly be converting between
> virtual and bus addresses: this distinction really matters for the Xen
> hypervisor.
>
> Furthermore, when allocating the GATT, it is necessary to use
> dma_alloc_coherent rather than get_free_pages.  Again, not a
> distinction that matters for i386, but very important for Xen and
> possibly for other architectures too.
>
> Signed-off-by: Keir Fraser <keir@xensource.com>

Ugg, if we're messing with these drivers we may as well fix them properly 
rather than adding in more uses of the broken virt_to_bus interface...

Jesse
