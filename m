Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261180AbUKRWJz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261180AbUKRWJz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 17:09:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263023AbUKRWJ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 17:09:28 -0500
Received: from ozlabs.org ([203.10.76.45]:53186 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261180AbUKRWG1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 17:06:27 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16797.7390.769118.230947@cargo.ozlabs.ibm.com>
Date: Fri, 19 Nov 2004 09:06:22 +1100
From: Paul Mackerras <paulus@samba.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Ian Pratt <Ian.Pratt@cl.cam.ac.uk>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, Keir.Fraser@cl.cam.ac.uk, Christian.Limpach@cl.cam.ac.uk
Subject: Re: [patch 1] Xen core patch : ptep_establish_new
In-Reply-To: <20041118101109.GA20859@infradead.org>
References: <E1CUZVj-00052O-00@mta1.cl.cam.ac.uk>
	<20041118101109.GA20859@infradead.org>
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig writes:

> On Wed, Nov 17, 2004 at 11:46:50PM +0000, Ian Pratt wrote:
> > 
> > This patch adds 'ptep_establish_new', in keeping with the
> > existing 'ptep_establish', but for use where a mapping is being
> > established where there was previously none present. This
> > function is useful (rather than just using set_pte) because
> > having the virtual address available enables a very important
> > optimisation for arch-xen. We introduce
> > HAVE_ARCH_PTEP_ESTABLISH_NEW and define a generic implementation
> > in asm-generic/pgtable.h, following the pattern of the existing
> > ptep_establish.
> 
> What would be the problem of always passing the virtual address to
> ptep_establish?  We already have a rather twisted maze of pte manipulation
> macros.

Dave Miller had a patch that passes the mm and virtual address to
set_pte.  That helps on sparc64 and ppc/ppc64, and it sounds like it
would help here too.

Paul.
