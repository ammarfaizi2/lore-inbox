Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265232AbRF0D4F>; Tue, 26 Jun 2001 23:56:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265233AbRF0Dzz>; Tue, 26 Jun 2001 23:55:55 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:28677 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S265232AbRF0Dzv>; Tue, 26 Jun 2001 23:55:51 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: John Stoffel <stoffel@casc.com>, Rik van Riel <riel@conectiva.com.br>
Subject: Re: VM Requirement Document - v0.0
Date: Wed, 27 Jun 2001 05:55:48 +0200
X-Mailer: KMail [version 1.2]
Cc: Jason McMullan <jmcmullan@linuxcare.com>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20010626155838.A23098@jmcmullan.resilience.com> <Pine.LNX.4.33L.0106261819400.23373-100000@duckman.distro.conectiva> <15160.65442.682067.38776@gargle.gargle.HOWL>
In-Reply-To: <15160.65442.682067.38776@gargle.gargle.HOWL>
MIME-Version: 1.0
Message-Id: <01062705554800.06823@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I personally don't feel that the cache should be allowed to grow over
> 50% of the system's memory at all, we've got so much in the cache at
> that point, that we're probably not hitting it all that much.

That depends very much on what you're using the system for.  Suppose you're 
running a trivial database application on a gigantic disk array - the name of 
the game is to cache as much metadata as possible, and that goes directly to 
the bottom line as performance.  Might as well use 90%+ of your memory for 
that.

The conclusion to draw here is, the balance between file cache and process 
memory should be able to slide all the way from one extreme to the other.  
It's not a requirement that that be fully automatic but it's highly 
desireable.

--
Daniel
