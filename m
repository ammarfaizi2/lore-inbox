Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261763AbVCaSWm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261763AbVCaSWm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 13:22:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261787AbVCaSWm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 13:22:42 -0500
Received: from eth0-0.arisu.projectdream.org ([194.158.4.191]:50359 "EHLO
	b.mx.projectdream.org") by vger.kernel.org with ESMTP
	id S261763AbVCaSWK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 13:22:10 -0500
Date: Thu, 31 Mar 2005 20:22:28 +0200
From: Thomas Graf <tgraf@suug.ch>
To: "Randy.Dunlap" <randy.dunlap@verizon.net>
Cc: ioe-lkml@axxeo.de, matthew@wil.cx, lkml <linux-kernel@vger.kernel.org>,
       netdev@oss.sgi.com
Subject: Re: [RFC/PATCH] network configs: disconnect network options from drivers
Message-ID: <20050331182228.GV3086@postel.suug.ch>
References: <20050330234709.1868eee5.randy.dunlap@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050330234709.1868eee5.randy.dunlap@verizon.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Randy.Dunlap <20050330234709.1868eee5.randy.dunlap@verizon.net> 2005-03-30 23:47
> 
> RFC:  This is a work-in-progress (WIP), not yet completed.
> 
> A few people dislike that the Networking Options menu is inside
> the Device Drivers/Networking menu.  This patch moves the
> Networking Options menu to immediately before the Device Drivers menu,
> renames it to "Networking options and protocols", & moves most
> protocols to more logical places (IMHOOC).

Definitely a good idea.

> The reasons that it is still WIP are:
> - I'd like to see all of the sub-menus done in the same style;

Further suggestions:

 - Introduce sub menus on separate pages for TCP/IP, DECNet,
   ATM, ... i.e. like it is done for SCTP.

 - Separate things into top categories
     Socket Families (maybe separate page)
       - PF_PACKET
       - PF_UNIX
       - PF_KEY
     Protocols (separate page)
       - TCP/IP networking (separate page)
          - IPv6 (affecting choices below)
             - Privary extensions
          - multicasting
          - routing
             - advanced router
                - policy routing
                   - use nfmark with chaching support
                - multipath routing
                   - cached
                      - rrd
                      - random
                      - ...
             - multicast routing
                - pim v1
                - pim v2
             - verbose route monitoring
          - auto configuration
             - dhcp
             - boop
             - rarp
          - tunneling
             - IPv4
                - IPIP
                - GRE
                   - broadcast
             - IPv6
                - IPv6oIPv6
          - transformations
             - IPv4
                - AH
                - ESP
                - IPComp
             - IPv6
                - AH
                - ESP
                - IPComp
          - ARP daemon
          - TCP
             - Diagnostics
             - Syn Cookies
       - SCTP
       - ATM
       - 802.1d
       - 802.1q
       - DECnet
       - 802.2 LLC
       - IPX
       - Appletalk
       - X.25
       - LAPB
       - Econet
     <<Good title here>>
       - Netfilter
       - IPsec
       - LVS
       - Frame Diverter
       - QoS & Fair Queueing
       - Network testing
       - WAN Router

Thoughts?
