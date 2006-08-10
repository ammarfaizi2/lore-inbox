Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161480AbWHJRSW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161480AbWHJRSW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 13:18:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161478AbWHJRSW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 13:18:22 -0400
Received: from thunk.org ([69.25.196.29]:37000 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1161477AbWHJRSV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 13:18:21 -0400
Date: Thu, 10 Aug 2006 13:17:55 -0400
From: Theodore Tso <tytso@mit.edu>
To: Andrew Morton <akpm@osdl.org>
Cc: cmm@us.ibm.com, linux-fsdevel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Ext2-devel] [PATCH 1/9] extents for ext4
Message-ID: <20060810171755.GA19238@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Andrew Morton <akpm@osdl.org>, cmm@us.ibm.com,
	linux-fsdevel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <1155172827.3161.80.camel@localhost.localdomain> <20060809233940.50162afb.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060809233940.50162afb.akpm@osdl.org>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2006 at 11:39:40PM -0700, Andrew Morton wrote:
> - replace all brelse() calls with put_bh().  Because brelse() is
>   old-fashioned, has a weird name and neelessly permits a NULL arg.
> 
>   In fact it would be beter to convert JBD and ext3 to put_bh before
>   copying it all over.

Wouldn't it be better to preserve in the source code history the
brelse->put_bh conversion?  We can pour a huge number of changes in
ext4 before we submit, but I would have thought it would be easier for
everyone to see what is going on if we submit with just the minimal
changes, and then have patches that address concerns like this one at
a time.

						- Ted
