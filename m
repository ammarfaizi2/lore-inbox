Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262144AbVBAWd7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262144AbVBAWd7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 17:33:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262152AbVBAWd7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 17:33:59 -0500
Received: from pimout4-ext.prodigy.net ([207.115.63.98]:17288 "EHLO
	pimout4-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S262144AbVBAW3j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 17:29:39 -0500
Date: Tue, 1 Feb 2005 14:29:15 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Matt Mackall <mpm@selenic.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/8] lib/sort: Replace qsort in XFS
Message-ID: <20050201222915.GA9285@taniwha.stupidest.org>
References: <6.416337461@selenic.com> <7.416337461@selenic.com> <5.416337461@selenic.com> <6.416337461@selenic.com> <3.416337461@selenic.com> <4.416337461@selenic.com> <2.416337461@selenic.com> <3.416337461@selenic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7.416337461@selenic.com> <6.416337461@selenic.com> <4.416337461@selenic.com> <3.416337461@selenic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2005 at 01:34:59AM -0600, Matt Mackall wrote:

> +#define qsort xfs_sort
> +static inline void xfs_sort(void *a, size_t n, size_t s,
> +			int (*cmp)(const void *,const void *))
> +{
> +	sort(a, n, s, cmp, 0);
> +}
> +

why not just:

#define qsort(a, n, s, cmp)	sort(a, n, s, cmp, NULL)



On Mon, Jan 31, 2005 at 01:35:00AM -0600, Matt Mackall wrote:

> Switch NFS ACLs to lib/sort

> +	sort(acl->a_entries, acl->a_count, sizeof(struct posix_acl_entry),
> +	     cmp_acl_entry, 0);

There was a thread about stlye and I though the concensurs for null
pointers weas to use NULL and not 0?



On Mon, Jan 31, 2005 at 01:35:00AM -0600, Matt Mackall wrote:

> Eep. cpuset uses bubble sort on a data set that's potentially O(#
> processes). Switch to lib/sort.

> +	sort(pidarray, npids, sizeof(pid_t), cmppid, 0);

and there?



On Mon, Jan 31, 2005 at 01:35:00AM -0600, Matt Mackall wrote:

> Replace exception table insertion sort with lib/sort

> +	sort(start, finish - start, sizeof(struct exception_table_entry),
> +	     cmp_ex, 0);

and there?

