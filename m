Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318502AbSH1Bft>; Tue, 27 Aug 2002 21:35:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318516AbSH1Bft>; Tue, 27 Aug 2002 21:35:49 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:57869 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S318502AbSH1Bfs>; Tue, 27 Aug 2002 21:35:48 -0400
Date: Wed, 28 Aug 2002 05:40:01 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Manfred Spraul <manfred@colorfullife.com>, linux-kernel@vger.kernel.org,
       torvalds@transmeta.com
Subject: Re: [patch 2.5.31] transparent PCI-to-PCI bridges
Message-ID: <20020828054001.B31036@jurassic.park.msu.ru>
References: <20020826175747.A27952@jurassic.park.msu.ru> <20020826201224.528@192.168.4.1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020826201224.528@192.168.4.1>; from benh@kernel.crashing.org on Mon, Aug 26, 2002 at 10:12:24PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 26, 2002 at 10:12:24PM +0200, Benjamin Herrenschmidt wrote:
> While we are at it, I still think the loop copying parent resource
> pointers in the case of a transparent bridge should copy the 4
> resource pointers of the parent and not only 3.

I agree that hardcoding the resource numbers is bad.
Instead, I suggest the following:
s/bus->resource[0]/bus->io/
s/bus->resource[1]/bus->mem/
s/bus->resource[2]/bus->pref_mem/
s/bus->resource[3]//

There are only 3 _bus_ resources - the PCI works this way.

Please don't propose your arch specific hacks to generic code.

Ivan.
