Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315267AbSEFTyD>; Mon, 6 May 2002 15:54:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315268AbSEFTyC>; Mon, 6 May 2002 15:54:02 -0400
Received: from mnh-1-20.mv.com ([207.22.10.52]:64265 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S315267AbSEFTyB>;
	Mon, 6 May 2002 15:54:01 -0400
Message-Id: <200205062055.PAA04067@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: Lars Marowsky-Bree <lmb@suse.de>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
        user-mode-linux-user@lists.sourceforge.net
Subject: Re: [uml-devel] Re: UML is now self-hosting! 
In-Reply-To: Your message of "Mon, 06 May 2002 18:14:27 +0200."
             <20020506181427.K918@marowsky-bree.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 06 May 2002 15:55:52 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

lmb@suse.de said:
> but spreading an instance across multiple nodes is nowhere as simple
> as it seems; 

It is if you want to be sufficiently stupid about it :-)

> where do you keep OS data, 

It gets faulted from host to host as needed.

> IO access, 

This scheme (and any clustering scheme, I think) would need back channels
for one node to access the devices of another

> scheduling decisions, 

This machine thinks it's a normal SMP box, so scheduling happens as normal

> inter-node communication in the first place, how to deal
> with node failure etc...

Maybe I'm not familiar enough with the clustering world, but I was under the
impression that with a normal SSI cluster, the nodes are like CPUs in an
SMP box - if one fails, the whole thing dies.  In other words, that SSI
clustering and HA clustering are pretty disjoint.

				Jeff

