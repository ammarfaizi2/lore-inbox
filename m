Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282850AbRLGQG1>; Fri, 7 Dec 2001 11:06:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282861AbRLGQGN>; Fri, 7 Dec 2001 11:06:13 -0500
Received: from bitmover.com ([192.132.92.2]:16013 "EHLO bitmover.bitmover.com")
	by vger.kernel.org with ESMTP id <S282850AbRLGQGE>;
	Fri, 7 Dec 2001 11:06:04 -0500
Date: Fri, 7 Dec 2001 08:06:03 -0800
From: Larry McVoy <lm@bitmover.com>
To: Henning Schmiedehausen <hps@intermeta.de>
Cc: Daniel Phillips <phillips@bonn-fries.net>, Larry McVoy <lm@bitmover.com>,
        "David S. Miller" <davem@redhat.com>, davidel@xmailserver.org,
        rusty@rustcorp.com.au, Martin.Bligh@us.ibm.com, riel@conectiva.com.br,
        lars.spam@nocrew.org, alan@lxorguk.ukuu.org.uk,
        linux-kernel@vger.kernel.org
Subject: Re: SMP/cc Cluster description
Message-ID: <20011207080603.B6983@work.bitmover.com>
Mail-Followup-To: Henning Schmiedehausen <hps@intermeta.de>,
	Daniel Phillips <phillips@bonn-fries.net>,
	Larry McVoy <lm@bitmover.com>, "David S. Miller" <davem@redhat.com>,
	davidel@xmailserver.org, rusty@rustcorp.com.au,
	Martin.Bligh@us.ibm.com, riel@conectiva.com.br,
	lars.spam@nocrew.org, alan@lxorguk.ukuu.org.uk,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011206115338.E27589@work.bitmover.com> <20011206.121554.106436207.davem@redhat.com> <20011206122116.H27589@work.bitmover.com> <E16C665-0000r5-00@starship.berlin> <1007715304.13220.0.camel@forge>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <1007715304.13220.0.camel@forge>; from hps@intermeta.de on Fri, Dec 07, 2001 at 09:54:58AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> How about creating one node as "master" and write a "cluster network
> filesystem" which uses shared memory as its "network layer". 

Right.

> Then boot all other nodes diskless from these cluster network
> filesystems.

Wrong.  Give each node its own private boot fs.  Then mount /data.

> You can still have shared mmap (which I believe is Larry's toy point)
> between the nodes but you avoid all of the filesystem locking issues,
> because you're going over (a hopefully superfast) memory network
> filesystem.

There is no network, unless you consider the memory interconnect a 
network (I think the hardware guys would raise their eyebrows at 
that name).

> What I don't like about the approach is the fact that all nodes should
> share the same file system. One (at least IMHO) does not want this for
> at least /etc. 

Read through my other postings, I said that things are private by
default.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
