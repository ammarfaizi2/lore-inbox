Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262213AbUDHSfi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 14:35:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262215AbUDHSfi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 14:35:38 -0400
Received: from imr1.ericy.com ([198.24.6.9]:15568 "EHLO imr1.ericy.com")
	by vger.kernel.org with ESMTP id S262213AbUDHSfg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 14:35:36 -0400
Message-ID: <014701c41d98$45e6bac0$0348858e@D4SF2B21>
From: "Mathieu Giguere" <Mathieu.Giguere@ericsson.ca>
To: <Valdis.Kletnieks@vt.edu>,
       "Mathieu Giguere \(QB/EMC\)" <mathieu.giguere@ericsson.com>
Cc: <linux-kernel@vger.kernel.org>
References: <200404081558.i38Fw2SU014685@turing-police.cc.vt.edu>
Subject: Re: IPv4 and IPv6 stack multi-FIB, scalable in the million of entries. 
Date: Thu, 8 Apr 2004 14:35:31 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Re: IPv4 and IPv6 stack multi-FIB, scalable in the million of entries.Hi,

    We working on a edge application for aggregateing a lots of mobile (up
to 100k), then go on the backbone.  We are talking about an access
application not a core.  Each mobile can than have to talk with services we
want to provide to them.

    Our need for now, is around 100k.  But why not try to have a solution
future proof, where can scale up to a memory footprint dedicated for it.
Not limited by the architecture himself.

    Like I said before, it's not a home linux box.  It's a commercial server
serving a lots of users.  But, nothing can prevent home user to benefit from
a more scalable stack.

/mathieu

----- Original Message ----- 
From: Valdis.Kletnieks@vt.edu
To: Mathieu Giguere (QB/EMC)
Cc: linux-kernel@vger.kernel.org
Sent: Thursday, April 08, 2004 11:58 AM
Subject: Re: IPv4 and IPv6 stack multi-FIB, scalable in the million of
entries.


On Thu, 08 Apr 2004 10:40:46 EDT, Mathieu Giguere said:
>     We currently looking for a multi-FIB, scalable routing table in the
> million of entries, no routing cache for IPv4 and IPv6.  We want a IP
stack
> that can have a log(n) (or better) insertion/deletion and lookup
> performance.  Predictable performance, even in the million of entries.
Gaak.
The guys at http://www.cidr-report.org are only showing 130K or so prefixes
in
the global routing table (and estimate that it could be kicked down to 90K
or
so with better CIDR aggregation.
I won't ask what sort of totally martian network design is leading to a
routing
table of millions of entries - even the "stick PMTU info into a host route"
trick
should expire routes to hosts you're not talking to, and you're probably
going
to be wanting a load balancer if you're talking to hundreds of thousands of
machines at the same time.....
