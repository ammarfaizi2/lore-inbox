Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261986AbUK3Gw5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261986AbUK3Gw5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 01:52:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261984AbUK3Gwo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 01:52:44 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:22538 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S261983AbUK3Gwh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 01:52:37 -0500
Date: Tue, 30 Nov 2004 07:43:38 +0100
From: Willy Tarreau <willy@w.ods.org>
To: kernel <kernel@nea-fast.com>
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.9 tcp problems
Message-ID: <20041130064338.GI783@alpha.home.local>
References: <41AB6476.8060405@nea-fast.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41AB6476.8060405@nea-fast.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It is possible that the autoneg code has changed between 2.4 and 2.6
for the interface connected to the current firewall, and that you lose
packets because of a duplex mismatch. Please check the negociation
with ethtool on your system, and do so on the other firewall.

Regards,
willy

On Mon, Nov 29, 2004 at 01:03:34PM -0500, kernel wrote:
> I've run into a problem with 2.6.(8.1,9) after installing a secondary 
> firewall. When I try to pull data through the original firewall (mail, 
> http, ssh), it stops after approx. 260k. Running ethereal tells me "A 
> segment before the frame was lost" followed by a bunch of  "This is a 
> TCP duplicate ack" when using ssh. All 2.4.x machines and windows 
> clients work fine. I built 2.4.28 and it works fine from my machine. I 
> also fiddled with tcp_ecn and that didn't fix it either. I don't have 
> any problems communicating to "local" machines. I've attached the 
> tcpdump output from an scp attempt. NIC is a 3Com Corporation 3c905B.
> 
> Thanks !
> walt
> 


