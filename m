Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262078AbTHTRMO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 13:12:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262074AbTHTRMO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 13:12:14 -0400
Received: from pizda.ninka.net ([216.101.162.242]:50586 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S262080AbTHTRLI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 13:11:08 -0400
Date: Wed, 20 Aug 2003 10:00:44 -0700
From: "David S. Miller" <davem@redhat.com>
To: Bill Davidsen <davidsen@tmr.com>
Cc: dang@fprintf.net, alan@lxorguk.ukuu.org.uk, richard@aspectgroup.co.uk,
       skraw@ithnet.com, willy@w.ods.org, carlosev@newipnet.com,
       lamont@scriptkiddie.org, bloemsaa@xs4all.nl, marcelo@conectiva.com.br,
       netdev@oss.sgi.com, linux-net@vger.kernel.org, layes@loran.com,
       torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [2.4 PATCH] bugfix: ARP respond on all devices
Message-Id: <20030820100044.3127d612.davem@redhat.com>
In-Reply-To: <Pine.LNX.3.96.1030820123600.14414I-100000@gatekeeper.tmr.com>
References: <1061320363.3744.14.camel@athena.fprintf.net>
	<Pine.LNX.3.96.1030820123600.14414I-100000@gatekeeper.tmr.com>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Aug 2003 12:49:14 -0400 (EDT)
Bill Davidsen <davidsen@tmr.com> wrote:

> On 19 Aug 2003, Daniel Gryniewicz wrote:
> 
> I have been asking for a similar thing as well, David mentioned some
> things that would break, but I believe they break if you use source
> routing, so that seems not to be a real objection.

It's not about source routing.  It's about failover and being
able to use ARP on interfaces which don't have addresses assigned
to them yet.

> I find it interesting that we can't change networking because a few
> complex systems would have to be reconfigured, but we *can* change modules
> which requires config changes on probably 90% of all systems (commercial
> distributions).

Decisions about Networking will always be in a different domain
because the way one behaves has effects upon other systems not
just the local one.

BTW, another thing which makes the source address selection for
outgoing ARPs a real touchy area is the following.  Some weird
configurations actually respond with different ARP answers based upon
the source address in the ARP request.  You can ask Julian Anastasov
about such (arguably pathological) setups.
