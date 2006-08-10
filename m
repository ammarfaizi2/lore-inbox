Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422658AbWHJRo3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422658AbWHJRo3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 13:44:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422661AbWHJRo0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 13:44:26 -0400
Received: from thunk.org ([69.25.196.29]:2009 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1422658AbWHJRoV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 13:44:21 -0400
Date: Thu, 10 Aug 2006 13:44:04 -0400
From: Theodore Tso <tytso@mit.edu>
To: Andrew Morton <akpm@osdl.org>
Cc: cmm@us.ibm.com, linux-fsdevel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Ext2-devel] [PATCH 1/5] Forking ext4 filesystem from ext3 filesystem
Message-ID: <20060810174404.GB19238@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Andrew Morton <akpm@osdl.org>, cmm@us.ibm.com,
	linux-fsdevel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <1155172622.3161.73.camel@localhost.localdomain> <20060809233914.35ab8792.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060809233914.35ab8792.akpm@osdl.org>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2006 at 11:39:14PM -0700, Andrew Morton wrote:
> One the fs has been copied-and-pasted, it's much harder to address these
> things: either need to do it twice, or allow the filesystems to diverge, or
> not do it.

> Also, JBD is presently feeding into submit_bh() buffer_heads which span two
> machine pages, and some device drivers spit the dummy.  It'd be better to
> fix that once, rather than twice..  

Well, it's harder no matter when we do it, right?  Whether we do it
before we submit or after, we still before us have the choice of
whether to let the filesystems diverge (and make it harder to do
maintenance), or not.  But Linus and others have spoken pretty clearly
that they don't want ext3 to be touched, and it's not even clear that
people would be happy with cleanups.

If we are going to do the cleanups in both, it would actually be
better to fix up ext3 *first*, and then do the copy...

						- Ted
