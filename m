Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261793AbVGKOKD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261793AbVGKOKD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 10:10:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261786AbVGKOHf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 10:07:35 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:58004 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261752AbVGKOG3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 10:06:29 -0400
Subject: Re: [RFC][PATCH] i386: Per node IDT
From: Arjan van de Ven <arjan@infradead.org>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0507110804210.16055@montezuma.fsmlabs.com>
References: <Pine.LNX.4.61.0507101617240.16055@montezuma.fsmlabs.com.suse.lists.linux.kernel>
	 <p73eka614t7.fsf@verdi.suse.de>
	 <1121054565.3177.2.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.61.0507110804210.16055@montezuma.fsmlabs.com>
Content-Type: text/plain
Date: Mon, 11 Jul 2005 16:05:53 +0200
Message-Id: <1121090754.3177.26.camel@laptopd505.fenrus.org>
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

On Mon, 2005-07-11 at 08:09 -0600, Zwane Mwaikambo wrote:
> On Mon, 11 Jul 2005, Arjan van de Ven wrote:
> 
> > On Mon, 2005-07-11 at 03:59 +0200, Andi Kleen wrote:
> > > Why per node? Why not go the whole way and make it per CPU?
> > 
> > Agreed, for two reasons even
> > 1) Per cpu allows for even more devices and cache locality
> > 2) While few people have a NUMA system, many have an SMP system so you
> > get a lot more testing.
> 
> Agreed, the first version was a per cpu one simply so that i could test it 
> on a normal SMP system. Andi seems to be of the same opinion, what do you 
> think of the hotplug cpu case (explained in previous email)?

you need to cope with hotplug of entire nodes anyway, or hotunplug of
the last cpu of a node. In fact I bet that the administration needed
will be LESS in the per cpu case (since you know it's the only one)
compared to the per node case.


