Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315991AbSEJNhl>; Fri, 10 May 2002 09:37:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315990AbSEJNhk>; Fri, 10 May 2002 09:37:40 -0400
Received: from netcore.fi ([193.94.160.1]:26387 "EHLO netcore.fi")
	by vger.kernel.org with ESMTP id <S315796AbSEJNhj>;
	Fri, 10 May 2002 09:37:39 -0400
Date: Fri, 10 May 2002 16:37:33 +0300 (EEST)
From: Pekka Savola <pekkas@netcore.fi>
To: Brian Raymond <padrino121@email.com>
cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'linux-ppp@vger.kernel.org'" <linux-ppp@vger.kernel.org>,
        "'linux-net@vger.kernel.org'" <linux-net@vger.kernel.org>
Subject: Re: mc_forwarding Option in sys.net.ipv4.conf.all
In-Reply-To: <C144D032EA60D3119AAC00105A75C19A11AB20@SERVER>
Message-ID: <Pine.LNX.4.44.0205101635190.2935-100000@netcore.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 May 2002, Brian Raymond wrote:
> I've been working on a Linux PPTP VPN server for clients that require
> multicasting. I only have one physical interface in the box and I'm using
> the PoPToP package for PPTP support. Getting the VPN setup and working
> hasn't been a problem, getting the multicast traffic to flow between the ppp
> and eth0 interface is causing me a whole lot of problems. What do I need to
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

