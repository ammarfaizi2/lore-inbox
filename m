Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262709AbUKRKLb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262709AbUKRKLb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 05:11:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262713AbUKRKLb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 05:11:31 -0500
Received: from phoenix.infradead.org ([81.187.226.98]:43783 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262709AbUKRKLM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 05:11:12 -0500
Date: Thu, 18 Nov 2004 10:11:09 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Ian Pratt <Ian.Pratt@cl.cam.ac.uk>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, Keir.Fraser@cl.cam.ac.uk,
       Christian.Limpach@cl.cam.ac.uk
Subject: Re: [patch 1] Xen core patch : ptep_establish_new
Message-ID: <20041118101109.GA20859@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Ian Pratt <Ian.Pratt@cl.cam.ac.uk>, linux-kernel@vger.kernel.org,
	akpm@osdl.org, Keir.Fraser@cl.cam.ac.uk,
	Christian.Limpach@cl.cam.ac.uk
References: <E1CUZVj-00052O-00@mta1.cl.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1CUZVj-00052O-00@mta1.cl.cam.ac.uk>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 17, 2004 at 11:46:50PM +0000, Ian Pratt wrote:
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

What would be the problem of always passing the virtual address to
ptep_establish?  We already have a rather twisted maze of pte manipulation
macros.

