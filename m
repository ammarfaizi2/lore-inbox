Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269750AbTGKBea (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 21:34:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269752AbTGKBea
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 21:34:30 -0400
Received: from mail.skjellin.no ([80.239.42.67]:1498 "HELO mail.skjellin.no")
	by vger.kernel.org with SMTP id S269750AbTGKBe3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 21:34:29 -0400
Subject: Re: 2.4.21+ - IPv6 over IPv4 tunneling b0rked
From: Andre Tomt <andre@tomt.net>
To: linux-kernel@vger.kernel.org
Cc: Mika Liljeberg <mika.liljeberg@welho.com>, netdev@oss.sgi.com
In-Reply-To: <1057881869.3588.10.camel@hades>
References: <20030710154302.GE1722@zip.com.au>
	 <1057854432.3588.2.camel@hades>  <20030710233931.GG1722@zip.com.au>
	 <1057881869.3588.10.camel@hades>
Content-Type: text/plain; charset=ISO-8859-1
Message-Id: <1057888154.26854.324.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 11 Jul 2003 03:49:14 +0200
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On fre, 2003-07-11 at 02:04, Mika Liljeberg wrote:
> Well, the thing is that prefix:: is a special anycast address that
> identifies a router on the link prefix::/n, where n is the prefix
> length. You had configured a 127-bit link prefix, meaning that you had
> only one valid unicast address (last bit == 1) in addition to the router
> anycast address (last bit == 0).

Thanks for the explanation, I've been struggling to understand what
Yoshfuji tried to explain to me earlier on this topic (see "IPv6 bugs
introduced in 2.4.21" - ie. my bogus bugreport), now it all makes
perfect sense :-)

> Normally, IPv6 networks are supposed to use 64-bit on-link prefixes but
> the implementation can be written in such a way that other prefix
> lengths can be configured.
> 
> Setting your tunnel prefix to /64 is certainly the right thing to do. 

If you don't have anything but one /64 for example.. I guess /126's
would be ok as you could rule out the the anycast address? It will
probably work with Linux - but is it wrong in any sense, other than
"breaking" with EUI-64/autoconfiguration?

-- 
Cheers,
André Tomt
andre@tomt.net

