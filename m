Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316088AbSEJR4r>; Fri, 10 May 2002 13:56:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316085AbSEJR4p>; Fri, 10 May 2002 13:56:45 -0400
Received: from 216-220-240-114.midmaine.com ([216.220.240.114]:56072 "EHLO
	server.superrealty.com") by vger.kernel.org with ESMTP
	id <S316084AbSEJR4j>; Fri, 10 May 2002 13:56:39 -0400
Message-ID: <C144D032EA60D3119AAC00105A75C19A11AB25@SERVER>
From: Brian Raymond <padrino121@email.com>
To: "'Pekka Savola'" <pekkas@netcore.fi>, Brian Raymond <padrino121@email.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'linux-ppp@vger.kernel.org'" <linux-ppp@vger.kernel.org>,
        "'linux-net@vger.kernel.org'" <linux-net@vger.kernel.org>
Subject: RE: mc_forwarding Option in sys.net.ipv4.conf.all
Date: Fri, 10 May 2002 13:55:34 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My hope was that IGMP proxying/routing is something that's implemented in
Linux (how Windows pulls it off) so that it would just be a matter of
turning it on and setting a couple of config options. Right now the network
uses PIM-DM & IGMPv2 on the routers. I haven't found a decent daemon, which
does PIM-DM, and I'm a little concerned with the daemon forwarding all of
the MC traffic to the clients. There is a lot of MC traffic on the network
and the groups are very dynamic so from the sounds of it I'm going to have
to hash through a routing daemon to get things to work.

Thanks for the info. 



Brian Raymond

--
Systems Engineering
Joint Warfighting Center
116 Lakeview Parkway
Suffolk, VA 23435
757-686-7135

-----Original Message-----
From: Pekka Savola [mailto:pekkas@netcore.fi]
Sent: Friday, May 10, 2002 9:38 AM
To: Brian Raymond
Cc: 'linux-kernel@vger.kernel.org'; 'linux-ppp@vger.kernel.org';
'linux-net@vger.kernel.org'
Subject: Re: mc_forwarding Option in sys.net.ipv4.conf.all

On Fri, 10 May 2002, Brian Raymond wrote:
> I've been working on a Linux PPTP VPN server for clients that require
> multicasting. I only have one physical interface in the box and I'm using
> the PoPToP package for PPTP support. Getting the VPN setup and working
> hasn't been a problem, getting the multicast traffic to flow between the
ppp
> and eth0 interface is causing me a whole lot of problems. What do I need
to
> do so that I can tell the kernel to forward all relevant multicast traffic
> through to the clients (in essence just a simple IGMP router)? I've been
> looking at mrouted, pimd-dense and mrtd but haven't had any luck getting
> them to work because of the dynamic nature of the PPP interfaces.

You need to run mrouted, pimd (sparse or dense) or something like on the
router.  Can't you just restart the daemon when the PPP interface switches
state?

An alternative mechanisms would be:
 - using bridging (not applicable in this scenario)
 - doing IGMP proxying and other tricks on the router (haven't been
implemented at least in Linux AFAIK).

--
Pekka Savola                 "Tell me of difficulties surmounted,
Netcore Oy                   not those you stumble over and fall"
Systems. Networks. Security.  -- Robert Jordan: A Crown of Swords
