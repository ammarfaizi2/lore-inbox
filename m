Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263885AbTLTRKF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Dec 2003 12:10:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263930AbTLTRKF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Dec 2003 12:10:05 -0500
Received: from mail.actcom.co.il ([192.114.47.15]:56495 "EHLO
	smtp2.actcom.co.il") by vger.kernel.org with ESMTP id S263885AbTLTRJ7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Dec 2003 12:09:59 -0500
From: Gilad Ben-Yossef <gilad@codefidence.com>
Organization: Codefidence. A name you can trust (tm)
To: David T Hollis <dhollis@davehollis.com>, Madhavi <madhavis@sasken.com>
Subject: Re: VLAN switching in linux kernel...
Date: Sat, 20 Dec 2003 19:07:36 +0200
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.33.0312191736510.17109-100000@pcz-madhavis.sasken.com> <1071837956.8316.1.camel@dhollis-lnx.kpmg.com>
In-Reply-To: <1071837956.8316.1.camel@dhollis-lnx.kpmg.com>
X-Cabal: "There is no IGLU Cabal"
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-8-i"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312201907.36311.gilad@codefidence.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 19 December 2003 14:45, David T Hollis wrote:

> > When I send ping packets from HA to HB over the interface eth0.200,
> > is possible for the Router (using linux-2.4.20 with CONFIG_8021Q
> > option) to switch packets from VLAN 200 to VLAN 300?
> >
> > Is this VLAN switching functionality supported by the standard
> > linux kernel? Is there some extra configuration, some patches or
> > sources that can support this feature for linux?
> >
> > I would be a great help to me if someone could answer this or give
> > some pointers to this?
> >
> You would route between the two VLANs.  They are two different
> broadcast domains, you need to route them at Layer 3.  HA would have
> a route or default gw pointed at ROUTER which has IP forwarding
> turned on and you should be able to hit HB.

Another options is to bridge between the two VLAN interfaces (eth0.200 
and eth0.300). man "brctl" to learn how to enslave both ports to a 
bridge unit. 

Note: you might need to use the vconfig option "set_flag [vlan-device] 
1" to enable Ethernet headers reoredering to get this to do what you 
want.

Cheers,
Gilad

-- 
Gilad Ben-Yossef <gilad@codefidence.com>
Codefidence. A name you can trust (tm)
http://www.codefidence.com


-- 
Gilad Ben-Yossef <gilad@codefidence.com>
Codefidence. A name you can trust (TM)
http://www.codefidence.com

