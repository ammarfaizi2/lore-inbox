Return-Path: <linux-kernel-owner+w=401wt.eu-S932629AbXARWWz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932629AbXARWWz (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 17:22:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932636AbXARWWz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 17:22:55 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:43163 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932629AbXARWWy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 17:22:54 -0500
Date: Thu, 18 Jan 2007 22:22:43 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: Linus Torvalds <torvalds@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       ntfs-dev <linux-ntfs-dev@lists.sourceforge.net>,
       Christoph Hellwig <hch@infradead.org>, akpm@osdl.org
Subject: Re: NTFS
Message-ID: <20070118222243.GA14047@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Anton Altaparmakov <aia21@cam.ac.uk>,
	Linus Torvalds <torvalds@osdl.org>,
	lkml <linux-kernel@vger.kernel.org>,
	ntfs-dev <linux-ntfs-dev@lists.sourceforge.net>, akpm@osdl.org
References: <1169115951.5408.10.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1169115951.5408.10.camel@imp.csi.cam.ac.uk>
User-Agent: Mutt/1.4.2.2i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 18, 2007 at 10:25:50AM +0000, Anton Altaparmakov wrote:
> Hi Linus, please pull from
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/aia21/ntfs-2.6.git
> 
> This NTFS update fixes the deadlock reported by Sergey Vlasov in
> ntfs_put_inode().
> 
> The fix was to remove ntfs_put_inode() which should make Christoph
> Hellwig (CC:-ed) very happy as he wanted to get rid of ->put_inode
> altogether a while ago and NTFS stopped him from doing so and now the
> way should be clear for it to happen...  (-:

Cool.  That means ->put_inode is gone in -mm.  Andrew, what are the
plans for sending the patches to make the ext2 preallocation work
like ext3 to Linus?  
