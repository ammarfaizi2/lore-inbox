Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130202AbRCGFGx>; Wed, 7 Mar 2001 00:06:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130201AbRCGFGn>; Wed, 7 Mar 2001 00:06:43 -0500
Received: from sunny.pacific.net.au ([210.23.129.40]:2249 "EHLO
	sunny.pacific.net.au") by vger.kernel.org with ESMTP
	id <S130138AbRCGFGb>; Wed, 7 Mar 2001 00:06:31 -0500
Message-Id: <200103070505.f2755jT17569@typhaon.pacific.net.au>
X-Mailer: exmh version 2.3.1 01/18/2001 (debian 2.3.1-1) with nmh-1.0.4+dev
To: Lincoln Dale <ltd@cisco.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Incoming TCP TOS: A simple question, I would have thought... 
In-Reply-To: Message from Lincoln Dale <ltd@cisco.com> 
   of "Wed, 07 Mar 2001 15:33:44 +1100." <4.3.2.7.2.20010307153216.01b85d58@mira-sjcm-3.cisco.com> 
In-Reply-To: <4.3.2.7.2.20010307153216.01b85d58@mira-sjcm-3.cisco.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 07 Mar 2001 16:05:45 +1100
From: David Luyer <david_luyer@pacific.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> getsockopt(fd, SOL_IP, IP_TOS, ..

Doesn't work.  Returns the TOS of outgoing packets, which defaults to 0 even if
there is a TOS set on incoming traffic... that was what I tried in my first 
test program.

David.

> cheers,
> 
> lincoln.
> 
> At 03:00 PM 7/03/2001 +1100, David Luyer wrote:
> 
> >I've scrolled through various code in net/ipv4, and I can't see how to query
> >the TOS of an incoming TCP stream (or at the least, the TOS of the SYN which
> >initiated the connection).
> >
> >Someone has sent in a feature request for squid which would require this,
> >presumably so they can set the TOS in their routers and have the squid caches
> >honour the TOS to select performance (via delay pools, multiple parents,
> >different outgoing IP or similar).  However I can't see how to get the TOS for
> >a TCP socket out of the kernel short of having an open raw socket watching for
> >SYNs and looking at the TOS on them.
> >
> >Any pointers?
> >
> >David.
-- 
David Luyer                                        Phone:   +61 3 9674 7525
Engineering Projects Manager   P A C I F I C       Fax:     +61 3 9699 8693
Pacific Internet (Australia)  I N T E R N E T      Mobile:  +61 4 1111 2983
http://www.pacific.net.au/                         NASDAQ:  PCNTF


