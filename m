Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261648AbUEJWUs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261648AbUEJWUs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 18:20:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261684AbUEJWUs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 18:20:48 -0400
Received: from phoenix.infradead.org ([213.86.99.234]:54032 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261648AbUEJWUj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 18:20:39 -0400
Date: Mon, 10 May 2004 23:20:38 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-mm1
Message-ID: <20040510232038.A8331@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040510024506.1a9023b6.akpm@osdl.org> <20040510223755.A7773@infradead.org> <20040510150203.3257ccac.akpm@osdl.org> <20040510230558.A8159@infradead.org> <20040510151554.49965f1d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040510151554.49965f1d.akpm@osdl.org>; from akpm@osdl.org on Mon, May 10, 2004 at 03:15:54PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2004 at 03:15:54PM -0700, Andrew Morton wrote:
> It beats the alternatives which are floating about, which includes a sysctl
> which defeats CAP_SYS_MLOCK system-wide.

That one might not be nice, but at least it doesn't randomly change
the meaning of a group id.  So yeah, although it's a hack too it's
much much better than the junk that just went into Linus tree.

Why btw do we have a staging tree if such sensitive patches go into
mainline without proper review after just one day?

> >  What happened to the patch rick promised
> > to make mlock an rlimit?  This is the right approach and could be easily
> > extended to hugetlb pages.
> 
> rlimits don't work for this.  shm segments persist after process exit and
> aren't associated with a particular user.

When did shm segments come into the play?  I know we bolted hugetlb
support onto the back of the already horrible sysv shm interface, but
if people want additional interfaces ontop of that they should use
the proper mmap api.

