Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272790AbTHSR0v (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 13:26:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272765AbTHSRIX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 13:08:23 -0400
Received: from pizda.ninka.net ([216.101.162.242]:651 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S272855AbTHSQ6l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 12:58:41 -0400
Date: Tue, 19 Aug 2003 09:51:05 -0700
From: "David S. Miller" <davem@redhat.com>
To: Richard Underwood <richard@aspectgroup.co.uk>
Cc: skraw@ithnet.com, willy@w.ods.org, alan@lxorguk.ukuu.org.uk,
       carlosev@newipnet.com, lamont@scriptkiddie.org, davidsen@tmr.com,
       bloemsaa@xs4all.nl, marcelo@conectiva.com.br, netdev@oss.sgi.com,
       linux-net@vger.kernel.org, layes@loran.com, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.4 PATCH] bugfix: ARP respond on all devices
Message-Id: <20030819095105.2cb9acc1.davem@redhat.com>
In-Reply-To: <353568DCBAE06148B70767C1B1A93E625EAB5B@post.pc.aspectgroup.co.uk>
References: <353568DCBAE06148B70767C1B1A93E625EAB5B@post.pc.aspectgroup.co.uk>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Aug 2003 17:54:26 +0100
Richard Underwood <richard@aspectgroup.co.uk> wrote:

> 	When a HOST sends out an ARP request, it's NOT associated with a
> single connection, it's associated with the host. Why should it pick a
> "random" IP number to send as the source address?

It's not "random", it is using the IP address it intends
to use as the source in packets it will output once the
ARP completes.

In fact, if you look at the code in arp_solicit(), the source address
is coming directly from the packet we are trying to output.
