Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262604AbVCPOcv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262604AbVCPOcv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 09:32:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262602AbVCPObq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 09:31:46 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:7631 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262601AbVCPObb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 09:31:31 -0500
Date: Wed, 16 Mar 2005 14:31:30 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, riel@redhat.com,
       kurt@garloff.de, Ian.Pratt@cl.cam.ac.uk, Christian.Limpach@cl.cam.ac.uk
Subject: Re: [PATCH] Xen/i386 cleanups - AGP bus/phys cleanups
Message-ID: <20050316143130.GA21959@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Keir Fraser <Keir.Fraser@cl.cam.ac.uk>,
	linux-kernel@vger.kernel.org, akpm@osdl.org, riel@redhat.com,
	kurt@garloff.de, Ian.Pratt@cl.cam.ac.uk,
	Christian.Limpach@cl.cam.ac.uk
References: <E1DBX0o-0000sV-00@mta1.cl.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1DBX0o-0000sV-00@mta1.cl.cam.ac.uk>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2005 at 11:48:29AM +0000, Keir Fraser wrote:
> This patch cleans up AGP driver treatment of bus/device memory. Every
> use of virt_to_phys/phys_to_virt should properly be converting between
> virtual and bus addresses: this distinction really matters for the Xen
> hypervisor.

It's bogus either way.  You must never use virt_to_phys or virt_to_bus
for bus address.  For systems with an IOMMU there's no 1:1 mapping.

