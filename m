Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266481AbTGKEhT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 00:37:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269780AbTGKEhT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 00:37:19 -0400
Received: from netcore.fi ([193.94.160.1]:18952 "EHLO netcore.fi")
	by vger.kernel.org with ESMTP id S266481AbTGKEhS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 00:37:18 -0400
Date: Fri, 11 Jul 2003 07:51:56 +0300 (EEST)
From: Pekka Savola <pekkas@netcore.fi>
To: Andre Tomt <andre@tomt.net>
cc: linux-kernel@vger.kernel.org, Mika Liljeberg <mika.liljeberg@welho.com>,
       <netdev@oss.sgi.com>
Subject: Re: 2.4.21+ - IPv6 over IPv4 tunneling b0rked
In-Reply-To: <1057888154.26854.324.camel@localhost>
Message-ID: <Pine.LNX.4.44.0307110750150.24705-100000@netcore.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11 Jul 2003, Andre Tomt wrote:
> On fre, 2003-07-11 at 02:04, Mika Liljeberg wrote:
> > Well, the thing is that prefix:: is a special anycast address that
> > identifies a router on the link prefix::/n, where n is the prefix
> > length. You had configured a 127-bit link prefix, meaning that you had
> > only one valid unicast address (last bit == 1) in addition to the router
> > anycast address (last bit == 0).
> 
> Thanks for the explanation, I've been struggling to understand what
> Yoshfuji tried to explain to me earlier on this topic (see "IPv6 bugs
> introduced in 2.4.21" - ie. my bogus bugreport), now it all makes
> perfect sense :-)

Well, the system may make some sense, but IMHO, there is still zero sense 
in policing this thing when you add a route.  That's just plain bogus.  
This is a bug which must be fixed ASAP.

-- 
Pekka Savola                 "You each name yourselves king, yet the
Netcore Oy                    kingdom bleeds."
Systems. Networks. Security. -- George R.R. Martin: A Clash of Kings

