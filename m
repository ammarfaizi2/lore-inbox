Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261154AbTHSSod (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 14:44:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261173AbTHSSmw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 14:42:52 -0400
Received: from pizda.ninka.net ([216.101.162.242]:56460 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S261179AbTHSShF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 14:37:05 -0400
Date: Tue, 19 Aug 2003 11:29:12 -0700
From: "David S. Miller" <davem@redhat.com>
To: Daniel Gryniewicz <dang@fprintf.net>
Cc: alan@lxorguk.ukuu.org.uk, richard@aspectgroup.co.uk, skraw@ithnet.com,
       willy@w.ods.org, carlosev@newipnet.com, lamont@scriptkiddie.org,
       davidsen@tmr.com, bloemsaa@xs4all.nl, marcelo@conectiva.com.br,
       netdev@oss.sgi.com, linux-net@vger.kernel.org, layes@loran.com,
       torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [2.4 PATCH] bugfix: ARP respond on all devices
Message-Id: <20030819112912.359eaea6.davem@redhat.com>
In-Reply-To: <1061317825.3744.7.camel@athena.fprintf.net>
References: <353568DCBAE06148B70767C1B1A93E625EAB57@post.pc.aspectgroup.co.uk>
	<1061296544.30566.8.camel@dhcp23.swansea.linux.org.uk>
	<1061317825.3744.7.camel@athena.fprintf.net>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 Aug 2003 14:30:26 -0400
Daniel Gryniewicz <dang@fprintf.net> wrote:

> If you are not on a shared lan, then it will *ONLY* work if linux is
> on the other end.  No other system will work.

And these other systems are broken.  (actually, older Cisco equipment
correctly responds to the ARP regardless of source IP)

Just because some Cisco engineer says that it is correct doesn't
make it is.

Consider the situation logically.  When you're replying to an
ARP, _HOW_ do you know what IP addresses are assigned to _MY_
outgoing interfaces and _HOW_ do you know what subnets _EXIST_
on the LAN?

The answer to both is, you'd don't know these things _EVEN_ if
you are a router/gateway.

Therefore there is no valid reason not to respond to an ARP using one
source address as opposed to another.
