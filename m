Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132314AbQLVUOh>; Fri, 22 Dec 2000 15:14:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132260AbQLVUO1>; Fri, 22 Dec 2000 15:14:27 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:8965 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S131257AbQLVUOQ>; Fri, 22 Dec 2000 15:14:16 -0500
Date: Fri, 22 Dec 2000 13:39:08 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Pauline Middelink <middelin@polyware.nl>, linux-kernel@vger.kernel.org,
        jmerkey@timpanogas.org
Subject: Re: NUMA and SCI [was Re: bigphysarea support in 2.2.19 and 2.4.0 kernels]
Message-ID: <20001222133908.A1686@vger.timpanogas.org>
In-Reply-To: <20001221144247.A10273@vger.timpanogas.org> <E149DKS-0003cX-00@the-village.bc.nu> <20001221154446.A10579@vger.timpanogas.org> <20001221155339.A10676@vger.timpanogas.org> <20001222093928.A30636@polyware.nl> <20001222111105.B14232@vger.timpanogas.org> <20001222113729.A8972@scutter.internal.splhi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20001222113729.A8972@scutter.internal.splhi.com>; from timw@splhi.com on Fri, Dec 22, 2000 at 11:37:29AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 22, 2000 at 11:37:29AM -0800, Tim Wright wrote:

I have been working with SCI since 1994.  The people who own 
Dolphin and the SCI chipsets also own TRG.  We dropped work in 
the P6 ccNUMA cards several years back because Intel was 
convinced that shared-nothing was the way to go (and it is).
However, SCI's ability to create explicit sharing makes it
the fastest shared nothing interface around for message passing
(go figure).

I think we do need some bettr APIs.  Grab the source at my FTP server,
and I'd love any input you could provide.

Thanks,

:-)

Jeff


> Hi Jeff,
> 
> On Fri, Dec 22, 2000 at 11:11:05AM -0700, Jeff V. Merkey wrote:
> [...]
> > SCI allows machines to create windows of shared memory across a cluster
> > of nodes, and at 1 Gigabyte-per-second (Gigabyte not gigabit).  I am
> > putting a sockets interface into the drivers so Apache, LVS, and 
> > Pirahna can use these very high speed adapters for a clustered web 
> > server.  Our M2FS clustered file system also is being architected 
> > to use these cards.  
> 
> You're probably aware of this, but SCI allows a lot more then the creation
> of windows of shared memory. The IBM NUMA-Q machines (what was Sequent), use
> the SCI interconnect to build a single-system image machine with all memory
> visible from all "nodes". In fact, all the commercial NUMA machines of which
> I am aware have this property (all nodes see and can address all memory). The
> non-uniform part of NUMA comes from the potentially differing latency and
> speed of different parts of memory (local vs remote in this case).
> AFAIK, the work that Kanoj Sarcar has been doing is to enable such machines.
> 
> It sounds like you have a different requirement of very high-speed shared
> memory between different nodes that can be mapped and unmapped as required.
> Do I understand this correctly ? That would make your requirements somewhat
> orthogonal to the requirements those of us with NUMA architectures have.
> 
> > I will post the source code for the SCI cards at vger.timpanogas.org 
> > and if you have time, please download this code and take a look at 
> > how we are using the bigphysarea APIs to create these windows accros
> > machines.  The current NUMA support in Linux is somewhat slim, and 
> > I would like to use established APIs to do this if possible.
> 
> See above. It may be that you need different APIs anyway.
> 
> Regards,
> 
> Tim
> 
> -- 
> Tim Wright - timw@splhi.com or timw@aracnet.com or twright@us.ibm.com
> IBM Linux Technology Center, Beaverton, Oregon
> "Nobody ever said I was charming, they said "Rimmer, you're a git!"" RD VI
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
