Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318710AbSHALOz>; Thu, 1 Aug 2002 07:14:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318711AbSHALOz>; Thu, 1 Aug 2002 07:14:55 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:35793 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S318710AbSHALOy>; Thu, 1 Aug 2002 07:14:54 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Mikael Pettersson <mikpe@csd.uu.se>
Date: Thu, 1 Aug 2002 21:18:49 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15689.6425.831225.798836@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NFS ACL compatibility [was: Re: [2.6] The List, pass #2]
In-Reply-To: message from Mikael Pettersson on Thursday August 1
References: <200208011103.NAA01989@harpo.it.uu.se>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday August 1, mikpe@csd.uu.se wrote:
> 
> Speaking of NFS compatibility: can Linux' NFS server implement ACLs
> in a way that's compatible with Solaris NFS clients?

Can?  well, anything is possible.  It's just an SMP - a simple matter
      of programming.
Does? no.  Linux doesn't even support ACLs (without patches)  I know
      of no work to interface any of the ACL patches with NFS, except
      for the NFSv4 work, which doesn't really help you.

> 
> A sysadmin over here says this isn't the case, because Sun apparently
> stepped outside of the NFSv3 protocol and handles ACLs with a
> separate RPC program.

Yep.  NFSv3 doesn't know about ACLs. SUN invented an NFS_ACL protocol
which is sufficiently well documented (I have a .x file) that it would
be fairly trivial to implement ... if you had a filesystem that could
store compatible acls.

> 
> The significance of this is that unless Linux' NFS server can be made
> fully compatible with Solaris NFS clients, we can't use Linux for the
> new high-performance NFS servers we need to install this fall, forcing
> us to go with Solaris and fairly expensive Sun HW.

So the question becomes,  does the price difference mean enough money
that it is worth contracting someone to make it work.... and can you
afford the risks.

NeilBrown
