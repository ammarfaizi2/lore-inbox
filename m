Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132683AbRDQO0s>; Tue, 17 Apr 2001 10:26:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132681AbRDQO02>; Tue, 17 Apr 2001 10:26:28 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:52697 "EHLO
	zcars04f.ca.nortel.com") by vger.kernel.org with ESMTP
	id <S132664AbRDQO0R>; Tue, 17 Apr 2001 10:26:17 -0400
Message-ID: <3ADC5238.DA984996@nortelnetworks.com>
Date: Tue, 17 Apr 2001 10:24:56 -0400
From: "Christopher Friesen" <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.7 [en] (X11; U; HP-UX B.10.20 9000/778)
X-Accept-Language: en
MIME-Version: 1.0
To: Sampsa Ranta <sampsa@netsonic.fi>
CC: linux-net <linux-net@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: ARP responses broken!
In-Reply-To: <Pine.LNX.4.33.0104162335170.30406-100000@nalle.netsonic.fi>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Orig: <cfriesen@americasm01.nt.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sampsa Ranta wrote:

> I have two interfaces that share same subnet, I call eth0 194.29.192.37
> and eth1 194.29.192.38. I have forwarding turned on, proxy arp is not
> neighter are redirects.
> 
> When I flush local neighbor table in other machine I use to observe the
> response and ping the router I get response like:
> 
> 23:38:25.278848 > arp who-has 194.29.192.38 tell 194.29.192.10 (0:50:da:82:ae:9f)
> 23:38:25.278988 < arp reply 194.29.192.38 is-at 0:1:2:dc:d2:64 (0:50:da:82:ae:9f)
> 23:38:25.279009 < arp reply 194.29.192.38 is-at 0:1:2:dc:d2:6c (0:50:da:82:ae:9f)
> 
> The second one is the valid one, but both interfaces seem to answer to the
> broadcasted packet with their own ARP addresses.

This is the default Linux behaviour.  It can be turned off by running the
following command as root:

echo 1 > /proc/sys/net/ipv4/conf/all/arp_filter

This ensures that interfaces will only respond to arp requests for IP addresses
which are configured as belonging to that particular interface.

Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
