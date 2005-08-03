Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262155AbVHCItB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262155AbVHCItB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 04:49:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262157AbVHCItA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 04:49:00 -0400
Received: from ns2.suse.de ([195.135.220.15]:62169 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S262155AbVHCIsx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 04:48:53 -0400
Date: Wed, 3 Aug 2005 10:48:49 +0200
From: Andi Kleen <ak@suse.de>
To: Christoph Lameter <christoph@lameter.com>
Cc: Paul Jackson <pj@sgi.com>, linux-kernel@vger.kernel.org, akpm@osdl.org,
       ak@suse.de
Subject: Re: [PATCH] String conversions for memory policy
Message-ID: <20050803084849.GB10895@wotan.suse.de>
References: <20050729152049.4b172d78.pj@sgi.com> <Pine.LNX.4.62.0507291746000.8663@graphe.net> <20050729230026.1aa27e14.pj@sgi.com> <Pine.LNX.4.62.0507301042420.26355@graphe.net> <20050730181418.65caed1f.pj@sgi.com> <Pine.LNX.4.62.0507301814540.31359@graphe.net> <20050730190126.6bec9186.pj@sgi.com> <Pine.LNX.4.62.0507301904420.31882@graphe.net> <20050730191228.15b71533.pj@sgi.com> <Pine.LNX.4.62.0508011147030.5541@graphe.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0508011147030.5541@graphe.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 01, 2005 at 11:48:55AM -0700, Christoph Lameter wrote:
> On Sat, 30 Jul 2005, Paul Jackson wrote:
> 
> > Would it make sense for you to do the same thing, when displaying
> > mempolicies in /proc/<pid>/numa_policy?
> 
> Here is a new rev of the conversions patch. Thanks for all the feedback:

I really hate this whole /proc/<pid>/numa_policy thing. /proc/<pid>/maps
was imho always a desaster (hard to parse, slow etc.). Also external
access of NUMA policies has interesting locking issues. I intentionally
didn't add something like that when I designed the original
NUMA API. Please don't add it.

-Andi
