Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261236AbTHSTPr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 15:15:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261238AbTHSTPd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 15:15:33 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:22678 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S261332AbTHSTKP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 15:10:15 -0400
Subject: RE: [2.4 PATCH] bugfix: ARP respond on all devices
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Richard Underwood <richard@aspectgroup.co.uk>
Cc: "'David S. Miller'" <davem@redhat.com>,
       Stephan von Krawczynski <skraw@ithnet.com>, willy@w.ods.org,
       carlosev@newipnet.com, lamont@scriptkiddie.org, davidsen@tmr.com,
       bloemsaa@xs4all.nl, Marcelo Tosatti <marcelo@conectiva.com.br>,
       netdev@oss.sgi.com, linux-net@vger.kernel.org, layes@loran.com,
       torvalds@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <353568DCBAE06148B70767C1B1A93E625EAB58@post.pc.aspectgroup.co.uk>
References: <353568DCBAE06148B70767C1B1A93E625EAB58@post.pc.aspectgroup.co.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1061320099.30567.55.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 (1.4.3-3) 
Date: 19 Aug 2003 20:08:20 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-08-19 at 15:34, Richard Underwood wrote:
> # arp -d 172.24.0.80
> # ping -I 172.20.240.2 172.24.0.80
> 
> 	I see:
> 
> 16:18:40.856328 arp who-has 172.24.0.80 tell 172.20.240.2
> 16:18:40.856431 arp reply 172.24.0.80 is-at 0:50:da:44:f:37

Fine

> 	But if I was to do this in the other direction (arp -d 172.20.240.1;
> ping -I 172.24.0.1 172.20.240.1) then I'd lose connectivity over my default
> route because 172.20.240.1 won't accept ARP packets from IP numbers not on
> the connected subnet. The <incomplete> ARP entry will block any further ARP
> requests from valid IP numbers.

One thing I agree with you about is that an ARP resolution for an
address via one path should not block a resolution for it by another
path since to begin with the two paths may be to different routers
one of which is down.

