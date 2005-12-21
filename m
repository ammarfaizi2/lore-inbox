Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932298AbVLUG5Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932298AbVLUG5Q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 01:57:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932299AbVLUG5Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 01:57:16 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:62623 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932298AbVLUG5P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 01:57:15 -0500
Date: Wed, 21 Dec 2005 07:56:19 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Pekka Enberg <penberg@cs.helsinki.fi>,
       Christoph Lameter <christoph@lameter.com>,
       Alok N Kataria <alokk@calsoftinc.com>,
       Shobhit Dayal <shobhit@calsoftinc.com>,
       Shai Fultheim <shai@scalex86.org>, Matt Mackall <mpm@selenic.com>,
       Andrew Morton <akpm@osdl.org>, john stultz <johnstul@us.ibm.com>,
       Gunter Ohrner <G.Ohrner@post.rwth-aachen.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH RT 00/02] SLOB optimizations
Message-ID: <20051221065619.GC766@elte.hu>
References: <1134860251.13138.193.camel@localhost.localdomain> <20051220133230.GC24408@elte.hu> <Pine.LNX.4.58.0512200836120.21313@gandalf.stny.rr.com> <20051220135725.GA29392@elte.hu> <Pine.LNX.4.58.0512200900490.21767@gandalf.stny.rr.com> <1135093460.13138.302.camel@localhost.localdomain> <20051220181921.GF3356@waste.org> <1135106124.13138.339.camel@localhost.localdomain> <84144f020512201215j5767aab2nc0a4115c4501e066@mail.gmail.com> <1135114971.13138.396.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1135114971.13138.396.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -1.7
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.7 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	1.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> [...] Today's slab system is starting to become like the IDE where 
> nobody, but a select few sado-masochis, dare to venture in. (I've CC'd 
> them ;) [...]

while it could possibly be cleaned up a bit, it's one of the 
best-optimized subsystems Linux has. Most of the "unnecessary 
complexity" in SLAB is related to a performance or a debugging feature.  
Many times i have looked at the SLAB code in a disassembler, right next 
to profile output from some hot workload, and have concluded: 'I couldnt 
do this any better even with hand-coded assembly'.

SLAB-bashing has become somewhat fashionable, but i really challenge 
everyone to improve the SLAB code first (to make it more modular, easier 
to read, etc.), before suggesting replacements.

the SLOB is nice because it gives us a simple option at the other end of 
the complexity spectrum. The SLOB should remain there. (but it certainly 
makes sense to make it faster, within certain limits, so i'm not 
opposing your SLOB patches per se.)

	Ingo
