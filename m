Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132077AbRDPUty>; Mon, 16 Apr 2001 16:49:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132057AbRDPUto>; Mon, 16 Apr 2001 16:49:44 -0400
Received: from netsonic.fi ([194.29.192.20]:28433 "EHLO nalle.netsonic.fi")
	by vger.kernel.org with ESMTP id <S132056AbRDPUtl>;
	Mon, 16 Apr 2001 16:49:41 -0400
Date: Mon, 16 Apr 2001 23:49:35 +0300 (EEST)
From: Sampsa Ranta <sampsa@netsonic.fi>
To: <linux-net@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <zebra@zebra.org>
Subject: ARP responses broken!
Message-ID: <Pine.LNX.4.33.0104162335170.30406-100000@nalle.netsonic.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello, I had a mystery with my Linux running 2.4.2 kernel with ARP packet
response.

I have two interfaces that share same subnet, I call eth0 194.29.192.37
and eth1 194.29.192.38. I have forwarding turned on, proxy arp is not
neighter are redirects.

When I flush local neighbor table in other machine I use to observe the
response and ping the router I get response like:

23:38:25.278848 > arp who-has 194.29.192.38 tell 194.29.192.10 (0:50:da:82:ae:9f)
23:38:25.278988 < arp reply 194.29.192.38 is-at 0:1:2:dc:d2:64 (0:50:da:82:ae:9f)
23:38:25.279009 < arp reply 194.29.192.38 is-at 0:1:2:dc:d2:6c (0:50:da:82:ae:9f)

The second one is the valid one, but both interfaces seem to answer to the
broadcasted packet with their own ARP addresses.

This came up when I wondered why I get responses to wrong interface with
Zebra.

 - Sampsa Ranta
   sampsa@netsonic.fi

