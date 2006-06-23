Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751737AbWFWQVQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751737AbWFWQVQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 12:21:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751738AbWFWQVQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 12:21:16 -0400
Received: from mx1.redhat.com ([66.187.233.31]:8614 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751734AbWFWQVQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 12:21:16 -0400
Subject: Re: GFS2 and DLM
From: Steven Whitehouse <swhiteho@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Linus Torvalds <torvalds@osdl.org>, David Teigland <teigland@redhat.com>,
       Patrick Caulfield <pcaulfie@redhat.com>,
       Kevin Anderson <kanderso@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
In-Reply-To: <20060623150040.GA1197@infradead.org>
References: <1150805833.3856.1356.camel@quoit.chygwyn.com>
	 <20060623150040.GA1197@infradead.org>
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Fri, 23 Jun 2006 17:29:34 +0100
Message-Id: <1151080174.3856.1606.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 2006-06-23 at 16:00 +0100, Christoph Hellwig wrote:
> On Tue, Jun 20, 2006 at 01:17:13PM +0100, Steven Whitehouse wrote:
> > Hi,
> > 
> > Linus, Andrew suggested to me to send this pull request to you directly.
> > Please consider merging the GFS2 filesystem and DLM from (they are both
> > in the same tree for ease of testing):
> 
> A new normal filesystem (aka everything but procfs) shouldn't implement
> ->readlink but use generic_readlink instead.
> 

The comment above generic_readlink has this to say:

/*
 * A helper for ->readlink().  This should be used *ONLY* for symlinks that
 * have ->follow_link() touching nd only in nd_set_link().  Using (or not
 * using) it for any given inode is up to filesystem.
 */

which appears, at least, to contradict what you are saying. I'll put it
on my list to look at again, but a straight substitution of
generic_readlink() does not work, so I'd prefer to leave it as it is for
the moment,

Steve.
  

