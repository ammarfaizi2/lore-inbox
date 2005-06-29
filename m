Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262456AbVF2HHn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262456AbVF2HHn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 03:07:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262461AbVF2HHn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 03:07:43 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:20943 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262456AbVF2HHa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 03:07:30 -0400
Date: Wed, 29 Jun 2005 08:07:29 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Pekka Enberg <penberg@cs.helsinki.fi>, hch@infradead.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] freevxfs: minor cleanups
Message-ID: <20050629070729.GB16850@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>,
	Pekka Enberg <penberg@cs.helsinki.fi>, linux-kernel@vger.kernel.org
References: <iit0gm.lxobpl.5z2b9jduhy9fvx6tjxrco46v4.refire@cs.helsinki.fi> <iit0h1.q7pnex.bkir3xysppdufw6d9h65boz37.refire@cs.helsinki.fi> <20050628163114.6594e1e1.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050628163114.6594e1e1.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2005 at 04:31:14PM -0700, Andrew Morton wrote:
> Pekka Enberg <penberg@cs.helsinki.fi> wrote:
> >
> > This patch addresses the following minor issues:
> > 
> >   - Typo in printk
> >   - Redundant casts
> >   - Use C99 struct initializers instead of memset
> >   - Parenthesis around return value
> >   - Use inline instead of __inline__
> 
> That struct initialisation:
> 
> > +	*infp = (struct vxfs_sb_info) {
> > +		.vsi_raw = rsbp,
> > +		.vsi_bp = bp,
> > +		.vsi_oltext = rsbp->vs_oltext[0],
> > +		.vsi_oltsize = rsbp->vs_oltsize,
> > +	};
> >  
> 
> Is a bit unconventional, but it doesn't alter the size of the .o file, so
> whatever.

It looks rather horrible, I wouldn't call that a cleanup.  Where's the
full patch?
