Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750819AbWFWOzz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750819AbWFWOzz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 10:55:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750818AbWFWOzz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 10:55:55 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:57805 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750819AbWFWOzy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 10:55:54 -0400
Date: Fri, 23 Jun 2006 15:55:46 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Steven Whitehouse <swhiteho@redhat.com>
Cc: Linus Torvalds <torvalds@osdl.org>, David Teigland <teigland@redhat.com>,
       Patrick Caulfield <pcaulfie@redhat.com>,
       Kevin Anderson <kanderso@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: GFS2 and DLM
Message-ID: <20060623145546.GC32694@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Steven Whitehouse <swhiteho@redhat.com>,
	Linus Torvalds <torvalds@osdl.org>,
	David Teigland <teigland@redhat.com>,
	Patrick Caulfield <pcaulfie@redhat.com>,
	Kevin Anderson <kanderso@redhat.com>, Andrew Morton <akpm@osdl.org>,
	Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
References: <1150805833.3856.1356.camel@quoit.chygwyn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1150805833.3856.1356.camel@quoit.chygwyn.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2006 at 01:17:13PM +0100, Steven Whitehouse wrote:
> Hi,
> 
> Linus, Andrew suggested to me to send this pull request to you directly.
> Please consider merging the GFS2 filesystem and DLM from (they are both
> in the same tree for ease of testing):

gfs2_glock_nq_atime doesn't take per-mountpoint atime into consideration
at all.  Deciding on when to do an atime update is pretty much a VFS
thing anyway.

