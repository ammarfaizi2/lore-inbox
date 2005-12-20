Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751099AbVLTP4y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751099AbVLTP4y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 10:56:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751105AbVLTP4y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 10:56:54 -0500
Received: from bayc1-pasmtp01.bayc1.hotmail.com ([65.54.191.161]:34325 "EHLO
	BAYC1-PASMTP01.bayc1.hotmail.com") by vger.kernel.org with ESMTP
	id S1751099AbVLTP4x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 10:56:53 -0500
Message-ID: <BAYC1-PASMTP01F075F44E45AA32F0DF85AE3E0@CEZ.ICE>
X-Originating-IP: [69.156.6.171]
X-Originating-Email: [seanlkml@sympatico.ca]
Message-ID: <46578.10.10.10.28.1135094132.squirrel@linux1>
In-Reply-To: <170fa0d20512200637l169654c9vbe38c9931c23dfb1@mail.gmail.com>
References: <20051218231401.6ded8de2@werewolf.auna.net> 
    <43A77205.2040306@rtr.ca> <20051220133729.GC6789@stusta.de>
    <170fa0d20512200637l169654c9vbe38c9931c23dfb1@mail.gmail.com>
Date: Tue, 20 Dec 2005 10:55:32 -0500 (EST)
Subject: Re: About 4k kernel stack size....
From: "Sean" <seanlkml@sympatico.ca>
To: "Mike Snitzer" <snitzer@gmail.com>
Cc: "Adrian Bunk" <bunk@stusta.de>, "Mark Lord" <lkml@rtr.ca>,
       "J.A. Magallon" <jamagallon@able.es>,
       "Linux-Kernel," <linux-kernel@vger.kernel.org>, nel@vger.kernel.org,
       mpm@selenic.com
User-Agent: SquirrelMail/1.4.4-2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
X-OriginalArrivalTime: 20 Dec 2005 15:55:33.0430 (UTC) FILETIME=[CF576560:01C6057D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, December 20, 2005 9:37 am, Mike Snitzer said:

> Given this last statement, why is it that Matt Mackall's suggestion in
> the "Light-weight dynamically extended stacks" thread didn't get any
> _real_ discussion from the big 4K stack advocates?  For all intents
> and purposes, Matt was dismissed with the same Bunk: "Ever since
> neilb's patch there are 0 bugs.. blah blah".  4K, 8K (aka "6 kB")
> aside; having more stack safety in the Linux kernel is a "good thing"
> no?  Aren't dynamic stacks a viable means to imposing 4K (but doing so
> with real safety)?

The so called 4K stack patch does add more stack safety.  Avoiding the
possibility of allocation failures due to memory fragmentation.  Besides,
the patch is really misnamed; it should have been called the split-stack
(ie. 4K + 4K).   Since nobody can show any area in the mainline code where
the split stack scheme introduces a problem the old setup should be
removed as it is no longer needed by the mainline code.

I for one hope those silly bastards using ndiswrapper fix up that code to
work with the new kernel so that we can stop hearing all these wannabe
complaints against this progress.

Sean

