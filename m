Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270385AbTHQQim (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 12:38:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270378AbTHQQim
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 12:38:42 -0400
Received: from 5.Red-80-32-157.pooles.rima-tde.net ([80.32.157.5]:23561 "EHLO
	smtp.newipnet.com") by vger.kernel.org with ESMTP id S270373AbTHQQij
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 12:38:39 -0400
Message-ID: <200308171827130739.00C3905F@192.168.128.16>
In-Reply-To: <1061137577.21885.50.camel@dhcp23.swansea.linux.org.uk>
References: <Pine.LNX.3.96.1030728222606.21100A-100000@gatekeeper.tmr.com>
 <20030728213933.F81299@coredump.scriptkiddie.org>
 <200308171509570955.003E4FEC@192.168.128.16>
 <200308171516090038.0043F977@192.168.128.16>
 <1061127715.21885.35.camel@dhcp23.swansea.linux.org.uk>
 <200308171555280781.0067FB36@192.168.128.16>
 <1061134091.21886.40.camel@dhcp23.swansea.linux.org.uk>
 <200308171759540391.00AA8CAB@192.168.128.16>
 <1061137577.21885.50.camel@dhcp23.swansea.linux.org.uk>
X-Mailer: Calypso Version 3.30.00.00 (4)
Date: Sun, 17 Aug 2003 18:27:13 +0200
From: "Carlos Velasco" <carlosev@newipnet.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: "Lamont Granquist" <lamont@scriptkiddie.org>,
       "Bill Davidsen" <davidsen@tmr.com>,
       "David S. Miller" <davem@redhat.com>, bloemsaa@xs4all.nl,
       "Marcelo Tosatti" <marcelo@conectiva.com.br>, netdev@oss.sgi.com,
       linux-net@vger.kernel.org, layes@loran.com, torvalds@osdl.org,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: [2.4 PATCH] bugfix: ARP respond on all devices
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/08/2003 at 17:26 Alan Cox wrote:

>> http://marc.theaimsgroup.com/?l=linux-net&m=106094924813337&w=2
>
>You put the foundary devices IP on one of your interfaces ? In which
case
>your network is misconfigured - go fix it. Two systems are not
permitted
>to have the same IP address. Linux supports asymettric routing just
fine.

Really, I don't know if you don't uderstand or you don't want to
understand...

There is _NOT_ any problem of duplicated IPs or so.
It's a Load Balancing scenary, similar to linuxvirtualserver and ARP
problem that rise _ONLY_ when using Linux as real server:
http://www.linuxvirtualserver.org/docs/arp.html

If you send a packet through dev eth0 to dev lo IP address or other
interface, when Linux try to map the MAC address with the IP address of
the default gateway (or the gateway to reach the packet Source IP
address), it uses the lo IP address (or other dev) in the ARP Request.

Regards,
Carlos Velasco


