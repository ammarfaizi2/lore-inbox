Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267193AbSLKRaU>; Wed, 11 Dec 2002 12:30:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267239AbSLKRaU>; Wed, 11 Dec 2002 12:30:20 -0500
Received: from stingr.net ([212.193.32.15]:41220 "EHLO hq.stingr.net")
	by vger.kernel.org with ESMTP id <S267193AbSLKRaT>;
	Wed, 11 Dec 2002 12:30:19 -0500
Date: Wed, 11 Dec 2002 20:38:04 +0300
From: Paul P Komkoff Jr <i@stingr.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [DUMB QUESTION] bonding. ethernet bonding.
Message-ID: <20021211173803.GA2496@stingr.net>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
User-Agent: Agent Darien Fawkes
X-Mailer: Intel Ultra ATA Storage Driver
X-RealName: Stingray Greatest Jr
Organization: Department of Fish & Wildlife
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hmm. I'm very very unfamiliar with this thing. So when I first tried
to install it I downloaded latest bonding code against 2.4.20 from
sf.net/projects/bonding , patched my kernel with it and etc etc ...

... skipping ...

boot. ip ad flush dev eth{0,1}
modprobe bonding miimon=100
ip ad add myip/mymask brd + dev bond0
ifenslave bond0 eth0 eth1
ip li set bond0 up

switch on the other side (3com superstack 3) configured for trunking
on that 2 ports.

and then
ping $addr_on_local_net do nothing

hmm

tcpdump -i bond0 -vvv -n host $addr_on_local_net

will show me arp replies that $addr_on_local_net is on some
mac_address but
ip ne sh
will show that arp lookup is incomplete then failed

What's wrong?
Maybe other patches I've put in conflicting with this?

-- 
Paul P 'Stingray' Komkoff 'Greatest' Jr /// (icq)23200764 /// (http)stingr.net
  When you're invisible, the only one really watching you is you (my keychain)
