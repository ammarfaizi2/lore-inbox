Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751162AbWHIRM5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751162AbWHIRM5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 13:12:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751270AbWHIRM5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 13:12:57 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:27095 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751162AbWHIRM4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 13:12:56 -0400
Date: Wed, 9 Aug 2006 18:12:53 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, hch@infradead.org
Subject: Re: [PATCH 5/6] clean up OCFS2 nlink handling
Message-ID: <20060809171253.GE7324@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Dave Hansen <haveblue@us.ibm.com>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
References: <20060809165729.FE36B262@localhost.localdomain> <20060809165733.704AD0F5@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060809165733.704AD0F5@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2006 at 09:57:33AM -0700, Dave Hansen wrote:
> 
> OCFS2 does some operations on i_nlink, then reverts them if some
> of its operations fail to complete.  This does not fit in well
> with the drop_nlink() logic where we expect i_nlink to stay at
> zero once it gets there.
> 
> So, delay all of the nlink operations until we're sure that the
> operations have completed.  Also, introduce a small helper to
> check whether an inode has proper "unlinkable" i_nlink counts
> no matter whether it is a directory or regular inode.
> 
> This patch is broken out from the others because it does contain
> some logical changes.

looks good to me, although I probably can't ACK ocfs2 patches.  did you
look whether gfs2 in -mm needs something similar?
