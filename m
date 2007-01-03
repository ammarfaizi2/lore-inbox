Return-Path: <linux-kernel-owner+w=401wt.eu-S932074AbXACULa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932074AbXACULa (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 15:11:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932076AbXACULa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 15:11:30 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:56216 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932074AbXACUL3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 15:11:29 -0500
Date: Wed, 3 Jan 2007 20:11:23 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Arjan van de Ven <arjan@infradead.org>,
       Anton Altaparmakov <aia21@cam.ac.uk>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 PATCH] Export invalidate_mapping_pages() to modules.
Message-ID: <20070103201123.GA1097@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>,
	Arjan van de Ven <arjan@infradead.org>,
	Anton Altaparmakov <aia21@cam.ac.uk>,
	Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.64.0701012322050.1218@hermes-1.csi.cam.ac.uk> <1167830972.3095.3.camel@laptopd505.fenrus.org> <20070103110332.ba3d39a2.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070103110332.ba3d39a2.akpm@osdl.org>
User-Agent: Mutt/1.4.2.2i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 03, 2007 at 11:03:32AM -0800, Andrew Morton wrote:
> It makes no sense to me to export invalidate_inode_pages() and not
> invalidate_mapping_pages() and I actually need invalidate_mapping_pages()
> because of its range specification ability...
> 
> akpm: also remove the export of invalidate_inode_pages() by making it an
> inlined wrapper.

What about just killing invalidate_inode_pages()?  It only has about
a dozend callers, and it's already rather misnamed since it actually
operates on an address_space, not an inode.
