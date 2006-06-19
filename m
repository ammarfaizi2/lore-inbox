Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932269AbWFSUsA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932269AbWFSUsA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 16:48:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932293AbWFSUsA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 16:48:00 -0400
Received: from rwcrmhc11.comcast.net ([216.148.227.151]:60136 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S932269AbWFSUr6 (ORCPT <rfc822;Linux-Kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 16:47:58 -0400
Message-ID: <44970D7D.9070001@namesys.com>
Date: Mon, 19 Jun 2006 13:47:57 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andreas Dilger <adilger@clusterfs.com>
CC: Andrew Morton <akpm@osdl.org>, "Vladimir V. Saveliev" <vs@namesys.com>,
       hch@infradead.org, Reiserfs-Dev@namesys.com,
       Linux-Kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: batched write
References: <44736D3E.8090808@namesys.com> <20060524175312.GA3579@zero> <44749E24.40203@namesys.com> <20060608110044.GA5207@suse.de> <1149766000.6336.29.camel@tribesman.namesys.com> <20060608121006.GA8474@infradead.org> <1150322912.6322.129.camel@tribesman.namesys.com> <20060617100458.0be18073.akpm@osdl.org> <20060619162740.GA5817@schatzie.adilger.int> <4496D606.8070402@namesys.com> <20060619185049.GH5817@schatzie.adilger.int>
In-Reply-To: <20060619185049.GH5817@schatzie.adilger.int>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger wrote:

>
>If the VFS supported delayed allocation it would call into the filesystem
>on a per-sys_write basis 
>
Is it necessary for VFS to specify that it is for delayed allocation
that it does it, or can it be a more generic sort of per sys-write call?

>to allow the filesystem to RESERVE space for all
>of the pages in the write call, and then later (under memory pressure,
>page aging, or even "pull" from the fs) submit a whole batch of contiguous
>pages to the fs efficiently (via ->fill_pages() or whatever).
>  
>
