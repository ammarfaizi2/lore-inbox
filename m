Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161038AbWF0HxM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161038AbWF0HxM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 03:53:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161039AbWF0HxM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 03:53:12 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:40350 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1161038AbWF0HxK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 03:53:10 -0400
Date: Tue, 27 Jun 2006 08:52:57 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Christoph Hellwig <hch@infradead.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Steven Whitehouse <swhiteho@redhat.com>,
       Linus Torvalds <torvalds@osdl.org>,
       David Teigland <teigland@redhat.com>,
       Patrick Caulfield <pcaulfie@redhat.com>,
       Kevin Anderson <kanderso@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: GFS2 and DLM
Message-ID: <20060627075257.GB21066@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Ingo Molnar <mingo@elte.hu>, Nick Piggin <nickpiggin@yahoo.com.au>,
	Steven Whitehouse <swhiteho@redhat.com>,
	Linus Torvalds <torvalds@osdl.org>,
	David Teigland <teigland@redhat.com>,
	Patrick Caulfield <pcaulfie@redhat.com>,
	Kevin Anderson <kanderso@redhat.com>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <1150805833.3856.1356.camel@quoit.chygwyn.com> <4497EAC6.3050003@yahoo.com.au> <1150807630.3856.1372.camel@quoit.chygwyn.com> <44980064.6040306@yahoo.com.au> <20060623144530.GA32291@infradead.org> <20060626210355.GA16827@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060626210355.GA16827@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2006 at 11:03:55PM +0200, Ingo Molnar wrote:
> > the generic file read code so GFS should do so aswell.  And there's a 
> > technical reason for not exporting aswell as the generic file read 
> > interface is far too complicated already.
> 
> GFS is different here mostly due to locking,

If it requires locking there it's sendifle and splice_read implementation
are wrong.

<marketing crap removed>

ocfs2 seems to do pretty well using the generic code here, so there
definitly is a explanation required why gfs can't do the same.

> so i'd reformulate your request as a request to extend the VFS to unify 
> clustering filesystems - which is a nice cleanup goal but not a merge 
> showstopper to me.

duplicating half the generic read code is definitily not okay.  I'm
happy to have a discussion about more or less hacly ways to share the
code mid-term.

