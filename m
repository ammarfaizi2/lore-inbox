Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262991AbVCQEmt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262991AbVCQEmt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 23:42:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262997AbVCQEmt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 23:42:49 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:31713 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262991AbVCQEmm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 23:42:42 -0500
Date: Thu, 17 Mar 2005 04:42:34 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Rik van Riel <riel@redhat.com>
Cc: Jesse Barnes <jbarnes@engr.sgi.com>, Paul Mackerras <paulus@samba.org>,
       Keir Fraser <Keir.Fraser@cl.cam.ac.uk>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, kurt@garloff.de, Ian.Pratt@cl.cam.ac.uk,
       Christian.Limpach@cl.cam.ac.uk
Subject: Re: [PATCH] Xen/i386 cleanups - AGP bus/phys cleanups
Message-ID: <20050317044234.GA4415@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Rik van Riel <riel@redhat.com>, Jesse Barnes <jbarnes@engr.sgi.com>,
	Paul Mackerras <paulus@samba.org>,
	Keir Fraser <Keir.Fraser@cl.cam.ac.uk>,
	linux-kernel@vger.kernel.org, akpm@osdl.org, kurt@garloff.de,
	Ian.Pratt@cl.cam.ac.uk, Christian.Limpach@cl.cam.ac.uk
References: <E1DBX0o-0000sV-00@mta1.cl.cam.ac.uk> <16952.41973.751326.592933@cargo.ozlabs.ibm.com> <200503161406.01788.jbarnes@engr.sgi.com> <Pine.LNX.4.61.0503161853380.23084@chimarrao.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0503161853380.23084@chimarrao.boston.redhat.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2005 at 06:55:13PM -0500, Rik van Riel wrote:
> Thing is, the rest of the kernel uses virt_to_phys for
> two different things.  Only one of them has to do with
> the real physical address, the other is about getting
> the page frame number.

The latter usage has been converted to page_to_pfn(virt_to_page(v))
in the places I checked.

