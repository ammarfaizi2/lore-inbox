Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932357AbWHaQ04@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932357AbWHaQ04 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 12:26:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932363AbWHaQ04
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 12:26:56 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:56503 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932357AbWHaQ0y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 12:26:54 -0400
Date: Thu, 31 Aug 2006 17:26:28 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Shaya Potter <spotter@cs.columbia.edu>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, unionfs@fsl.cs.sunysb.edu
Subject: Re: bug in nfs in 2.6.18-rc5?
Message-ID: <20060831162628.GA23925@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Trond Myklebust <trond.myklebust@fys.uio.no>,
	Shaya Potter <spotter@cs.columbia.edu>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	unionfs@fsl.cs.sunysb.edu
References: <44F6F80F.1000202@cs.columbia.edu> <1157040230.11347.31.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1157040230.11347.31.camel@localhost>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 31, 2006 at 12:03:50PM -0400, Trond Myklebust wrote:
> If we're to provide the ability for unionfs to use lookup_one_len() on
> NFS, then we will have to error out whenever we hit a case where we
> should be creating a new mountpoint. Is that acceptable?

Not at all.  unionfs will have to pass down proper lookup intents.
The ecryptfs developers have started looking into making that work
with stackable filesystems, and the unionfs developers should follow
that effort.
