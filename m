Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315890AbSEGQ0w>; Tue, 7 May 2002 12:26:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315891AbSEGQ0v>; Tue, 7 May 2002 12:26:51 -0400
Received: from gate.in-addr.de ([212.8.193.158]:25612 "HELO mx.in-addr.de")
	by vger.kernel.org with SMTP id <S315890AbSEGQ0u>;
	Tue, 7 May 2002 12:26:50 -0400
Date: Tue, 7 May 2002 18:26:20 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: Jeff Dike <jdike@karaya.com>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
        user-mode-linux-user@lists.sourceforge.net
Subject: Re: [uml-devel] Re: UML is now self-hosting!
Message-ID: <20020507182620.U2539@marowsky-bree.de>
In-Reply-To: <20020506181427.K918@marowsky-bree.de> <200205062055.PAA04067@ccure.karaya.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.22.1i
X-Ctuhulu: HASTUR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2002-05-06T15:55:52,
   Jeff Dike <jdike@karaya.com> said:

> > but spreading an instance across multiple nodes is nowhere as simple
> > as it seems; 
> It is if you want to be sufficiently stupid about it :-)

Ugh.

> > where do you keep OS data, 
> It gets faulted from host to host as needed.

Ugh Ugh Ugh. You need coherency algorithms for these.

> > IO access, 
> This scheme (and any clustering scheme, I think) would need back channels
> for one node to access the devices of another

Right. You need communication services and coherency algorithms for these ;-)

> > scheduling decisions, 
> This machine thinks it's a normal SMP box, so scheduling happens as normal

Ugh ugh ugh. Too many page faults; you need a scheduler capable of keeping
node affinity.

> > inter-node communication in the first place, how to deal
> > with node failure etc...
> Maybe I'm not familiar enough with the clustering world, but I was under the
> impression that with a normal SSI cluster, the nodes are like CPUs in an
> SMP box - if one fails, the whole thing dies.  In other words, that SSI
> clustering and HA clustering are pretty disjoint.

No. In the optimal case, nothing dies. ;-) In the less than optimal case, only
the processes affected directly by the failure die (the processes which had
dirty pages there etc).

In the really useless case, the entire cluster goes down like on a SMP box or
an unpartitioned CC-NUMA.

"In search of clusters" is definetely highly recommended reading. It is very
entertaining, too.


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
Immortality is an adequate definition of high availability for me.
	--- Gregory F. Pfister

