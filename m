Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265089AbTLCShU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 13:37:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265101AbTLCShU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 13:37:20 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:63137
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S265089AbTLCShS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 13:37:18 -0500
Date: Wed, 3 Dec 2003 19:37:19 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Ian Soboroff <ian.soboroff@nist.gov>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.23 includes Andrea's VM?
Message-ID: <20031203183719.GD24651@dualathlon.random>
References: <9cfptf6vts7.fsf@rogue.ncsl.nist.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9cfptf6vts7.fsf@rogue.ncsl.nist.gov>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 03, 2003 at 09:51:36AM -0500, Ian Soboroff wrote:
> 
> I have a machine with 12GB of RAM, and I've been running a 2.4.22-era
> kernel with Andrea's patches on it, otherwise it dies from lack of
> lowmem.  
> 
> The latest -aa patch is for 2.4.23-pre6, but I see in the 2.4.23
> Changelog that at least some bits of Andrea's VM were merged.  Should
> I be able to run a vanilla 2.4.23 on this box?

It's probably going to work an order of magnitude better thanks
especially to the lower_zone_reserve algorithm.

However I'd still recommend to use my tree, the last two critical bits
you need from my tree are inode-highmem and related_bhs. Those two are
still missing, and you probably need them with 12G.

I'm going to release a 2.4.23aa1 btw, that will be the last 2.4-aa.
