Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264812AbTFVRnr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jun 2003 13:43:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264825AbTFVRnr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jun 2003 13:43:47 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:14862 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S264812AbTFVRnq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jun 2003 13:43:46 -0400
Date: Sun, 22 Jun 2003 10:56:57 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrew Morton <akpm@digeo.com>
cc: Daniel Phillips <phillips@arcor.de>, <acme@conectiva.com.br>,
       <cw@f00f.org>, <geert@linux-m68k.org>, <alan@lxorguk.ukuu.org.uk>,
       <perex@suse.cz>, <linux-kernel@vger.kernel.org>
Subject: Re: GCC speed (was [PATCH] Isapnp warning)
In-Reply-To: <20030622103251.158691c3.akpm@digeo.com>
Message-ID: <Pine.LNX.4.44.0306221049280.15159-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 22 Jun 2003, Andrew Morton wrote:
> 
> I compile with -O1 all the time and couldn't care the teeniest little bit
> about the performance of the generated code - it just doesn't matter.

Well, sometimes it _does_ matter from a correctness standpoint. For 
example, gcc without optimizations was simply unusable, because of the 
lack of inlining or the lack of even trivial optimizations (ie static dead 
code removal).

And a (unrelated) gcc list thread showed that even with just -O1, one 
particular project had gone from 131 seconds (gcc-2.7.2) to 180 seconds 
(2.95.3) to 282 seconds (3.3) to 327 seconds (the tree-ssa branch).

		Linus

