Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275259AbTHMPq4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 11:46:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275238AbTHMPqz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 11:46:55 -0400
Received: from fern.math.ucla.edu ([128.97.4.251]:39552 "EHLO
	fern.math.ucla.edu") by vger.kernel.org with ESMTP id S275259AbTHMPpf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 11:45:35 -0400
Date: Wed, 13 Aug 2003 08:44:56 -0700 (PDT)
From: Jim Carter <jimc@math.ucla.edu>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Jamie Lokier <jamie@shareable.org>, Matt Mackall <mpm@selenic.com>,
       James Morris <jmorris@intercode.com.au>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, davem@redhat.com
Subject: Re: i810_rng.o on various Dell models
In-Reply-To: <20030813035257.GB1244@think>
Message-ID: <Pine.LNX.4.53.0308130830170.3016@xena.cft.ca.us>
References: <20030809173329.GU31810@waste.org>
 <Mutt.LNX.4.44.0308102317470.7218-100000@excalibur.intercode.com.au>
 <20030810174528.GZ31810@waste.org> <20030811020919.GD10446@mail.jlokier.co.uk>
 <20030813035257.GB1244@think>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In response to a message of Theodore Ts'o <tytso@mit.edu> dated 2003-08-12
(Subject was: [RFC][PATCH] Make cryptoapi non-optional?):

I've recently come to the unpleasant conclusion that the reason i810_rng.o
(kernel 2.4.20) doesn't load on various Dell models (on none of the
numerous Dell models I've tried) is that the motherboards actually lack the
hardware random number generator.  The motherboard of a Dell Dimension 4100
has a SST 49LF004A firmware hub, not an Intel 82802AB, and among those
chips plus the Winbond W39V040FA and the STM M50FW040, presumably most of
the ones competing for that market, only the Intel chip has the random
number generator.

It's a violation of modularity plus a very effective marketing ploy for
Intel to put the RNG on the BIOS flash RAM chip.  Hiss, boo!

Dell has a very effective procedure for discouraging customer feedback, and
I have not been able to identify a useful recipient for product
suggestions.  If any of you people happen to have the ear of someone at
Dell, could you please carry a message that there are people who depend on
crypto, and will suggest to their management that all machines must have a
hardware random number generator, and that would leave Dell out of the
running.

A similar suggestion might be made to Winbond, STM and SST.

James F. Carter          Voice 310 825 2897    FAX 310 206 6673
UCLA-Mathnet;  6115 MSA; 405 Hilgard Ave.; Los Angeles, CA, USA 90095-1555
Email: jimc@math.ucla.edu  http://www.math.ucla.edu/~jimc (q.v. for PGP key)
