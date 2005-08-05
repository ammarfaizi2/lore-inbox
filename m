Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263156AbVHEXwq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263156AbVHEXwq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 19:52:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263107AbVHEXwe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 19:52:34 -0400
Received: from ns1.suse.de ([195.135.220.2]:55273 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S263135AbVHEXvX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 19:51:23 -0400
Date: Sat, 6 Aug 2005 01:51:22 +0200
From: Andi Kleen <ak@suse.de>
To: Matt Mackall <mpm@selenic.com>
Cc: Andi Kleen <ak@suse.de>, John B?ckstrand <sandos@home.se>,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: lockups with netconsole on e1000 on media insertion
Message-ID: <20050805235122.GI8266@wotan.suse.de>
References: <42F347D2.7000207@home.se.suse.lists.linux.kernel> <p73ek987gjw.fsf@bragg.suse.de> <20050805201215.GG7425@waste.org> <20050805215650.GH8266@wotan.suse.de> <20050805232015.GX8074@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050805232015.GX8074@waste.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> But why are we in a hurry to dump the backlog on the floor? Why are we
> worrying about the performance of netpoll without the cable plugged in
> at all? We shouldn't be optimizing the data loss case.

Because a system shouldn't stall for minutes (or forever like right now) 
at boot just because the network cable isn't plugged in.

> 
> My primary concern here is that the loop have a non-negligible extent
> in time. 5 loops is effectively equal to none. I'd be very surprised
> if it was even enough for deglitching.

In the normal case the packets should just be send out.

-Andi
