Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262145AbVBAWqH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262145AbVBAWqH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 17:46:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262157AbVBAWoq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 17:44:46 -0500
Received: from fire.osdl.org ([65.172.181.4]:23988 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262149AbVBAWlR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 17:41:17 -0500
Message-ID: <42000122.90104@osdl.org>
Date: Tue, 01 Feb 2005 14:22:26 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Wedgwood <cw@f00f.org>
CC: Matt Mackall <mpm@selenic.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/8] lib/sort: Replace qsort in XFS
References: <6.416337461@selenic.com> <7.416337461@selenic.com> <5.416337461@selenic.com> <6.416337461@selenic.com> <3.416337461@selenic.com> <4.416337461@selenic.com> <2.416337461@selenic.com> <3.416337461@selenic.com> <20050201222915.GA9285@taniwha.stupidest.org>
In-Reply-To: <20050201222915.GA9285@taniwha.stupidest.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wedgwood wrote:
> On Mon, Jan 31, 2005 at 01:34:59AM -0600, Matt Mackall wrote:
> 
> 
>>+#define qsort xfs_sort
>>+static inline void xfs_sort(void *a, size_t n, size_t s,
>>+			int (*cmp)(const void *,const void *))
>>+{
>>+	sort(a, n, s, cmp, 0);
>>+}
>>+
> 
> 
> why not just:
> 
> #define qsort(a, n, s, cmp)	sort(a, n, s, cmp, NULL)
> 
> 
> 
> On Mon, Jan 31, 2005 at 01:35:00AM -0600, Matt Mackall wrote:
> 
> 
>>Switch NFS ACLs to lib/sort
> 
> 
>>+	sort(acl->a_entries, acl->a_count, sizeof(struct posix_acl_entry),
>>+	     cmp_acl_entry, 0);
> 
> 
> There was a thread about stlye and I though the concensurs for null
> pointers weas to use NULL and not 0?

Yes, otherwise sparse complains... and maybe Linus  :)


> On Mon, Jan 31, 2005 at 01:35:00AM -0600, Matt Mackall wrote:
> 
> 
>>Eep. cpuset uses bubble sort on a data set that's potentially O(#
>>processes). Switch to lib/sort.
> 
> 
>>+	sort(pidarray, npids, sizeof(pid_t), cmppid, 0);
> 
> 
> and there?
> 
> 
> 
> On Mon, Jan 31, 2005 at 01:35:00AM -0600, Matt Mackall wrote:
> 
> 
>>Replace exception table insertion sort with lib/sort
> 
> 
>>+	sort(start, finish - start, sizeof(struct exception_table_entry),
>>+	     cmp_ex, 0);
> 
> 
> and there?


-- 
~Randy
