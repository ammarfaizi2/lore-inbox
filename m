Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264928AbUGGGif@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264928AbUGGGif (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 02:38:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264931AbUGGGif
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 02:38:35 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:15150 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S264928AbUGGGhq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 02:37:46 -0400
Subject: Re: quite big breakthrough in the BAD network performance, which
	mm6 did not fix
From: Redeeman <lkml@metanurb.dk>
To: bert hubert <ahu@ds9a.nl>
Cc: LKML Mailinglist <linux-kernel@vger.kernel.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>
In-Reply-To: <20040707063100.GA18382@outpost.ds9a.nl>
References: <200407061930.i66JUpqI009671@eeyore.valparaiso.cl>
	 <1089160973.903.1.camel@localhost>
	 <200407061812.24526.lkml@lpbproductions.com>
	 <1089179186.10677.8.camel@localhost>
	 <20040707063100.GA18382@outpost.ds9a.nl>
Content-Type: text/plain
Date: Wed, 07 Jul 2004 08:37:44 +0200
Message-Id: <1089182265.10687.4.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.9 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-07-07 at 08:31 +0200, bert hubert wrote:
> On Wed, Jul 07, 2004 at 07:46:26AM +0200, Redeeman wrote:
> > this must be some misunderstanding, i do not want to complain, and i
> > dont hope people get that impression, i am trying to do feedback, so
> > that issues can be fixed.
> 
> Redeeman - your firewall is broken, or somebody's firewall. 
i dont have a firewall, but i am afraid my isp probably is doing
something, after reading another thread :(
> 
> Look at  /proc/sys/net/ipv4/tcp_default_win_scale , if it currently contains
> 7, do:
> 
> echo 1 > /proc/sys/net/ipv4/tcp_default_win_scale
its 1 as default, using the tcp patch from another thread fixes so that i can connect to sites. (packages.gentoo.org etc)
where before that patch came, i echo'ed 0 into it, and it worked aswell,
however i didnt get more than 50kb/s either :|
> and retry.
> 
> > downloads with 200kb/s from http://kernel.org, and 2.6.7 only 50kb/s,
> > this should be able to prove its some issues with 2.6.7, but thats just
> > my opinion
> 
> Things can be more complicated than they appear. Currently all evidence for
> these changes points to firewalls messing with TCP options, TCP options
> which used to have more default versions in older kernels.
yes, i just realised that :(
> 
> Regards,
> 
> bert
> 

