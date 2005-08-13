Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932227AbVHMSfN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932227AbVHMSfN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Aug 2005 14:35:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932248AbVHMSfM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Aug 2005 14:35:12 -0400
Received: from arizona.isc.ch ([195.141.178.2]:29178 "EHLO alton.isc.ch")
	by vger.kernel.org with ESMTP id S932227AbVHMSfL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Aug 2005 14:35:11 -0400
Date: Sat, 13 Aug 2005 20:34:21 +0200
From: Roger Luethi <rl@hellgate.ch>
To: Denis Vlasenko <vda@ilport.com.ua>, Jeff Garzik <jgarzik@pobox.com>
Cc: "David S. Miller" <davem@davemloft.net>, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: via-rhine + link loss + autoneg off == trouble
Message-ID: <20050813183421.GA16360@k3.hellgate.ch>
References: <200508111350.42435.vda@ilport.com.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508111350.42435.vda@ilport.com.ua>
X-Operating-System: Linux 2.6.13-rc3 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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
