Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267613AbTAMDUp>; Sun, 12 Jan 2003 22:20:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267619AbTAMDUp>; Sun, 12 Jan 2003 22:20:45 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:18959 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267613AbTAMDUo>; Sun, 12 Jan 2003 22:20:44 -0500
Date: Sun, 12 Jan 2003 19:24:46 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Greg Ungerer <gerg@snapgear.com>
cc: Rusty Russell <rusty@rustcorp.com.au>, Miles Bader <miles@gnu.org>,
       <linux-kernel@vger.kernel.org>, David McCullough <davidm@snapgear.com>
Subject: Re: exception tables in 2.5.55
In-Reply-To: <3E222E99.2040206@snapgear.com>
Message-ID: <Pine.LNX.4.44.0301121921570.24605-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 13 Jan 2003, Greg Ungerer wrote:
> 
> Tested and working on m68knommu architecture.

Why does exceptions have anything to do with no-mmu?

There are exceptions that have nothing to do with MMU's, and a no-mmu 
architecture should still support them.  On x86, we have a number of such 
exceptions, for example general protection stuff for wrong values for 
special registers etc.

In other words, not applied. Page table exceptions are just the most 
_common_ exception type, but there's absolutely nothing in the mechanism 
that has anything at all to do with MMU-less.

If some archtiecture happens to have an empty exception table, that's 
fine. 

		Linus

