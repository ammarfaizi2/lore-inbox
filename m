Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751002AbVKKSmT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751002AbVKKSmT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 13:42:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751015AbVKKSmS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 13:42:18 -0500
Received: from smtp.osdl.org ([65.172.181.4]:50411 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751002AbVKKSmR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 13:42:17 -0500
Message-ID: <4374E5E2.70801@osdl.org>
Date: Fri, 11 Nov 2005 10:41:38 -0800
From: Stephen Hemminger <shemminger@osdl.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       davem@davemloft.net, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: [PATCH] TCP build fix
References: <20051111094347.GA10876@havoc.gtf.org>
In-Reply-To: <20051111094347.GA10876@havoc.gtf.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:

>Recent TCP changes broke the build.
>
>Signed-off-by: Jeff Garzik <jgarzik@pobox.com>
>
>diff --git a/net/ipv4/tcp_vegas.c b/net/ipv4/tcp_vegas.c
>index 4376814..b7d296a 100644
>--- a/net/ipv4/tcp_vegas.c
>+++ b/net/ipv4/tcp_vegas.c
>@@ -236,7 +236,7 @@ static void tcp_vegas_cong_avoid(struct 
> 			/* We don't have enough RTT samples to do the Vegas
> 			 * calculation, so we'll behave like Reno.
> 			 */
>-			tcp_reno_cong_avoid(sk, ack, seq_rtt, in_flight, cnt);
>+			tcp_reno_cong_avoid(sk, ack, seq_rtt, in_flight, flag);
> 		} else {
> 			u32 rtt, target_cwnd, diff;
> 
>  
>
Sorry, must have happened when juggling the test and release tree.

