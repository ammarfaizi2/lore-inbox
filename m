Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261328AbTDCQvc 
	(for <rfc822;willy@w.ods.org>); Thu, 3 Apr 2003 11:51:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id S261346AbTDCQvc 
	(for <rfc822;linux-kernel-outgoing>); Thu, 3 Apr 2003 11:51:32 -0500
Received: from dns.toxicfilms.tv ([150.254.37.24]:10893 "EHLO
	dns.toxicfilms.tv") by vger.kernel.org with ESMTP
	id S261328AbTDCQvb 
	(for <rfc822;linux-kernel@vger.kernel.org>); Thu, 3 Apr 2003 11:51:31 -0500
Date: Thu, 3 Apr 2003 19:02:55 +0200 (CEST)
From: Maciej Soltysiak <solt@dns.toxicfilms.tv>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: my linux does not accept redirects
In-Reply-To: <Pine.LNX.4.53.0304021019210.30327@chaos>
Message-ID: <Pine.LNX.4.51.0304021727440.2739@dns.toxicfilms.tv>
References: <Pine.LNX.4.51.0304021657090.2465@dns.toxicfilms.tv>
 <Pine.LNX.4.53.0304021019210.30327@chaos>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >
> > What could be wrong?
> >
>
> How would it learn? If everybody is going to set their default
> route to your box A, and box A routes internally, then box A needs its
> default route to go to the internet-box B.
>From my investigation i have found that my box stores routes based on
icmp redirects (as seen with netstat -C) and it does learn the routes
but not for all routes. Please look at this printout:

<snip>
dns.toxicfilms. trek13.sv.av.co nihil.ae.poznan       0      0        4 eth1
dns.toxicfilms. nms.cyf-kr.edu. alnair.ae.pozna       0      0        6 eth1
<snip>

dns.toxicfilms.tv is my box

nihil.ae.poznan.pl is the router that routes to my other public nets
alnair.ae.poznan.pl is the Internet Gateway.

Why did not my box learn to send packets to trek13.sv.av.com via alnair ?

it's 2.4.20-xfs, no other patches.
I am running a similar box on the same net with 2.5.66-mm2 and i do not
see this effect, thus i presume, it's not a configuration error.

Having one default route via Router A (nihil) should cause only one
redirect per one connections. But i get flooded for every packet.

Regards,
Maciej


