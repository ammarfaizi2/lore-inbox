Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964811AbWGEKj3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964811AbWGEKj3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 06:39:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964813AbWGEKj2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 06:39:28 -0400
Received: from hp3.statik.TU-Cottbus.De ([141.43.120.68]:20918 "EHLO
	hp3.statik.tu-cottbus.de") by vger.kernel.org with ESMTP
	id S964807AbWGEKj1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 06:39:27 -0400
Message-ID: <44AB9633.9090208@s5r6.in-berlin.de>
Date: Wed, 05 Jul 2006 12:36:35 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.7.12) Gecko/20050915
X-Accept-Language: de, en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: netdev@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.17-mm6
References: <20060703030355.420c7155.akpm@osdl.org>	 <200607042153.31848.rjw@sisk.pl> <1152043271.3109.95.camel@laptopd505.fenrus.org> <44AB940F.7000801@s5r6.in-berlin.de>
In-Reply-To: <44AB940F.7000801@s5r6.in-berlin.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wrote:
> (Ieee1394 core's usage of the skb_* API is entirely unrelated to
> networking; even if eth1394 was used.)

PS:
I wonder if it wouldn't be better to migrate ieee1394 core away from
skb_*. I didn't look thoroughly at it yet but the benefit of using this
API appears quite low to me.

We use it to keep track of IEEE 1394 transactions [ = outgoing request
&& (incoming response || expiry)], with completion of transactions often
in-order due to mostly single-threaded usage, but sometimes out-of-order
(may happen regardless of multithreaded or single-threaded usage).
-- 
Stefan Richter
-=====-=-==- -=== --=-=
http://arcgraph.de/sr/
