Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261636AbVAXXdJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261636AbVAXXdJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 18:33:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261731AbVAXXc0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 18:32:26 -0500
Received: from waste.org ([216.27.176.166]:2776 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261636AbVAXXaf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 18:30:35 -0500
Date: Mon, 24 Jan 2005 15:30:07 -0800
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, neilb@cse.unsw.edu.au,
       trond.myklebust@fys.uio.no, okir@suse.de, Andries.Brouwer@cwi.nl,
       agruen@suse.de
Subject: Re: [PATCH] lib/qsort
Message-ID: <20050124233007.GH12076@waste.org>
References: <20050122203326.402087000@blunzn.suse.de> <20050122203618.962749000@blunzn.suse.de> <20050124201527.GZ12076@waste.org> <20050124150940.26945fe3.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050124150940.26945fe3.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2005 at 03:09:40PM -0800, Andrew Morton wrote:
> Matt Mackall <mpm@selenic.com> wrote:
> >
> > This patch introduces an implementation of qsort to lib/.
> 
> It screws me over right proper.  Can we stick with Andreas's known-working
> patch for now, and do the sorting stuff as a separate, later activity?
> 
> It would involve:
> 
> - Removal of the old sort code
> 
> - Introduction of the new sort code
> 
> - Migration of the NFS ACL code, XFS and group code over to the new
>   implementation.

Ok, will do after mm++.

FYI, I'm going to submit a heapsort variant instead with similar
performance. It gets rid of the potentially exploitable worst-case
behavior of qsort as well as the extra stack space (and the resultant
need for error handling).

Apparently the glibc folks wanted this to be EXPORT_SYMBOL_GPL the
last time around, btw.

-- 
Mathematics is the supreme nostalgia of our time.
