Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131261AbRBWEiF>; Thu, 22 Feb 2001 23:38:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131363AbRBWEh4>; Thu, 22 Feb 2001 23:37:56 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:44813 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131261AbRBWEhm>; Thu, 22 Feb 2001 23:37:42 -0500
Date: Thu, 22 Feb 2001 20:37:15 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jeff Lessem <Jeff.Lessem@Colorado.EDU>
cc: linux-kernel@vger.kernel.org
Subject: Re: PCI oddities on Dell Inspiron 5000e w/ 2.4.x 
In-Reply-To: <200102230406.VAA454821@ibg.colorado.edu>
Message-ID: <Pine.LNX.4.10.10102222033060.19705-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 22 Feb 2001, Jeff Lessem wrote:
> 
> No problem, the listings are below.  Both listings were done on a
> freshly booted system.  The only difference in system states was that
> the i82365 modules had loaded.

Hmm.. You shouldn't be loading any i82365 module at all. You should load
the "yenta_socket" module. 

One of the major differences between working and non-working is that the
non-working thing doesn't have the PCI latency register set. The yenta
driver explicitly sets the latency and cache size numbers, so it reall
ylook slike you should just use that driver and it should work.

		Linus

