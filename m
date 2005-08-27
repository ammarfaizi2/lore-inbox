Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030292AbVH0D6e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030292AbVH0D6e (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 23:58:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030297AbVH0D6e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 23:58:34 -0400
Received: from gaz.sfgoth.com ([69.36.241.230]:39151 "EHLO gaz.sfgoth.com")
	by vger.kernel.org with ESMTP id S1030292AbVH0D6d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 23:58:33 -0400
Date: Fri, 26 Aug 2005 21:06:22 -0700
From: Mitchell Blank Jr <mitch@sfgoth.com>
To: Andi Kleen <ak@suse.de>
Cc: "David S. Miller" <davem@davemloft.net>, rml@novell.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] IBM HDAPS accelerometer driver, with probing.
Message-ID: <20050827040622.GH91880@gaz.sfgoth.com>
References: <1125094725.18155.120.camel@betsy> <20050826225848.GC28191@mipter.zuzino.mipt.ru> <20050826.161537.03992270.davem@davemloft.net> <p73vf1skt0g.fsf@verdi.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p73vf1skt0g.fsf@verdi.suse.de>
User-Agent: Mutt/1.4.2.1i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.2.2 (gaz.sfgoth.com [127.0.0.1]); Fri, 26 Aug 2005 21:06:23 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> - it doesn't seem to help that much on modern CPUs with good
> branch prediction and big icaches anyways.

Really?  I would think that as pipelines get deeper (although that trend
seems to have stopped, thankfully) and Icache-miss penalties get relatively
larger we'd see unlikely() becoming MORE of a benefit, not less.  Storing
the used part of a "hot" function in 1 Icacheline instead of 4 seems like
an obvious win.

Personally I've never found unlikely() to be ugly; if anything I think
it serves as a nice little human-readable comment about whats going on
in the control-flow.  I guess I'm in the minority on that one, though.

-Mitch
