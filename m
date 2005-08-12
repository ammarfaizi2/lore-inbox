Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750727AbVHLRQe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750727AbVHLRQe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 13:16:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750729AbVHLRQe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 13:16:34 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:61650 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750727AbVHLRQd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 13:16:33 -0400
Subject: Re: [PATCH] Fix mmap_kmem (was: [question] What's the difference
	between /dev/kmem and /dev/mem)
From: Arjan van de Ven <arjan@infradead.org>
To: rostedt@goodmis.org
Cc: Dave Jones <davej@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0508121302590.26736@localhost.localdomain>
References: <1123796188.17269.127.camel@localhost.localdomain>
	 <1123809302.17269.139.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0508120930150.3295@g5.osdl.org>
	 <20050812165657.GC13749@redhat.com>
	 <Pine.LNX.4.58.0508121302590.26736@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 12 Aug 2005 19:16:23 +0200
Message-Id: <1123866984.3218.32.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 2.9 (++)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (2.9 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	2.8 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-08-12 at 13:07 -0400, Steven Rostedt wrote:
> 
> On Fri, 12 Aug 2005, Dave Jones wrote:
> >
> > The above patches were in -mm for a while, though they didn't
> > have a config option, they just 'did it', and some of the
> > changes were a bit unclean, but I can polish that up if you're
> > interested.
> 
> Again, I'm asking to have it turned into a config option. Even default to
> off. I understand that /dev/kmem shouldn't be in a production machine.
> There's no reason for it.  But it is nice to have when debugging the
> kernel.  I'll make the changes if need be, to make this into a config
> option (placed in the kernel debug section).  I'll even maintain it to
> keep it working.  But I don't want yet another thing I need to write
> myself for debugging the kernel.

and /proc/kcore doesn't cut it for you?

