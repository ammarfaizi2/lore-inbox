Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269659AbTHSMiA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 08:38:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270365AbTHSMiA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 08:38:00 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:27540 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S269659AbTHSMh6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 08:37:58 -0400
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
In-Reply-To: <353568DCBAE06148B70767C1B1A93E625EAB57@post.pc.aspectgroup.co.uk>
References: <353568DCBAE06148B70767C1B1A93E625EAB57@post.pc.aspectgroup.co.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1061296544.30566.8.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 (1.4.3-3) 
Date: 19 Aug 2003 13:35:45 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-08-19 at 13:02, Richard Underwood wrote:
> 	ARP is local to a broadcast net. The ARP standard explicitly
> prohibits responding to an ARP request on a different interface.

Correct, but we don't do that

> 	If you broadcast a request asking for a reply on an entirely
> different subnet, you're asking for trouble. You REDUCE the likelyhood of a
> successful ARP reply, not increase it.

You increase it and you shortcut on shared lans. Thats really a seperate
issue to the question of which source is used. If you loopback someone
elses address on your own lo device I'm not suprised weird shit happens,
put the alias on eth0 where it belongs.

> 	All you can possibly achieve by sending REQUESTS from the wrong IP
> number is assist screwed up networks where you've got multiple subnets on
> the same copper and cause a shed-load of security issues.

Not in general. If you are using ARP your lan is hardly "secure". For
most situations the trust across multiple aggregated lans is the same,
if it isnt people use vlan (which rarely helps 8))



