Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750769AbWJJNcO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750769AbWJJNcO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 09:32:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750774AbWJJNcO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 09:32:14 -0400
Received: from mx2.netapp.com ([216.240.18.37]:37493 "EHLO mx2.netapp.com")
	by vger.kernel.org with ESMTP id S1750769AbWJJNcM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 09:32:12 -0400
X-IronPort-AV: i="4.09,289,1157353200"; 
   d="scan'208"; a="416658834:sNHT41158436"
Subject: Re: [PATCH] VM: Fix the gfp_mask in invalidate_complete_page2
From: Trond Myklebust <Trond.Myklebust@netapp.com>
To: Steve Dickson <SteveD@redhat.com>
Cc: David Howells <dhowells@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <452B9EB1.4090806@RedHat.com>
References: <1160170629.5453.34.camel@lade.trondhjem.org>
	 <2069.1160473410@redhat.com> <1160480576.5466.27.camel@lade.trondhjem.org>
	 <452B8F92.6000307@RedHat.com> <1160483226.5466.34.camel@lade.trondhjem.org>
	 <452B9EB1.4090806@RedHat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Network Appliance Inc
Date: Tue, 10 Oct 2006 09:32:10 -0400
Message-Id: <1160487130.5466.58.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
X-OriginalArrivalTime: 10 Oct 2006 13:32:27.0719 (UTC) FILETIME=[874E5D70:01C6EC70]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-10-10 at 09:22 -0400, Steve Dickson wrote:
> 
> Trond Myklebust wrote: 
> > Why? If, as in the case of an NFS directory, there are no dirty pages
> > then the two are supposed to be 100% equivalent.
> Well as you know, lately we've had problems with 
> invalidate_inode_pages2() failing to invalidate pages (regardless of
> their state). So I was thinking truncate_inode_pages() might be
> better for directories since there seem to be more a guarantee that
> the pages will be gone with truncate_inode_pages() than
> invalidate_inode_pages2() (due to the fact there will not be any
> dirty pages).

truncate_inode_pages and invalidate_inode_pages2 are supposed to result
in exactly the same behaviour on NFS directories. If they don't then
that would be a bug.

  Trond
