Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261282AbULXJOo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261282AbULXJOo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Dec 2004 04:14:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261383AbULXJOo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Dec 2004 04:14:44 -0500
Received: from canuck.infradead.org ([205.233.218.70]:47886 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261281AbULXJOl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Dec 2004 04:14:41 -0500
Subject: Re: Prezeroing V2 [0/3]: Why and When it works
From: Arjan van de Ven <arjan@infradead.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Paul Mackerras <paulus@samba.org>, Christoph Lameter <clameter@sgi.com>,
       Andrew Morton <akpm@osdl.org>, linux-ia64@vger.kernel.org,
       linux-mm@kvack.org, Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0412231325420.2654@ppc970.osdl.org>
References: <B8E391BBE9FE384DAA4C5C003888BE6F02900FBD@scsmsx401.amr.corp.intel.com>
	 <41C20E3E.3070209@yahoo.com.au>
	 <Pine.LNX.4.58.0412211154100.1313@schroedinger.engr.sgi.com>
	 <Pine.LNX.4.58.0412231119540.31791@schroedinger.engr.sgi.com>
	 <16843.13418.630413.64809@cargo.ozlabs.ibm.com>
	 <Pine.LNX.4.58.0412231325420.2654@ppc970.osdl.org>
Content-Type: text/plain
Date: Fri, 24 Dec 2004 10:14:27 +0100
Message-Id: <1103879668.4131.15.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 4.1 (++++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
	Content analysis details:   (4.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.3 RCVD_NUMERIC_HELO      Received: contains a numeric HELO
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Personally, at least for a desktop usage, I think that the load average 
> would work wonderfully well. I know my machines are often at basically 
> zero load, and then having low-latency zero-pages when I sit down sounds 
> like a good idea. Whether there is _enough_ free memory around for a 
> 5-second thing to work out well, I have no idea..

problem is.. will it buy you anything if you use the page again
anyway... since such pages will be cold cached now. So for sure some of
it is only shifting latency from kernel side to userspace side, but
readprofile doesn't measure the later so it *looks* better...


