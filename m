Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262155AbVBAWva@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262155AbVBAWva (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 17:51:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262152AbVBAWuj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 17:50:39 -0500
Received: from waste.org ([216.27.176.166]:19940 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262158AbVBAWse (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 17:48:34 -0500
Date: Tue, 1 Feb 2005 14:48:24 -0800
From: Matt Mackall <mpm@selenic.com>
To: Chris Wedgwood <cw@f00f.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/8] lib/sort: Replace qsort in XFS
Message-ID: <20050201224824.GF2493@waste.org>
References: <6.416337461@selenic.com> <7.416337461@selenic.com> <5.416337461@selenic.com> <6.416337461@selenic.com> <3.416337461@selenic.com> <4.416337461@selenic.com> <2.416337461@selenic.com> <3.416337461@selenic.com> <20050201222915.GA9285@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050201222915.GA9285@taniwha.stupidest.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 01, 2005 at 02:29:15PM -0800, Chris Wedgwood wrote:
> On Mon, Jan 31, 2005 at 01:34:59AM -0600, Matt Mackall wrote:
> 
> > +#define qsort xfs_sort
> > +static inline void xfs_sort(void *a, size_t n, size_t s,
> > +			int (*cmp)(const void *,const void *))
> > +{
> > +	sort(a, n, s, cmp, 0);
> > +}
> > +
> 
> why not just:
> 
> #define qsort(a, n, s, cmp)	sort(a, n, s, cmp, NULL)

Side-effect avoidance habit, not applicable here.

> On Mon, Jan 31, 2005 at 01:35:00AM -0600, Matt Mackall wrote:
> 
> > Switch NFS ACLs to lib/sort
> 
> > +	sort(acl->a_entries, acl->a_count, sizeof(struct posix_acl_entry),
> > +	     cmp_acl_entry, 0);
> 
> There was a thread about stlye and I though the concensurs for null
> pointers weas to use NULL and not 0?

Was it? Grumble. Ok, I'll fix these up.

-- 
Mathematics is the supreme nostalgia of our time.
