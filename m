Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313181AbSFXNGW>; Mon, 24 Jun 2002 09:06:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313305AbSFXNGV>; Mon, 24 Jun 2002 09:06:21 -0400
Received: from jalon.able.es ([212.97.163.2]:37342 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S313181AbSFXNGU>;
	Mon, 24 Jun 2002 09:06:20 -0400
Date: Mon, 24 Jun 2002 15:06:12 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: "Craig I. Hagan" <hagan@cih.com>
Cc: Sandy Harris <pashley@storm.ca>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux, the microkernel (was Re: latest linus-2.5 BK broken)
Message-ID: <20020624130612.GA1770@werewolf.able.es>
References: <Pine.LNX.4.44.0206232323250.20806-100000@svr.cih.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <Pine.LNX.4.44.0206232323250.20806-100000@svr.cih.com>; from hagan@cih.com on Mon, Jun 24, 2002 at 08:27:00 +0200
X-Mailer: Balsa 1.3.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.06.24 Craig I. Hagan wrote:
>> Also, it isn't as clear that clustering experience applies. Are clusters
>> that size built hierachically? Is a 1024-CPU Beowulf practical, and if so
>> do you build it as a Beowulf of 32 32-CPU Beowulfs? Is something analogous
>> required in the OSlet approach? would it work?
>
>a system of that size has many "practical" applications. It *can* be done
>without partitioning it into a tree hierarchy, however, you will need a very
>capable interconnect (quadrics and myrinet come to mind). Tt that you'll have a
>tiered switching hierarchy even if the nodes are presented in a flat layer.
>
>IMHO nearly any level of breakout for grid computing (basically a cluster
>hierarchy) starts to become interesting as a function of your app/problem size
>and how many simultanous jobs you are running.
>
>Of course, we can stop and hit reality for a second: not many people can afford
>a 1024 cpu cluster, hence the proliferation of smaller ones ;)
>

You do not have to go so far. Take a simple cluster of dual Xeon boxes (ie, 
4 'cpus' per box). Current clustering software (MPI, PVM) is not ready to
handle a 2-level hierarchy, one with slow communications over tcp and a lower
level working as a shared-memory thread-able cluster.
It would not be so strange nowadays (nor too much expensive) to have a 8-16
nodes with 4 cpus each.

-- 
J.A. Magallon             \   Software is like sex: It's better when it's free
mailto:jamagallon@able.es  \                    -- Linus Torvalds, FSF T-shirt
Linux werewolf 2.4.19-pre10-jam3, Mandrake Linux 8.3 (Cooker) for i586
gcc (GCC) 3.1.1 (Mandrake Linux 8.3 3.1.1-0.6mdk)
