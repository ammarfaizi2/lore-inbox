Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318322AbSGRSuS>; Thu, 18 Jul 2002 14:50:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318323AbSGRSuS>; Thu, 18 Jul 2002 14:50:18 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:45040 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S318322AbSGRSuR>; Thu, 18 Jul 2002 14:50:17 -0400
Subject: Re: [PATCH] strict VM overcommit for stock 2.4
From: Robert Love <rml@tech9.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Szakacsits Szabolcs <szaka@sienet.hu>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <1027022323.8154.38.camel@irongate.swansea.linux.org.uk>
References: <Pine.LNX.4.30.0207181930170.30902-100000@divine.city.tvnet.hu>
	 <1027022323.8154.38.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 18 Jul 2002 11:52:19 -0700
Message-Id: <1027018340.1086.134.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-07-18 at 12:58, Alan Cox wrote:

> Adjusting the percentages to have a root only zone is doable. It helps
> in some conceivable cases but not all. Do people think its important, if
> so I'll add it

Changing the rules would be easy, but you would need to make the
accounting check for root vs non-root and keep track accordingly. 
Admittedly not hard but not entirely pretty either.

I still contend the issues are not related.  It would make more sense to
me to do resource limits to solve this problem - rlimits are something
Rik has on his TODO and supposedly easy to add to rmap.

That way people can use strict overcommit, rlimits, neither, or both to
meet their needs.

	Robert Love

