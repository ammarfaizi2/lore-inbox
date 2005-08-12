Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750784AbVHLR5E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750784AbVHLR5E (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 13:57:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750781AbVHLR4j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 13:56:39 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:37295 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750805AbVHLR4d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 13:56:33 -0400
Subject: Re: [PATCH] Fix mmap_kmem (was: [question] What's the difference 
	between /dev/kmem and /dev/mem)
From: Arjan van de Ven <arjan@infradead.org>
To: Andi Kleen <ak@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       hugh@veritas.com
In-Reply-To: <p73br432izq.fsf@verdi.suse.de>
References: <1123796188.17269.127.camel@localhost.localdomain.suse.lists.linux.kernel>
	 <1123809302.17269.139.camel@localhost.localdomain.suse.lists.linux.kernel>
	 <Pine.LNX.4.58.0508120930150.3295@g5.osdl.org.suse.lists.linux.kernel>
	 <p73br432izq.fsf@verdi.suse.de>
Content-Type: text/plain
Date: Fri, 12 Aug 2005 19:56:26 +0200
Message-Id: <1123869386.3218.37.camel@laptopd505.fenrus.org>
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

On Fri, 2005-08-12 at 18:54 +0200, Andi Kleen wrote:
> Linus Torvalds <torvalds@osdl.org> writes:
> > 
> > I'm actually more inclined to try to deprecate /dev/kmem.. I don't think 
> > anybody has ever really used it except for some rootkits. 
> 
> I don't think that's true.

got any examples ?

>  
> > So I'd be perfectly happy to fix this, but I'd be even happier if we made 
> > the whole kmem thing a config variable (maybe even default it to "off").
> 
> Acessing vmalloc in /dev/mem would be pretty awkward. Yes it doesn't
> also work in mmap of /dev/kmem, but at least in read/write.
> There are quite a lot of scripts that use it for kernel debugging
> like dumping variables. And for that you really want to access modules
> and vmalloc. And it's much easier to parse than /proc/kcore

but you can stick gdb on /proc/kcore...


