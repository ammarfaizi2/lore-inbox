Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318334AbSGRTiP>; Thu, 18 Jul 2002 15:38:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318336AbSGRTiP>; Thu, 18 Jul 2002 15:38:15 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:48374 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318334AbSGRTiO>; Thu, 18 Jul 2002 15:38:14 -0400
Subject: Re: [PATCH] strict VM overcommit for stock 2.4
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Robert Love <rml@tech9.net>
Cc: Szakacsits Szabolcs <szaka@sienet.hu>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <1027018340.1086.134.camel@sinai>
References: <Pine.LNX.4.30.0207181930170.30902-100000@divine.city.tvnet.hu>
	<1027022323.8154.38.camel@irongate.swansea.linux.org.uk> 
	<1027018340.1086.134.camel@sinai>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 18 Jul 2002 21:52:12 +0100
Message-Id: <1027025532.8154.44.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Thu, 2002-07-18 at 19:52, Robert Love wrote:
> On Thu, 2002-07-18 at 12:58, Alan Cox wrote:
> 
> > Adjusting the percentages to have a root only zone is doable. It helps
> > in some conceivable cases but not all. Do people think its important, if
> > so I'll add it
> 
> Changing the rules would be easy, but you would need to make the
> accounting check for root vs non-root and keep track accordingly. 
> Admittedly not hard but not entirely pretty either.
> 
> I still contend the issues are not related.  It would make more sense to
> me to do resource limits to solve this problem - rlimits are something
> Rik has on his TODO and supposedly easy to add to rmap.

rmap supports rlimit AS which gives you paging control. Neither of them
support workload management or partitioned accounting of any kind. That
would need the beancounter patches resurrecting.

