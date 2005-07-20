Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261502AbVGTUdT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261502AbVGTUdT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Jul 2005 16:33:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261503AbVGTUdT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Jul 2005 16:33:19 -0400
Received: from mail4.zigzag.pl ([217.11.136.106]:37004 "HELO mail4.zigzag.pl")
	by vger.kernel.org with SMTP id S261502AbVGTUdS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Jul 2005 16:33:18 -0400
Date: Wed, 20 Jul 2005 22:33:16 +0200
From: Lukasz Spaleniak <lspaleniak@wroc.zigzag.pl>
X-Mailer: The Bat! (v3.0.1.33) Professional
Reply-To: Lukasz Spaleniak <lspaleniak@wroc.zigzag.pl>
Organization: Internet Group SA
X-Priority: 3 (Normal)
Message-ID: <273347727.20050720223316@wroc.zigzag.pl>
To: Willy Tarreau <willy@w.ods.org>
CC: linux-kernel@vger.kernel.org
Subject: Re[2]: kernel oops, fast ethernet bridge, 2.4.31
In-Reply-To: <20050720194457.GR8907@alpha.home.local>
References: <20050720170025.1264b68a.lspaleniak@wroc.zigzag.pl>
 <20050720194457.GR8907@alpha.home.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-BitDefender-Scanner: Clean, Agent: BitDefender Qmail 1.6.2 on
 mail4.zigzag.pl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, July 20, 2005, 9:44:57 PM, Willy Tarreau wrote:

> Hello,
Hello Willy,

> just some basic questions :
>   - did your configuration change before the oopses started ? (eg: new
>     matches, etc...)
One new machine appears but it generates small traffic rate (by now
it's almost unused).

>   - did the traffic change recently (protocols, data rate) ? eg: new
>     applications on the network, etc...
No - firewall is bridging IPv4 only. There was no dramatic topology
change. Those VLANs which are going through this firewall were
untouched.

>   - is it possible that it's being targetted by an attack where it is
>     installed (unfiltered internet, holiday employees who like to play
>     with the network, etc...) ?
I don't think so that managed IP of firewall was targetet, maybe
machines behid firewall but problem appears on eth2 interface which
is:
internet <-trunk-> eth1(firewall/iptables)eth2<-trunk->(switch
ports) <-> servers
So it's after iptables ...

> I really find it strange that it suddenly started oopsing if nothing
> changed. At least it should have been oopsing from day one.
It is strange to me too. There is no dependency when it happens.
Sometimes traffic is small, sometimes it's normal. Packet rates are
around ~2000-3000 pkt/sec - so not so high.


Regards,
Lukasz

-- 
lspaleniak on wroc zigzag pl
GCM dpu s: a--- C++ UL++++ P+ L+++ E--- W+ N+ K- w O- M V-
PGP t--- 5 X+ R- tv-- b DI- D- G e-- h! r y+


