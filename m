Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270990AbRIFSXs>; Thu, 6 Sep 2001 14:23:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270989AbRIFSXj>; Thu, 6 Sep 2001 14:23:39 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:34066 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S272466AbRIFSXa>; Thu, 6 Sep 2001 14:23:30 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: notion of a local address [was: Re: ioctl SIOCGIFNETMASK: ip alias
 bug 2.4.9 and 2.2.19]
Date: 6 Sep 2001 11:23:29 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9n8ev1$qba$1@cesium.transmeta.com>
In-Reply-To: <20010906212303.A23595@castle.nmd.msu.ru> <20010906173948.502BFBC06C@spike.porcupine.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20010906173948.502BFBC06C@spike.porcupine.org>
By author:    wietse@porcupine.org (Wietse Venema)
In newsgroup: linux.dev.kernel
> 
> The SMTP RFC requires that user@[ip.address] is correctly recognized
> as a final destination.  This requires that Linux provides the MTA
> with information about IP addresses that correspond with INADDR_ANY.
> 
> I am susprised that it is not possible to ask such information up
> front (same with netmasks), and that an application has to actually
> query a complex oracle, again and again, for every IP address.
> 

In autofs, I use the following technique to determine if the IP number
for a host is local (and therefore vfsbinds can be used rather than
NFS mounts):

connect a datagram socket (which won't produce any actual traffic) to
the remote host with INADDR_ANY as the local address, and then query
the local address.  If the local address is the same as the remote
address, the address is local.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
