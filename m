Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270346AbTHQQBo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 12:01:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270332AbTHQQBo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 12:01:44 -0400
Received: from 5.Red-80-32-157.pooles.rima-tde.net ([80.32.157.5]:5897 "EHLO
	smtp.newipnet.com") by vger.kernel.org with ESMTP id S270328AbTHQQBl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 12:01:41 -0400
Message-ID: <200308171759540391.00AA8CAB@192.168.128.16>
In-Reply-To: <1061134091.21886.40.camel@dhcp23.swansea.linux.org.uk>
References: <Pine.LNX.3.96.1030728222606.21100A-100000@gatekeeper.tmr.com>
 <20030728213933.F81299@coredump.scriptkiddie.org>
 <200308171509570955.003E4FEC@192.168.128.16>
 <200308171516090038.0043F977@192.168.128.16>
 <1061127715.21885.35.camel@dhcp23.swansea.linux.org.uk>
 <200308171555280781.0067FB36@192.168.128.16>
 <1061134091.21886.40.camel@dhcp23.swansea.linux.org.uk>
X-Mailer: Calypso Version 3.30.00.00 (4)
Date: Sun, 17 Aug 2003 17:59:54 +0200
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

On 17/08/2003 at 16:28 Alan Cox wrote:

>Linux doesn't issue "bad" requests. Linux will reply when it is
>asked for an address that it owns, as per RFC826, unless you chose
>to change the behaviour with things like arpfilter.

We are not talking about ARP Replies, we are talking about ARP
Requests.
You can see the Richard post here, same issue I reported several weeks
ago:
http://marc.theaimsgroup.com/?l=linux-net&m=106094924813337&w=2

==
	On eth0, we see:

11:23:55.650514 0:4:75:ca:c4:ef Broadcast arp 42: arp who-has
10.10.10.1
tell 212.xxx.yyy.9
==

Linux is sending an ARP Request to a LAN where the source IP address of
the packet has not any sense in that IP network.
And, at least, 2 RFCs are stating that other devices should not reply
to this packet. Currently know Cisco, Foundry; possibly others, and
possibly others coming as ARP storms are not desired.

Regards,
Carlos Velasco


