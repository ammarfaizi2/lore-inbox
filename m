Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261780AbUC0PG2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Mar 2004 10:06:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261785AbUC0PG2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Mar 2004 10:06:28 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:10413 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261780AbUC0PGV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Mar 2004 10:06:21 -0500
Date: Sat, 27 Mar 2004 11:34:02 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Ivan Godard <igodard@pacbell.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel support for peer-to-peer protection models...
Message-ID: <20040327103401.GA589@openzaurus.ucw.cz>
References: <048e01c413b3_3c3cae60_fc82c23f@pc21>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <048e01c413b3_3c3cae60_fc82c23f@pc21>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> 1) had a large number of distinguishable address spaces
> 2) any running code had two of these (code and data environment) it could
> use arbitrarily, but access to addresses in others was arbitrarily protected
> 3) flat, unified virtual addresses (64 bit) so that pointers, including
> inter-space pointers, have the same representation in all spaces

Hmm, will it be possible to have UML?

> 4) no "supervisor mode"

Is all your i/o memory mapped?

> 5) inter-space references require grant of access (transitive) by the
> accessed space; grants can be entire space or any contiguous subspace
> 6) inter-space reference has same performance as intra-space

Huh? Does it mean that all the accesses are horibly slow?

> 9) Hardware interrupts are involuntary inter-space calls. They do not
> require locking (assuming the handler is re-entrant - and if not then only
> from themselves), nor task switch, nor disabling other interrupts. The
> handler runs in the stack of whoever got interrupted, which (depending on
> interrupt priorities) could be another interrupt, on an interrupt, ... on an
> app, all mutually protected.

How do you implement ptrace if apps are protected from kernel?

> 10) Drivers can have their own individual space(s) distinct from those of
> the kernel and the apps. Buggy drivers cannot crash the kernel.

Well... buggy drivers can usually program DMA to do crashing for them.
How is your architecture called?

> dealing with protection models, interrupts, trap handling and the like? What
> about partitioning the kernel into disjoint (and mutually protected)
> components like IP stack, password/security, FS etc?

That would be pretty big rewrite...

Anyway, I believe you *do* want linux on it, if only as a test load.
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

