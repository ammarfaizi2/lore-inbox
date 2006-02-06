Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750979AbWBFEi6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750979AbWBFEi6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 23:38:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750981AbWBFEi5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 23:38:57 -0500
Received: from smtp.osdl.org ([65.172.181.4]:42440 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750978AbWBFEi5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 23:38:57 -0500
Date: Sun, 5 Feb 2006 20:37:58 -0800
From: Andrew Morton <akpm@osdl.org>
To: Paul Jackson <pj@sgi.com>
Cc: dgc@sgi.com, steiner@sgi.com, Simon.Derr@bull.net, ak@suse.de,
       linux-kernel@vger.kernel.org, pj@sgi.com, clameter@sgi.com
Subject: Re: [PATCH 5/5] cpuset memory spread slab cache hooks
Message-Id: <20060205203758.130ffcbd.akpm@osdl.org>
In-Reply-To: <20060204071932.10021.62411.sendpatchset@jackhammer.engr.sgi.com>
References: <20060204071910.10021.8437.sendpatchset@jackhammer.engr.sgi.com>
	<20060204071932.10021.62411.sendpatchset@jackhammer.engr.sgi.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson <pj@sgi.com> wrote:
>
> Change the kmem_cache_create calls for certain slab caches to support
>  cpuset memory spreading.
> 
>  See the previous patches, cpuset_mem_spread, for an explanation of
>  cpuset memory spreading, and cpuset_mem_spread_slab_cache for the
>  slab cache support for memory spreading.
> 
>  The slag caches marked for now are: dentry_cache, inode_cache,
>  and buffer_head.  This list may change over time.

inode_cache is practically unused.  You'll be wanting to patch
ext3_inode_cache, xfs-inode_cache, etc.
