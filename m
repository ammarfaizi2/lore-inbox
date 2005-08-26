Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751202AbVHZJE5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751202AbVHZJE5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 05:04:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751054AbVHZJE5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 05:04:57 -0400
Received: from arizona.isc.ch ([195.141.178.2]:18427 "EHLO alton.isc.ch")
	by vger.kernel.org with ESMTP id S1751086AbVHZJE5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 05:04:57 -0400
Date: Fri, 26 Aug 2005 11:04:12 +0200
From: Roger Luethi <rl@hellgate.ch>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Denis Vlasenko <vda@ilport.com.ua>, Patrick Draper <pdraper@gmail.com>,
       Udo van den Heuvel <udovdh@xs4all.nl>, linux-kernel@vger.kernel.org
Subject: Re: VIA Rhine ethernet driver bug (reprise...)
Message-ID: <20050826090412.GA20288@k3.hellgate.ch>
References: <430A0B69.1060304@xs4all.nl> <200508231221.59299.vda@ilport.com.ua> <6981e08b0508252043139cfa2d@mail.gmail.com> <200508260933.45402.vda@ilport.com.ua> <430EC985.6040307@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <430EC985.6040307@pobox.com>
X-Operating-System: Linux 2.6.13-rc3 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Aug 2005 03:49:25 -0400, Jeff Garzik wrote:
> Denis Vlasenko wrote:
> >May be a known problem. A buglet in MII common code.
> >Via-rhine maintainer knows about it, as does Jeff.
> 
> You don't speak for me, sir.
> 
> I know of no such problem.  Please submit a report and/or patch.

I believe vda may have been referring to this. I can send you the
original thread if it's not in your mail archive.

Roger

------------------------------ cut here ------------------------------
From: Roger Luethi <rl@hellgate.ch>
Subject: Re: via-rhine + link loss + autoneg off == trouble
To: Denis Vlasenko <vda@ilport.com.ua>, Jeff Garzik <jgarzik@pobox.com>
Cc: "David S. Miller" <davem@davemloft.net>, linux-net@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date: Sat, 13 Aug 2005 20:34:21 +0200
User-Agent: Mutt/1.5.8i

Jeff, can you tune in for a moment?

First of all, many thanks to vda for tracking this down, and to everyone
else who helped with it.

I had a look at my code and at 8139cp (which is one of only a handful
of drivers that have been converted to use the generic MII stuff).

Turns out 8139cp doesn't seem to do anything to address the problem
vda described, either, so it is equally affected. Is this something we
should fix in mii.c, or is mii_check_media working as designed? Btw,
I'd be thrilled if someone wrote a few lines per function in mii.c:
purpose, preconditions, side effects, something along these lines.

Roger
------------------------------ cut here ------------------------------

