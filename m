Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263456AbRFALpj>; Fri, 1 Jun 2001 07:45:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263457AbRFALp3>; Fri, 1 Jun 2001 07:45:29 -0400
Received: from mgw-x2.nokia.com ([131.228.20.22]:32246 "EHLO mgw-x2.nokia.com")
	by vger.kernel.org with ESMTP id <S263456AbRFALpS>;
	Fri, 1 Jun 2001 07:45:18 -0400
Date: Fri, 1 Jun 2001 14:44:32 +0300
To: linux-kernel@vger.kernel.org
Subject: Q: ip_build_and_send_pkt
Message-ID: <20010601144432.A7887@Hews1193nrc>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
User-Agent: Mutt/1.3.18i
From: alexey.vyskubov@nokia.com (Alexey Vyskubov)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

I have a couple of questions about 2.4.5 IP layer and will be very grateful if
someone will answer :)

In net/ipv4/ip_output.c there is the function ip_build_and_send_pkt().
This function adds an IP header to given skbuff and sends it out. 
But it seems that the only place where this function is called is 
tcp_v4_send_synack() in tcp_ipv4.c.

Questions:

1. What is the difference between tcp synack and other types of packets? Why
tcp synack needs separate entry point in IP layer?
2. Is it really good to have such common name (ip_build_and_send_pkt) for this
function? I'd say that function with this name pretends to be IP layer entry
point for upper layer protocols. But it isn't?


-- 
Alexey
