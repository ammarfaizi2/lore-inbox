Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261177AbULHKnF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261177AbULHKnF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 05:43:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261181AbULHKnE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 05:43:04 -0500
Received: from [213.146.154.40] ([213.146.154.40]:18324 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261180AbULHKm5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 05:42:57 -0500
Date: Wed, 8 Dec 2004 10:42:56 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Ian Pratt <Ian.Pratt@cl.cam.ac.uk>
Cc: linux-kernel@vger.kernel.org, Steven.Hand@cl.cam.ac.uk,
       Christian.Limpach@cl.cam.ac.uk, Keir.Fraser@cl.cam.ac.uk, akpm@osdl.org
Subject: Re: [1/6] Xen VMM #4: add ptep_establish_new to make va available
Message-ID: <20041208104256.GA29779@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Ian Pratt <Ian.Pratt@cl.cam.ac.uk>, linux-kernel@vger.kernel.org,
	Steven.Hand@cl.cam.ac.uk, Christian.Limpach@cl.cam.ac.uk,
	Keir.Fraser@cl.cam.ac.uk, akpm@osdl.org
References: <E1CbwFE-0006PZ-00@mta1.cl.cam.ac.uk> <E1CbwFx-0006QL-00@mta1.cl.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1CbwFx-0006QL-00@mta1.cl.cam.ac.uk>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 08, 2004 at 07:29:01AM +0000, Ian Pratt wrote:
> 
> This patch adds 'ptep_establish_new', in keeping with the
> existing 'ptep_establish', but for use where a mapping is being
> established where there was previously none present. This
> function is useful (rather than just using set_pte) because
> having the virtual address available enables a very important
> optimisation for arch-xen. We introduce
> HAVE_ARCH_PTEP_ESTABLISH_NEW and define a generic implementation
> in asm-generic/pgtable.h, following the pattern of the existing
> ptep_establish.

I thought we preffered DaveM's more generic patch instead of this one?

