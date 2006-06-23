Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751490AbWFWPyx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751490AbWFWPyx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 11:54:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751499AbWFWPyx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 11:54:53 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:26275 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751490AbWFWPyw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 11:54:52 -0400
Date: Fri, 23 Jun 2006 16:54:44 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Steven Whitehouse <swhiteho@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, Linus Torvalds <torvalds@osdl.org>,
       David Teigland <teigland@redhat.com>,
       Patrick Caulfield <pcaulfie@redhat.com>,
       Kevin Anderson <kanderso@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: GFS2 and DLM
Message-ID: <20060623155444.GA5504@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Steven Whitehouse <swhiteho@redhat.com>,
	Linus Torvalds <torvalds@osdl.org>,
	David Teigland <teigland@redhat.com>,
	Patrick Caulfield <pcaulfie@redhat.com>,
	Kevin Anderson <kanderso@redhat.com>, Andrew Morton <akpm@osdl.org>,
	Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
References: <1150805833.3856.1356.camel@quoit.chygwyn.com> <20060623145409.GB32694@infradead.org> <1151078044.3856.1595.camel@quoit.chygwyn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1151078044.3856.1595.camel@quoit.chygwyn.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2006 at 04:54:04PM +0100, Steven Whitehouse wrote:
> with just calling permission directly... we need to call it mainly because
> the VFS only does locking within a single node and we recheck the permissions
> in a few places after we've taken the glocks which provide cluster-wide
> exclusion.

->permission must give correct answers.  So I think the answer to your question
is that you need to do the right thing there and get rid of the additional
calls.

