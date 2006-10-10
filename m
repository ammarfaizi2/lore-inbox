Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932980AbWJJMSe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932980AbWJJMSe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 08:18:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965139AbWJJMSe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 08:18:34 -0400
Received: from mx1.redhat.com ([66.187.233.31]:6274 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932980AbWJJMSe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 08:18:34 -0400
Message-ID: <452B8F92.6000307@RedHat.com>
Date: Tue, 10 Oct 2006 08:18:26 -0400
From: Steve Dickson <SteveD@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.7) Gecko/20060911 Red Hat/1.0.5-0.1.el4 SeaMonkey/1.0.5
MIME-Version: 1.0
To: Trond Myklebust <Trond.Myklebust@netapp.com>
CC: David Howells <dhowells@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] VM: Fix the gfp_mask in invalidate_complete_page2
References: <1160170629.5453.34.camel@lade.trondhjem.org>	 <2069.1160473410@redhat.com> <1160480576.5466.27.camel@lade.trondhjem.org>
In-Reply-To: <1160480576.5466.27.camel@lade.trondhjem.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Trond Myklebust wrote:
> 
> No. Invalidatepage does precisely the wrong thing: it invalidates dirty
> data instead of committing it to disk. If you need to have the data
> invalidated, then you should call truncate_inode_pages().
Just curious... would it make sense to call truncate_inode_pages()
to purge the the readdir cache? Meaning, in nfs_revalidate_mapping()
truncate_inode_pages() would be called for S_ISDIR inodes?

It seems to me that it would be more of a decisive why to ensure
the readdir cache is purged...

steved.

