Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267202AbSLKQJT>; Wed, 11 Dec 2002 11:09:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267199AbSLKQJT>; Wed, 11 Dec 2002 11:09:19 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:50962 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S267197AbSLKQJR>; Wed, 11 Dec 2002 11:09:17 -0500
Date: Wed, 11 Dec 2002 11:15:29 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Roberto Nibali <ratz@drugphish.ch>
cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       linux-net <linux-net@vger.kernel.org>
Subject: Re: hidden interface (ARP) 2.4.20
In-Reply-To: <3DF62F2F.3030805@drugphish.ch>
Message-ID: <Pine.LNX.3.96.1021211110329.18520C-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Dec 2002, Roberto Nibali wrote:

> > I have in mid multiple ISPs for redundancy, perhaps a pair of OC12s or
> > similar. Sites would be reachable from either, but fewer hops to one or
> > the other. When the client connects, it avoids asymmetric routing to reply
> > on the same router.
> 
> I understand everything but the last sentence. You have a couple of 
> redundant ISP links which can all act as a router to the Internet, the 
> only difference is that if you go over some of them you need less hops. 
> Now in order to avoid asymmetric routing you need the hidden patch? I 
> apologise for being so narrow minded but I still don't get it.

Don't. You are right about this one, a client originated connection will
have an ARP entry and route back by the original route. Connections
originated on the dual-homed system might put a packet out on either NIC,
from any IP, that's a different issue, and the whole hidden interface
patch really doesn't address it.

I was mixing things from two problems I've seen, sorry for any confusion.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

