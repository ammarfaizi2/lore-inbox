Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161102AbWHJH5T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161102AbWHJH5T (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 03:57:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161119AbWHJH5T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 03:57:19 -0400
Received: from mx1.redhat.com ([66.187.233.31]:41638 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1161102AbWHJH5S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 03:57:18 -0400
Subject: Re: [PATCH 5/6] clean up OCFS2 nlink handling
From: Steven Whitehouse <swhiteho@redhat.com>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org,
       Christoph Hellwig <hch@infradead.org>
In-Reply-To: <1155150926.19249.175.camel@localhost.localdomain>
References: <20060809165729.FE36B262@localhost.localdomain>
	 <20060809165733.704AD0F5@localhost.localdomain>
	 <20060809171253.GE7324@infradead.org>
	 <1155150926.19249.175.camel@localhost.localdomain>
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Thu, 10 Aug 2006 09:07:32 +0100
Message-Id: <1155197252.3384.418.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 2006-08-09 at 12:15 -0700, Dave Hansen wrote:
> On Wed, 2006-08-09 at 18:12 +0100, Christoph Hellwig wrote:
[snip]
> > did you look whether gfs2 in -mm needs something similar?
> 
> It doesn't appear to.  It doesn't manipulate i_nlink in the same, direct
> manner.
> 
> -- Dave

I think it will need something similar. I suspect the required changes
will all be confined to routines in inode.c. If the link count is
changed by (a) remote node(s), then gfs2_inode_attr_in() might change
the link count. Also gfs2_change_nlink() is the other place to look. I
think everywhere else is ok,

Steve.


