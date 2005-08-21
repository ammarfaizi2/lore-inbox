Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751210AbVHUVqK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751210AbVHUVqK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Aug 2005 17:46:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751208AbVHUVov
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Aug 2005 17:44:51 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:6606 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751199AbVHUVoq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Aug 2005 17:44:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=ybh0V+eaLMsgJVgSLgXarezl8cYnmx8F54+MktAoyEeA27OBB1iD+zbBY2/qMPfylbC+L5zFiQnz9S+yJVPFbnG5HUVQgC0xBQR2Rom8D4f+C3MUPym7eTBlRrynvOFGMKctFVUKCJUoZZrr//Hpv2L/XATxgXMEPrBp+3eqTvU=  ;
Message-ID: <20050821161805.74083.qmail@web33309.mail.mud.yahoo.com>
Date: Sun, 21 Aug 2005 09:18:05 -0700 (PDT)
From: Danial Thom <danial_thom@yahoo.com>
Reply-To: danial_thom@yahoo.com
Subject: Re: 2.6.12 Performance problems
To: Patrick McHardy <kaber@trash.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4308A8A0.9060402@trash.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--- Patrick McHardy <kaber@trash.net> wrote:

> Danial Thom wrote:
> > I just started fiddling with 2.6.12, and
> there
> > seems to be a big drop-off in performance
> from
> > 2.4.x in terms of networking on a
> uniprocessor
> > system. Just bridging packets through the
> > machine, 2.6.12 starts dropping packets at
> > ~100Kpps, whereas 2.4.x doesn't start
> dropping
> > until over 350Kpps on the same hardware
> (2.0Ghz
> > Opteron with e1000 driver). This is pitiful
> > prformance for this hardware. I've 
> > increased the rx ring in the e1000 driver to
> 512
> > with little change (interrupt moderation is
> set
> > to 8000 Ints/second). Has "tuning" for MP 
> > destroyed UP performance altogether, or is
> there
> > some tuning parameter that could make a
> 4-fold
> > difference? All debugging is off and there
> are 
> > no messages on the console or in the error
> logs.
> > The kernel is the standard kernel.org dowload
> > config with SMP turned off and the intel
> ethernet
> > card drivers as modules without any other
> > changes, which is exactly the config for my
> 2.4
> > kernels.
> 
> Do you have netfilter enabled? Briging
> netfilter was
> added in 2.6, enabling it will influence
> performance
> negatively. Otherwise, is this performance drop
> visible in other setups besides bridging as
> well?
> 

Yes, bridging is clean. I also routed with the
same performance drop.

Danial


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
