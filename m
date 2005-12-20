Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932102AbVLTVnU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932102AbVLTVnU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 16:43:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932104AbVLTVnT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 16:43:19 -0500
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:13462 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932102AbVLTVnT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 16:43:19 -0500
Subject: Re: [PATCH RT 00/02] SLOB optimizations
From: Steven Rostedt <rostedt@goodmis.org>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: Christoph Lameter <christoph@lameter.com>,
       Alok N Kataria <alokk@calsoftinc.com>,
       Shobhit Dayal <shobhit@calsoftinc.com>,
       Shai Fultheim <shai@scalex86.org>, Matt Mackall <mpm@selenic.com>,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       john stultz <johnstul@us.ibm.com>,
       Gunter Ohrner <G.Ohrner@post.rwth-aachen.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <84144f020512201215j5767aab2nc0a4115c4501e066@mail.gmail.com>
References: <dnu8ku$ie4$1@sea.gmane.org>
	 <1134790400.13138.160.camel@localhost.localdomain>
	 <1134860251.13138.193.camel@localhost.localdomain>
	 <20051220133230.GC24408@elte.hu>
	 <Pine.LNX.4.58.0512200836120.21313@gandalf.stny.rr.com>
	 <20051220135725.GA29392@elte.hu>
	 <Pine.LNX.4.58.0512200900490.21767@gandalf.stny.rr.com>
	 <1135093460.13138.302.camel@localhost.localdomain>
	 <20051220181921.GF3356@waste.org>
	 <1135106124.13138.339.camel@localhost.localdomain>
	 <84144f020512201215j5767aab2nc0a4115c4501e066@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 20 Dec 2005 16:42:51 -0500
Message-Id: <1135114971.13138.396.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-12-20 at 22:15 +0200, Pekka Enberg wrote:
> Hi Steve and Matt,
> 
> On 12/20/05, Steven Rostedt <rostedt@goodmis.org> wrote:
> > That looks like quite an undertaking, but may be well worth it.  I think
> > Linux's memory management is starting to show it's age.  It's been
> > through a few transformations, and maybe it's time to go through
> > another.  The work being done by the NUMA folks, should be taking into
> > account, and maybe we can come up with a way that can make things easier
> > and less complex without losing performance.
> 
> The slab allocator is indeed complex, messy, and hard to understand.
> In case you're interested, I have included a replacement I started out
> a while a go. It follows the design of a magazine allocator described
> by Bonwick. It's not a complete replacement but should boot (well, did
> anyway at some point). I have also included a user space test harness
> I am using to smoke it.
> 
> If there's enough interest, I would be more than glad to help write a
> replacement for mm/slab.c :-)

Hi Pekka,

What other interest have you pulled up on this?  I mean, have others
shown interest in pushing something like this.  Today's slab system is
starting to become like the IDE where nobody, but a select few
sado-masochis, dare to venture in. (I've CC'd them ;)  Perhaps it would
make the addition of NUMA easier.

Maybe, putting this into RT might be a way to get it tested, and help us
with the memory management and a fully preemptible kernel.

-- Steve

For those just coming in, Pekka posted this:

http://marc.theaimsgroup.com/?l=linux-kernel&m=113510997009883&w=2


