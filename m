Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265139AbUH0OKS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265139AbUH0OKS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 10:10:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265144AbUH0OKS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 10:10:18 -0400
Received: from main.gmane.org ([80.91.224.249]:43725 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S265139AbUH0OKC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 10:10:02 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Karl Vogel <karl.vogel@seagha.com>
Subject: Re: 2.6.8.1+patches: Still a memory leak with cdrecord
Date: Fri, 27 Aug 2004 14:09:57 +0000 (UTC)
Message-ID: <Xns9552A4ACE4078gmovkeb@80.91.224.252>
References: <412F27C1.6030100@bio.ifi.lmu.de>
Reply-To: karl.vogel@seagha.com
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: gateway.seagha.com
User-Agent: Xnews/5.04.25
X-Archive: encrypt
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Frank Steiner <fsteiner-mail@bio.ifi.lmu.de> wrote in
news:412F27C1.6030100@bio.ifi.lmu.de: 

> I'm not able to really track the problem down, because it is not
> permanent. PCs that were leaking yesterday, went fine this morning
> for the first 2-3 CDs, then started leaking again. Another PC
> that was leaking first, is now burning CDs without problems. All
> that with DMA always off for all the burners. I've also one
> PC that is always burning CDs without any leak (and they
> are all running the same kernel and have the same distribution/
> packet selection installed...).
> 
> I've no idea what's causing that flip-flop between leaking/non-leaking
> behaviour, but some bug is still there. What can I do to provide
> useful debugging information?
> 
> Following is the output of the oom killer.

I'm not sure, but this sounds a bit similar to a problem I am seeing. Are 
you by any chance using the CFQ scheduler?! (elevator=cfq) If so, give 
elevator=as or elevator=deadline a go.

The problem I'm seeing is that processes that allocate large amounts of 
memory, are OOM killed or cause swap storms.

-- http://thread.gmane.org/gmane.linux.kernel/228156



