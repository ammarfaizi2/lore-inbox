Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278136AbRJRVkd>; Thu, 18 Oct 2001 17:40:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278160AbRJRVkX>; Thu, 18 Oct 2001 17:40:23 -0400
Received: from pc1-camb5-0-cust171.cam.cable.ntl.com ([62.253.134.171]:27044
	"EHLO fenrus.demon.nl") by vger.kernel.org with ESMTP
	id <S278149AbRJRVkM>; Thu, 18 Oct 2001 17:40:12 -0400
From: arjan@fenrus.demon.nl
To: spotter@cs.columbia.edu (Shaya Potter)
Subject: Re: xircom_cb and promiscious mode
cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.31.0110181725190.764-100000@diamond.cs.columbia.edu>
X-Newsgroups: fenrus.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.3-6.0.1 (i586))
Message-Id: <E15uKqE-0004VS-00@fenrus.demon.nl>
Date: Thu, 18 Oct 2001 22:36:38 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.GSO.4.31.0110181725190.764-100000@diamond.cs.columbia.edu> you wrote:

> in looking through the source for the driver, it seems from the comments
> that when the card is in interrupt handler mode, it has to turn
> promiscious mode on.  I don't know why, but I do know that it never seems
> to turn it off.  I basically stuck a return in the enable_promisc function
> before it does anything, and that cleared up all my problems.

It actually doesn't need the promisc for most revisions of the card, but for
some it seems to be really needed.

The xircom_tulip_cb driver is more advanced, and probably works well for
your system. (It doesn't work for all cards, but I suspect that correlates
highly with the revision that needs the promisc)
