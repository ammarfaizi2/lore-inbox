Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262394AbSKMTCt>; Wed, 13 Nov 2002 14:02:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262395AbSKMTCs>; Wed, 13 Nov 2002 14:02:48 -0500
Received: from [196.12.44.6] ([196.12.44.6]:23772 "EHLO students.iiit.net")
	by vger.kernel.org with ESMTP id <S262394AbSKMTCr>;
	Wed, 13 Nov 2002 14:02:47 -0500
Date: Thu, 14 Nov 2002 00:36:21 +0530 (IST)
From: Prasad <prasad_s@students.iiit.net>
To: Bruce Walker <bruce@kahuna.lax.cpqcorp.net>
cc: "Aneesh Kumar K.V" <aneesh.kumar@digital.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       ssic-linux-devel <ssic-linux-devel@lists.sourceforge.net>
Subject: Re: [SSI] Re: Distributed Linux
In-Reply-To: <200211131747.gADHlSs03356@kahuna.lax.cpqcorp.net>
Message-ID: <Pine.LNX.4.44.0211140023310.6182-100000@students.iiit.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 13 Nov 2002, Bruce Walker wrote:

> > > As a graduation project i intended to make linux distributed 
> 
> snip
> > 
> > >The guest system (where the process originated) would
> > >however have a pseudo process running on it, which would not take much
> > >resources but would help in handling various signals/
> > 
> > SSI support cluster wide signaling. That means you can send signal to a
> > process running on other node( you have cluster wide PID )
> > 
> The openSSI process model is quite different than Bproc or Mosix or
> your "guest system" proposal.  In the openSSI model, there is no
> pseudo or shadow process at the processes creation node;  after
> a processes migrates, all its system calls are executed on the new
> node and signalling to the process is done directly to the process on
> the new node.  Besides the obvious performance advantages this can
> give, it can also provide availability advantages because the 
> creation node can go down without taking the process down with it.
> 

Yeah, openSSI approach has some advantages, but how about the other side,
how are the devices and files being handled?  isn't it wrong to run
someone elses process when the data that he is supposed to provide is
missing?  My work is based on a workstation model where all the nodes are
independent workstations (in most cases with similar configurations, as in
a computer laboratory at a university).  One of my major constraints is
that the system should be binary compatible with the kernel that does not
support my model. In my case i plan packing and restarting a process when
the creation node goes down.

Prasad.

> bruce
> 
> > -aneesh 
> > 

-- 
Failure is not an option

