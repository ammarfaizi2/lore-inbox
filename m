Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265845AbSKBA5M>; Fri, 1 Nov 2002 19:57:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265847AbSKBA5L>; Fri, 1 Nov 2002 19:57:11 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:65520 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S265845AbSKBA5L>;
	Fri, 1 Nov 2002 19:57:11 -0500
Date: Fri, 1 Nov 2002 17:03:22 -0800
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       "David S. Miller" <davem@redhat.com>
Cc: Krishna Kumar <krkumar@us.ibm.com>
Subject: Re: [PATCHSET] Mobile IPv6 for 2.5.45
Message-ID: <20021102010322.GA5105@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote :
> 
> Why isn't the home agent code being done in userspace?  That is
> where it belongs.  It's huge.

	6 years ago (an eternity), a friend of mine did a full
implementation of Mobile IPv4 for Linux in user space (url below).
	Of course, it needed some kernel support, such as IP/IP
tunneling, raw sockets, IP forwarding, gratuitous ARP and routing, but
there was no additional code added in the kernel. And this was Home
Agent, Foreign agent, Client and all their friends. And it was
interoprating successfully with other MIP implementations of that
time.

	This was not the final draft of Mobile-IPv4 (they changed it
after that), and Mobile-IPv6 is different (for example, it is much
more integrated with IPsec), so the situation is not exactly the same.
	But in the meantime, the kernel has gained powerful new
facilities, such as tun/tap and netfilters, which make very complex
things possible in user space.
	But I fully aggree that having your code in the kernel is
infinitely more sexy than maintaining some user space package ;-)

	Have fun...

	Jean

The URL :
	http://www.hpl.hp.com/personal/Jean_Tourrilhes/MobileIP/index.html
