Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132125AbRCYRCK>; Sun, 25 Mar 2001 12:02:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132122AbRCYRCA>; Sun, 25 Mar 2001 12:02:00 -0500
Received: from smtp1.cern.ch ([137.138.128.38]:28172 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S132124AbRCYRBq>;
	Sun, 25 Mar 2001 12:01:46 -0500
Date: Sun, 25 Mar 2001 19:00:59 +0200
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Mitchell Blank Jr <mitch@sfgoth.com>
Cc: Wichert Akkerman <wichert@cistron.nl>, linux-kernel@vger.kernel.org
Subject: Re: Larger dev_t
Message-ID: <20010325190059.B16840@pcep-jamie.cern.ch>
In-Reply-To: <UTC200103251231.OAA10795.aeb@vlet.cwi.nl> <99l375$rn5$1@picard.cistron.nl> <20010325081524.E30469@sfgoth.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010325081524.E30469@sfgoth.com>; from mitch@sfgoth.com on Sun, Mar 25, 2001 at 08:15:24AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mitchell Blank Jr wrote:
> Wichert Akkerman wrote:
> > You are just delaying the problem then, at some point your uptime will
> > be large enough that you have run through all 64bit pids for example.
> 
> 64 bits is enough to fork 1 million processes per second for over
> 500,000 years.  I think that's putting the problem off far enough.

The year is 2006.  IBM's latest supercluster has 1000 boxes, each with 4
x 8-way SMT processors running at 1THz.  Dense optical interconnect
provides NUMA-style cache coherency, and the entire system runs like a
giant SMP box (using kernel data structure replication).  Each active
thread is able to clone() 500,000,000 threads per second, in a pid space
shared throughout the cluster.

A virus arrives containing while(1){clone();}

Engineers observe pid wraparound approximately 2 weeks later :-)

-- Jamie
