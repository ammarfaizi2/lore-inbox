Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285302AbRLFXUu>; Thu, 6 Dec 2001 18:20:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285301AbRLFXUn>; Thu, 6 Dec 2001 18:20:43 -0500
Received: from pizda.ninka.net ([216.101.162.242]:43148 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S285297AbRLFXUN>;
	Thu, 6 Dec 2001 18:20:13 -0500
Date: Thu, 06 Dec 2001 15:19:45 -0800 (PST)
Message-Id: <20011206.151945.57439059.davem@redhat.com>
To: lm@bitmover.com
Cc: alan@lxorguk.ukuu.org.uk, phillips@bonn-fries.net, davidel@xmailserver.org,
        rusty@rustcorp.com.au, Martin.Bligh@us.ibm.com, riel@conectiva.com.br,
        lars.spam@nocrew.org, hps@intermeta.de, linux-kernel@vger.kernel.org
Subject: Re: SMP/cc Cluster description
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20011206151504.R27589@work.bitmover.com>
In-Reply-To: <20011206143218.O27589@work.bitmover.com>
	<E16C7QX-0003PC-00@the-village.bc.nu>
	<20011206151504.R27589@work.bitmover.com>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Larry McVoy <lm@bitmover.com>
   Date: Thu, 6 Dec 2001 15:15:04 -0800
   
   Wait a second, you're missing something.  If you are going to make a single
   OS image work on a 64 way (or whatever) SMP, you have all of these issues,
   right?  I'm not introducing additional locking problems with the design.

And you're not taking any of them away from the VFS layer.  That is
where all the real fundamental current scaling problems are in the
Linux kernel.

That is why I spent so much timing describing the filesystem name path
locking problem, those are the major hurdles we have to go over.
Networking is old hat, people have done work to improve the scheduler
scaling, it's just these hand full of VFS layer issues that are
dogging us.

So my point is, if you're going to promote some "locking complexity"
advantage, I don't think that's where a ccCluster even makes a dent in
the viability spectrum.

Where it does have advantages are for things like offlining node
clusters in a NUMA system.  High availability et al.
