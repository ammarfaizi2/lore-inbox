Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264517AbTK0NWU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Nov 2003 08:22:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264518AbTK0NWU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Nov 2003 08:22:20 -0500
Received: from smithers.nildram.co.uk ([195.112.4.54]:19463 "EHLO
	smithers.nildram.co.uk") by vger.kernel.org with ESMTP
	id S264517AbTK0NWT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Nov 2003 08:22:19 -0500
Date: Thu, 27 Nov 2003 13:22:23 +0000
From: Joe Thornber <thornber@sistina.com>
To: Lars Marowsky-Bree <lmb@suse.de>
Cc: Joe Thornber <thornber@sistina.com>,
       Linux Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>
Subject: Re: dm patchset to remove the v1 interface
Message-ID: <20031127132223.GA11130@reti>
References: <20031127124626.GA470@reti> <20031127125955.GD2238@marowsky-bree.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031127125955.GD2238@marowsky-bree.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lars,

On Thu, Nov 27, 2003 at 01:59:55PM +0100, Lars Marowsky-Bree wrote:
> what is the status of the multipath personality for DM?

Heinz has written a target for 2.4, see:

people.sistina.com/~thornber/pending-patches/2.6-unstable/multipath

I've been looking at this and changing it a bit as it moves to 2.6.

We've provided an abstraction for a 'path selector' object, so people
can plug in their own selection policies (as discussed in Ottawa).
Currently there is a priority based round-robin selector, a latency
selector (dubious IMO) and I want to do a simple 'throughput
optimiser' selector.

Keep an eye on my unstable 2.6 tree which can be found via:

people.sistina.com/~thornber/

Currently this tree has experimental targets for:

snapshots
mirroring (just enough for pvmove ATM)
multipath
flakey (simple test target I'm using for multipath dev)


The LVM tools are at the design phase wrt. multipath.

- Joe
