Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262079AbTHTQ7s (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 12:59:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262077AbTHTQ7s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 12:59:48 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:12293 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S262074AbTHTQ7i
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 12:59:38 -0400
Date: Wed, 20 Aug 2003 12:49:14 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Daniel Gryniewicz <dang@fprintf.net>
cc: "David S. Miller" <davem@redhat.com>, alan@lxorguk.ukuu.org.uk,
       richard@aspectgroup.co.uk, skraw@ithnet.com, willy@w.ods.org,
       carlosev@newipnet.com, lamont@scriptkiddie.org, bloemsaa@xs4all.nl,
       marcelo@conectiva.com.br, netdev@oss.sgi.com, linux-net@vger.kernel.org,
       layes@loran.com, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [2.4 PATCH] bugfix: ARP respond on all devices
In-Reply-To: <1061320363.3744.14.camel@athena.fprintf.net>
Message-ID: <Pine.LNX.3.96.1030820123600.14414I-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 Aug 2003, Daniel Gryniewicz wrote:

> I realize that, but is that a reason to keep linux from working with
> these?  (And it's not just cisco, all the *BSDs (and therefore anything
> that took the BSD stack such as MS) work this way too.)  As nearly as I
> can tell, there's no way to make linux work with these, and the
> situation I gave is one where linux could easily get it right, and
> isn't.  Saying "They're broken.  Tough." is not really helpful.  At
> least can we get a "work with broken other systems in certain
> circumstances" switch somewhere?

I have been asking for a similar thing as well, David mentioned some
things that would break, but I believe they break if you use source
routing, so that seems not to be a real objection.

> 
> (Funny you should mention Cisco, as we write routing software and must
> interoperate with Cisco.  What Cisco says *does* go in the routing
> community, if you wish your product to be used.  Currently, when our
> customers come to us, we have to say "Either don't use Linux or run 2.2
> with the arp fix patch.")

Unless all your customers do odd things with networking, or you are not
using source routing for some reason, you don't do customers a favor by
giving that advice. Most users have one NIC with one IP and Linux works.

The Linux implementation is not broken by standard, it's just that there
were two ways to do it, and the one chosen is allowed by frequently
non-functional.

I find it interesting that we can't change networking because a few
complex systems would have to be reconfigured, but we *can* change modules
which requires config changes on probably 90% of all systems (commercial
distributions). Linus has rethought some of his design decisions, but
David seems intent on not only keeping this one, but preventing the
addition of a flag which would solve the problem for most people.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

