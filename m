Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261626AbVDTN6E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261626AbVDTN6E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 09:58:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261627AbVDTN6E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 09:58:04 -0400
Received: from unthought.net ([212.97.129.88]:175 "EHLO unthought.net")
	by vger.kernel.org with ESMTP id S261626AbVDTN57 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 09:57:59 -0400
Date: Wed, 20 Apr 2005 15:57:58 +0200
From: Jakob Oestergaard <jakob@unthought.net>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Greg Banks <gnb@melbourne.sgi.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: bdflush/rpciod high CPU utilization, profile does not make sense
Message-ID: <20050420135758.GS17359@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Trond Myklebust <trond.myklebust@fys.uio.no>,
	Greg Banks <gnb@melbourne.sgi.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1113222939.14281.17.camel@lade.trondhjem.org> <20050411134703.GC13369@unthought.net> <1113230125.9962.7.camel@lade.trondhjem.org> <20050411144127.GE13369@unthought.net> <1113232905.9962.15.camel@lade.trondhjem.org> <20050411154211.GG13369@unthought.net> <1113267809.1956.242.camel@hole.melbourne.sgi.com> <20050412092843.GB17359@unthought.net> <20050419194515.GP17359@unthought.net> <1113950788.10685.9.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1113950788.10685.9.camel@lade.trondhjem.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2005 at 06:46:28PM -0400, Trond Myklebust wrote:
> ty den 19.04.2005 Klokka 21:45 (+0200) skreiv Jakob Oestergaard:
> 
> > It mounts a home directory from a 2.6.6 NFS server - the client and
> > server are on a hub'ed 100Mbit network.
> > 
> > On the earlier 2.6 client I/O performance was as one would expect on
> > hub'ed 100Mbit - meaning, not exactly stellar, but you'd get around 4-5
> > MB/sec and decent interactivity.
> 
> OK, hold it right there...
> 
...
> Also, does that hub support NICs that do autonegotiation? (I'll bet the
> answer is "no").

*blush*

Ok Trond, you got me there - I don't know why upgrading the client made
the problem much more visible though, but the *server* had negotiated
full duplex rather than half (the client negotiated half ok). Fixing
that on the server side made the client pleasent to work with again.
Mom's a happy camper now again  ;)

Sorry for jumping the gun there...

To get back to the original problem;

I wonder if (as was discussed) the tg3 driver on my NFS server is
dropping packets, causing the 2.6.11 NFS client to misbehave... This
didn't make sense to me before (since earlier clients worked well), but
having just seen this other case where a broken server setup caused
2.6.11 clients to misbehave (where earlier clients were fine), maybe it
could be an explanation...

Will try either changing tg3 driver or putting in an e1000 on my NFS
server - I will let you know about the status on this when I know more.

Thanks all,

-- 

 / jakob

