Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261239AbUCCXQe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 18:16:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261255AbUCCXQd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 18:16:33 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:8720
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S261239AbUCCXPa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 18:15:30 -0500
Date: Thu, 4 Mar 2004 00:16:09 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Dave McCracken <dmccr@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: 230-objrmap fixes for 2.6.3-mjb2
Message-ID: <20040303231609.GX4922@dualathlon.random>
References: <20040303070933.GB4922@dualathlon.random> <20040303025820.2cf6078a.akpm@osdl.org> <7440000.1078328791@[10.10.2.4]> <20040303165746.GO4922@dualathlon.random> <10500000.1078333658@[10.1.1.4]> <20040303183901.GU4922@dualathlon.random> <14140000.1078339447@[10.1.1.4]> <20040303185122.GV4922@dualathlon.random> <102790000.1078349975@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <102790000.1078349975@flay>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03, 2004 at 01:39:35PM -0800, Martin J. Bligh wrote:
> > what we do in 2.4 and that works pretty well, that is simply to refile
> > pages into the active list if they're mlocked, so we don't waste too
> > much cpu on them since we don't analyze them too often. this should work
> > pretty well for everybody, or peraphs google may prefer to have a fully
> > consistent PG_mlocked.
> 
> If the page is actually mlocked, wouldn't it make more sense to remove
> it from both the active and inactive lists altogether? Scanning it seems
> like it'd be less than fruitful.

yes, that's probably better, but the brainer part of the code is
probably the same as for maintaining the bitflag.
