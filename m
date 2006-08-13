Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750780AbWHMJHL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750780AbWHMJHL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 05:07:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750774AbWHMJHK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 05:07:10 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:39366 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1750770AbWHMJHJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 05:07:09 -0400
Date: Sun, 13 Aug 2006 13:06:21 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: David Miller <davem@davemloft.net>
Cc: a.p.zijlstra@chello.nl, riel@redhat.com, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       phillips@google.com
Subject: Re: [RFC][PATCH 0/9] Network receive deadlock prevention for NBD
Message-ID: <20060813090620.GB14960@2ka.mipt.ru>
References: <20060812084713.GA29523@2ka.mipt.ru> <1155374390.13508.15.camel@lappy> <20060812093706.GA13554@2ka.mipt.ru> <20060812.174607.44371641.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20060812.174607.44371641.davem@davemloft.net>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Sun, 13 Aug 2006 13:06:24 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 12, 2006 at 05:46:07PM -0700, David Miller (davem@davemloft.net) wrote:
> From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
> Date: Sat, 12 Aug 2006 13:37:06 +0400
> 
> > Does it? I though it is possible to only have 64k of working sockets per
> > device in TCP.
> 
> Where does this limit come from?
> 
> You think there is something magic about 64K local ports,
> but if remote IP addresses in the TCP socket IDs are all
> different, number of possible TCP sockets is only limited
> by "number of client IPs * 64K" and ram :-)

I talked about working sockets, but not about how many of them system
can have at all :)

-- 
	Evgeniy Polyakov
