Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932065AbVLTTxx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932065AbVLTTxx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 14:53:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932066AbVLTTxw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 14:53:52 -0500
Received: from sccrmhc11.comcast.net ([204.127.202.55]:19943 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S932065AbVLTTxw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 14:53:52 -0500
From: kernel-stuff@comcast.net (Parag Warudkar)
To: David Lang <dlang@digitalinsight.com>
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>,
       Dumitru Ciobarcianu <Dumitru.Ciobarcianu@iNES.RO>,
       Helge Hafting <helge.hafting@aitel.hist.no>, Andi Kleen <ak@suse.de>,
       Adrian Bunk <bunk@stusta.de>, Kyle Moffett <mrmacman_g4@mac.com>,
       akpm@osdl.org, linux-kernel@vger.kernel.org, arjan@infradead.org
Subject: Re: [2.6 patch] i386: always use 4k stacks 
Date: Tue, 20 Dec 2005 19:53:43 +0000
Message-Id: <122020051953.9002.43A861470004E9E70000232A220702095300009A9B9CD3040A029D0A05@comcast.net>
X-Mailer: AT&T Message Center Version 1 (Aug  4 2005)
X-Authenticated-Sender: a2VybmVsLXN0dWZmQGNvbWNhc3QubmV0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> by goig to 4k stacks they are able to be allocated even when memory is 
> badly fragmented, which is not the case while they are 8k.
> 
> David Lang
> 

It's hard to believe all i386 people have a problem with 8K stacks. What you said may be a problem domain bound to a specific workload on i386 with insane amounts of memory and fragmented LOWMEM. - These people can certainly use 4K stacks and no one is preventing that.

But normal people with <=1Gb RAM and using i386 on desktop (I am sure there are many of them) may do OK with 8K stacks if they had a need to do so. (Like running ndiswrapper, or some other thing which requires bigger stacks for that matter.)

Why take away the 8K option which already exists and works for people who need it? Let people choose what suits their needs. Forcing 4K stacks on people and asking them to sacrifice functionality while *gaining nothing* - sure sounds illogical. (You gain from 4K stacks - you have it as default, but technically you gain NOTHING from taking away the 8k option.)

Parag
