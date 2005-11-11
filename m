Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932321AbVKKJnx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932321AbVKKJnx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 04:43:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932320AbVKKJnx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 04:43:53 -0500
Received: from havoc.gtf.org ([69.61.125.42]:49608 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S932318AbVKKJnw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 04:43:52 -0500
Date: Fri, 11 Nov 2005 04:43:47 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       davem@davemloft.net, shemminger@osdl.org
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH] TCP build fix
Message-ID: <20051111094347.GA10876@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Recent TCP changes broke the build.

Signed-off-by: Jeff Garzik <jgarzik@pobox.com>

diff --git a/net/ipv4/tcp_vegas.c b/net/ipv4/tcp_vegas.c
index 4376814..b7d296a 100644
--- a/net/ipv4/tcp_vegas.c
+++ b/net/ipv4/tcp_vegas.c
@@ -236,7 +236,7 @@ static void tcp_vegas_cong_avoid(struct 
 			/* We don't have enough RTT samples to do the Vegas
 			 * calculation, so we'll behave like Reno.
 			 */
-			tcp_reno_cong_avoid(sk, ack, seq_rtt, in_flight, cnt);
+			tcp_reno_cong_avoid(sk, ack, seq_rtt, in_flight, flag);
 		} else {
 			u32 rtt, target_cwnd, diff;
 
