Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261257AbUKBRBK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261257AbUKBRBK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 12:01:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261253AbUKBRBJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 12:01:09 -0500
Received: from 0.fe-0-0-0.c1.pfn.citynetwireless.net ([209.218.71.2]:1191 "EHLO
	core.citynetwireless.net") by vger.kernel.org with ESMTP
	id S261791AbUKBQsx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 11:48:53 -0500
Date: Tue, 2 Nov 2004 10:48:36 -0600
From: parker@citynetwireless.net
To: herbert@gondor.apana.org.au
Cc: linux-kernel@vger.kernel.org
Subject: Re: ICMP ttl-exceeded packets not sourced correctly
Message-ID: <20041102164836.GA8066@core.citynetwireless.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Then check for that, and fall back to route lookup if it's receive-only. BSD
already does this, and so does all other router manufacturers, but it's broken
under Linux. I think David Schwartz is completely missing the point of having
multiple providers, hence the reason for the source address to be different.

parker@citynetwireless.net wrote:
>
> ICMP ttl-exceeded code's response should not be originated from the interface
> holding the route, but should be origianted from the interface that got hit
> with the traceroute.

What if the interface is a receive-only interface?
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/


-- 
Bubba Parker
sysadmin@citynetwireless.net
CityNet LLC
http://www.citynetinfo.com/
