Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312522AbSCYTrA>; Mon, 25 Mar 2002 14:47:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312521AbSCYTqv>; Mon, 25 Mar 2002 14:46:51 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:55822 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S312522AbSCYTqj>; Mon, 25 Mar 2002 14:46:39 -0500
Date: Mon, 25 Mar 2002 14:44:31 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Robert Love <rml@tech9.net>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 3c59x and resume
In-Reply-To: <1016914030.949.20.camel@phantasy>
Message-ID: <Pine.LNX.3.96.1020325143511.4219B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 23 Mar 2002, Robert Love wrote:

> Ideally we'd have a dynamically created array for the cards and hash
> into that, but, ugh, this is getting gross especially since 99% of us
> have one card and never remove it.

  To address the problem of running out of id's, a bitmap of "id's in use"
could be used, and number recycled. This is done infrequently and overhead
is hardly a problem, although getting things released at suspect may be.

  Getting the right options on the right card and the right card on the
expected number is another problem. I fight that all the time on my
laptop, with one NIC in the laptop and one in the dock. In spite of clear
information in modules.conf giving which driver goes with each NIC (via
alias), I don't get eth1 with no eth0 as I want, the first one is always
eth0, loads the wrong driver when not docked, and then doesn't get
initialized right by the startup scripts.

  I also have another NIC I put in a pcmcia slot to become a router on
occasion, that also gets a random NIC number. Unfortunately it doesn't
look like a trivial job to use the info in modules.conf to fix the general
random numbering. The modules.conf interface seems to work in the wrong
direction, what I think we want is "when you load this driver use this
name", so eth2 could be the only NIC in the system under some conditions.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

