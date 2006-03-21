Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932351AbWCUS5i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932351AbWCUS5i (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 13:57:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932401AbWCUS5i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 13:57:38 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:21476 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932351AbWCUS5h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 13:57:37 -0500
Date: Tue, 21 Mar 2006 18:57:34 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Christoph Hellwig <hch@infradead.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net,
       nfsv4@linux-nfs.org
Subject: Re: [NFS] [GIT] NFS client update for 2.6.16
Message-ID: <20060321185734.GB19125@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Trond Myklebust <trond.myklebust@fys.uio.no>,
	Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
	nfs@lists.sourceforge.net, nfsv4@linux-nfs.org
References: <1142961077.7987.14.camel@lade.trondhjem.org> <20060321174634.GA15827@infradead.org> <1142964532.7987.61.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1142964532.7987.61.camel@lade.trondhjem.org>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2006 at 01:08:52PM -0500, Trond Myklebust wrote:
> We never had support for multiple iovecs in O_DIRECT, but were passing
> around a single iovec entry deep into code that couldn't care less.

anthing that moves from iovecs back to plain buffers is counterproductive.
The plan is that every fullblown fs will only deal with iovecs, onlt drivers
and synthetic filesystems will implement the plain buffers.

