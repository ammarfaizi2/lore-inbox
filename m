Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262828AbVAFNz2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262828AbVAFNz2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 08:55:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262826AbVAFNxr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 08:53:47 -0500
Received: from apachihuilliztli.mtu.ru ([195.34.32.124]:40716 "EHLO
	Apachihuilliztli.mtu.ru") by vger.kernel.org with ESMTP
	id S262833AbVAFNwl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 08:52:41 -0500
Subject: Re: 2.6.10-mm1
From: Vladimir Saveliev <vs@namesys.com>
To: Hans Reiser <reiser@namesys.com>, Christoph Hellwig <hch@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Reiserfs developers mail-list <Reiserfs-Dev@namesys.com>,
       Alexander Zarochentcev <zam@namesys.com>
In-Reply-To: <41DC2386.9010701@namesys.com>
References: <20050103011113.6f6c8f44.akpm@osdl.org>
	 <20050103114854.GA18408@infradead.org>  <41DC2386.9010701@namesys.com>
Content-Type: text/plain
Message-Id: <1105019521.7074.79.camel@tribesman.namesys.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Thu, 06 Jan 2005 16:52:01 +0300
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

On Wed, 2005-01-05 at 20:27, Hans Reiser wrote:
> Christoph Hellwig wrote:
> 
> >> reiser4-export-inode_lock.patch
> >>    
> >>
> >
> >Han,s how'as the work progressing on removing these and other fishy
> >core changes?
> >  

The work is in progress. Here is list of patches. 

reiser4-sb_sync_inodes.patch
reiser4-allow-drop_inode-implementation.patch - will either try to do
what Christoph suggested or find something else
reiser4-truncate_inode_pages_range.patch
reiser4-export-remove_from_page_cache.patch
reiser4-export-page_cache_readahead.patch
reiser4-reget-page-mapping.patch
reiser4-rcu-barrier.patch
reiser4-export-inode_lock.patch           - trying to change to go
without this
reiser4-export-pagevec-funcs.patch
reiser4-export-radix_tree_preload.patch
reiser4-export-find_get_pages.patch
reiser4-radix-tree-tag.patch              - not needed anymore
reiser4-radix_tree_lookup_slot.patch
reiser4-perthread-pages.patch
reiser4-unstatic-kswapd.patch             - not needed anymore
reiser4-include-reiser4.patch
reiser4-doc.patch

Christoph, what else do you especially object against?

> >
> Vladimir is writing code to reduce the number of patches needed.  This 
> code is causing bugs that have not yet been fixed.  His email is not 
> working today, hopefully it will work tomorrow.  This is the russian 
> holiday season....
> 
> >  
> >
> >> reiser4-unstatic-kswapd.patch
> >>    
> >>
> >
> >Andrew, could you please finally drop this one?  It's not needed for
> >reiser4 operation at all just for some of their stranger debugging
> >features.
> >  
> >
> I'll let vs comment.
> 
> >  
> >
> >> 
> >> reiser4-include-reiser4.patch
> >>    
> >>
> >
> >What about moving fs/Kconfig.reiser4 to fs/reiser4/Kconfig?  This is
> >the logical place for it and makes dropping in a new version of the fs
> >easier.
> >  
> >
> Ok.
> 
> >  
> >
> >> reiser4-only.patch
> >>    
> >>
> >
> >Documentation shouldn't be in fs/FOO/doc but Documentation/filesystems/.
> >  
> >
> Ok.
> 
> >-
> >To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> >the body of a message to majordomo@vger.kernel.org
> >More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >Please read the FAQ at  http://www.tux.org/lkml/
> >
> >
> >  
> >
> What are the other ones you object to?
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

