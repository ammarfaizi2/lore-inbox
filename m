Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261186AbTHSShJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 14:37:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261185AbTHSShI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 14:37:08 -0400
Received: from pizda.ninka.net ([216.101.162.242]:35212 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S273034AbTHSSVw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 14:21:52 -0400
Date: Tue, 19 Aug 2003 11:13:58 -0700
From: "David S. Miller" <davem@redhat.com>
To: Richard Underwood <richard@aspectgroup.co.uk>
Cc: skraw@ithnet.com, willy@w.ods.org, alan@lxorguk.ukuu.org.uk,
       carlosev@newipnet.com, lamont@scriptkiddie.org, davidsen@tmr.com,
       bloemsaa@xs4all.nl, marcelo@conectiva.com.br, netdev@oss.sgi.com,
       linux-net@vger.kernel.org, layes@loran.com, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.4 PATCH] bugfix: ARP respond on all devices
Message-Id: <20030819111358.35ef1059.davem@redhat.com>
In-Reply-To: <353568DCBAE06148B70767C1B1A93E625EAB5E@post.pc.aspectgroup.co.uk>
References: <353568DCBAE06148B70767C1B1A93E625EAB5E@post.pc.aspectgroup.co.uk>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Aug 2003 19:16:18 +0100
Richard Underwood <richard@aspectgroup.co.uk> wrote:

> David S. Miller wrote:
> > Ok, then how would you propose to be able to send
> > packets out an interface _before_ we have addresses
> > assigned to it?
> > 
> 	IP packets you mean? You don't? ;) It would depend on why you're
> doing it naturally. Mostly, I'd have thought that if a host doesn't have an
> IP number it doesn't get to use ARP.

Of course it gets to use ARP, nothing prevents this.

If I know that IP X has my configuration information, I
have every right to send X a packet from zero-net to
ask for that information before I have any IP addresses
attached to the interface.

This is nothing wrong nor strange about this and we've
supported it for years.

Also, when one specifies a specific device in an output
address and we cannot find the IP part of the address
in the routing tables, we still procure a valid route for
the requester.

Besides normal IP addresses, multicast tools use these
facilities.
