Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750878AbVKDU7X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750878AbVKDU7X (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 15:59:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750880AbVKDU7X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 15:59:23 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:63171 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750878AbVKDU7W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 15:59:22 -0500
Date: Fri, 4 Nov 2005 20:59:14 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Zach Brown <zach.brown@oracle.com>
Cc: Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@infradead.org>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       mark.fasheh@oracle.com, Joel Becker <Joel.Becker@oracle.com>
Subject: Re: [Patch] add AOP_TRUNCATED_PAGE, prepend AOP_ to WRITEPAGE_ACTIVATE
Message-ID: <20051104205914.GA11202@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Zach Brown <zach.brown@oracle.com>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	mark.fasheh@oracle.com, Joel Becker <Joel.Becker@oracle.com>
References: <43667913.4030401@oracle.com> <20051103124536.0191bea6.akpm@osdl.org> <20051103074312.GQ11488@ca-server1.us.oracle.com> <20051103165306.GA4923@infradead.org> <20051103205802.31121fc4.akpm@osdl.org> <436BA907.9080604@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <436BA907.9080604@oracle.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 04, 2005 at 10:31:35AM -0800, Zach Brown wrote:
> > Obviously, merging it into Linus's tree will fix up everyone's patching
> > problems, but it has no users at this time...
> 
> So, speaking of which, are there any barriers to merging OCFS2 now?  I think
> Christoph's concerns (silly /proc files, vma walking, endian stuff) have been
> addressed.

I think it's in pretty good shape now.  The stuct typedefs should go before
we put it in mainline so we don't need to do a major sweep through everything
just after it appeared in SCM history, but that's just a minor thingy.
Else I'd say it looks good unless we see problems with the AOP_TRUNCATED_PAGE
patch we should send it to linus after the time for the big core merges is
over (aka in about a week or two)
