Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262236AbUDHSln (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 14:41:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262220AbUDHSlU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 14:41:20 -0400
Received: from mx1.redhat.com ([66.187.233.31]:28633 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262217AbUDHSlS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 14:41:18 -0400
Date: Thu, 8 Apr 2004 11:33:50 -0700
From: "David S. Miller" <davem@redhat.com>
To: "Mathieu Giguere" <Mathieu.Giguere@ericsson.ca>
Cc: ak@muc.de, netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: IPv4 and IPv6 stack multi-FIB, scalable in the million of
 entries.
Message-Id: <20040408113350.03ef5b5c.davem@redhat.com>
In-Reply-To: <012201c41d94$cee1b400$0348858e@D4SF2B21>
References: <1IJuR-8qH-39@gated-at.bofh.it>
	<m3ptaiwfpq.fsf@averell.firstfloor.org>
	<012201c41d94$cee1b400$0348858e@D4SF2B21>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Apr 2004 14:10:43 -0400
"Mathieu Giguere" <Mathieu.Giguere@ericsson.ca> wrote:

> The main goal to remove the routing cache is to avoid to have 4096 routes
> limitation

This 4K routes limitation is news to everyone who works on this
code.

When nexthop changes we _MUST_ flush PMTU etc. information because that
could have changed.  If however, such information is locked into the
route itself, it will propagate immediately into the routing cache
entry once recreated.

You seem to be talking about a lot of non-problems, but this may because
you're not providing enough details.
