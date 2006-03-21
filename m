Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964813AbWCURql@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964813AbWCURql (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 12:46:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751480AbWCURql
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 12:46:41 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:53154 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751475AbWCURqk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 12:46:40 -0500
Date: Tue, 21 Mar 2006 17:46:34 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       nfs@lists.sourceforge.net, nfsv4@linux-nfs.org
Subject: Re: [NFS] [GIT] NFS client update for 2.6.16
Message-ID: <20060321174634.GA15827@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Trond Myklebust <trond.myklebust@fys.uio.no>,
	Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
	nfs@lists.sourceforge.net, nfsv4@linux-nfs.org
References: <1142961077.7987.14.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1142961077.7987.14.camel@lade.trondhjem.org>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> commit 47989d7454398827500d0e73766270986a3b488f
> Author: Chuck Lever <cel@netapp.com>
> Date:   Mon Mar 20 13:44:32 2006 -0500
> 
>     NFS: remove support for multi-segment iovs in the direct write path
>     
>     Eliminate the persistent use of automatic storage in all parts of the
>     NFS client's direct write path to pave the way for introducing support
>     for aio against files opened with the O_DIRECT flag.

NACK.  We have patches pending that consolidate ->aio_read/write and
->read/writev into one operation.  this change is completely counterproductive
towards that goal which has been discussed on -fsdevel for a while.

