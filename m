Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315324AbSDWT7C>; Tue, 23 Apr 2002 15:59:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315326AbSDWT7B>; Tue, 23 Apr 2002 15:59:01 -0400
Received: from mirapoint2.brutele.be ([212.68.193.7]:56639 "EHLO
	mirapoint2.brutele.be") by vger.kernel.org with ESMTP
	id <S315324AbSDWT7B>; Tue, 23 Apr 2002 15:59:01 -0400
Date: Tue, 23 Apr 2002 22:54:32 +0200
From: Vincent Guffens <guffens@auto.ucl.ac.be>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: Frank Louwers <frank@openminds.be>, linux-kernel@vger.kernel.org
Subject: Re: BUG: 2 NICs on same network
Message-ID: <20020423225432.A9021@auto.ucl.ac.be>
In-Reply-To: <20020423113935.A30329@openminds.be> <3CC55D62.1501C94A@nortelnetworks.com> <20020423172051.A22111@auto.ucl.ac.be> <3CC58DF3.A6AB95B1@nortelnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-face: $!yrw0$NB\Y%oy$vuiO5|@s&!qPXX?$FdAr!v/Jx1C8mGr,?D_,\-z|P^),fiP.EvS`t@/@f6zSb,<tSt2liuZz}@-tK6K1mTd@H+XHh/TaCQC^.8#?)wlRP3WE2L@8G[K.IK8"ckxDDz
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Actually, as long as you have your system set up to route based on source
> address (which you probably should if you care about strict arp replies)
> arp_filter seems to work properly.  I just tested with a 2.4.18 box, with the
> following address configuration:
> 

ok, I see, so both interfaces are replying to the arp request but this time, the first interface to reply, eth0, will have its
arp reply filtered by the arp_filter as ip_route_output will indicate eth1 as the outgoing interface for a packet that has its
source set to the ip to resolve, which has a source route policy entry to point to eth1, is it ?

But then, by curiosity, is there some reasons why two different interfaces shouldn't be in the same subnet ? I was in this
impression having configured some cisco routers which don't even accept this configuration. Is it possible on other network
devices ? Is there any theoretical justification ?


thanks for your explanations,

--
			Vincent Guffens
