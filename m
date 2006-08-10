Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422675AbWHJSEP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422675AbWHJSEP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 14:04:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422676AbWHJSEP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 14:04:15 -0400
Received: from smtp.osdl.org ([65.172.181.4]:49287 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422675AbWHJSEO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 14:04:14 -0400
Date: Thu, 10 Aug 2006 11:00:47 -0700
From: Andrew Morton <akpm@osdl.org>
To: Theodore Tso <tytso@mit.edu>
Cc: cmm@us.ibm.com, linux-fsdevel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Ext2-devel] [PATCH 1/9] extents for ext4
Message-Id: <20060810110047.af273a55.akpm@osdl.org>
In-Reply-To: <20060810171755.GA19238@thunk.org>
References: <1155172827.3161.80.camel@localhost.localdomain>
	<20060809233940.50162afb.akpm@osdl.org>
	<20060810171755.GA19238@thunk.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Aug 2006 13:17:55 -0400
Theodore Tso <tytso@mit.edu> wrote:

> On Wed, Aug 09, 2006 at 11:39:40PM -0700, Andrew Morton wrote:
> > - replace all brelse() calls with put_bh().  Because brelse() is
> >   old-fashioned, has a weird name and neelessly permits a NULL arg.
> > 
> >   In fact it would be beter to convert JBD and ext3 to put_bh before
> >   copying it all over.
> 
> Wouldn't it be better to preserve in the source code history the
> brelse->put_bh conversion?  We can pour a huge number of changes in
> ext4 before we submit, but I would have thought it would be easier for
> everyone to see what is going on if we submit with just the minimal
> changes, and then have patches that address concerns like this one at
> a time.
> 

I'd suggest that this be one of the cleanups which be done within ext3
before taking the ext4 copy.

That's assuming we want to do the spring-cleaning - we might of course
decide not to.  But it'd be a good time to do so.
