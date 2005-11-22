Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030215AbVKVWtI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030215AbVKVWtI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 17:49:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030214AbVKVWtI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 17:49:08 -0500
Received: from pfepa.post.tele.dk ([195.41.46.235]:57450 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S1030212AbVKVWtF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 17:49:05 -0500
Date: Tue, 22 Nov 2005 23:49:14 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: "David S. Miller" <davem@davemloft.net>
Cc: kaber@trash.net, bunk@stusta.de, evil@g-house.de,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       zippel@linux-m68k.org
Subject: Re: [2.6 patch] do not select NET_CLS
Message-ID: <20051122224914.GA17575@mars.ravnborg.org>
References: <20051116235813.GS5735@stusta.de> <20051121155955.GW16060@stusta.de> <4381F2D2.5000605@trash.net> <20051122.143713.101129339.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051122.143713.101129339.davem@davemloft.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2005 at 02:37:13PM -0800, David S. Miller wrote:
> 
> One thing we can do to prevent human
> mistakes, is to make the "make modules" pass do a quick "is vmlinux
> uptodate?" check, and if not print out an error message explaining the
> situation and aborting the "make modules" attempt.


I do not quite follow you here.

For a while I have considered implementing something that told why a
given file was compiled - like:

 CC     net/ipv4/ip_gre.o   due to net/dsfield.h, net/xfrm.h
 CC     net/ipv4/raw.c   due to include/config/ip/mroute.h

The latter is a config option that I do not see a possibility to change
back to a config option syntax (at least not without doing some effort).

My thinking was that 'make V=2' would give above printout.

But what you request is something that keep the dense printout without
building the kernel - right?

Any suggestion for an intuitive syntax to enable that?
'make -n V=2' will not do it.

	Sam
