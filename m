Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750750AbWGFTdO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750750AbWGFTdO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 15:33:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750752AbWGFTdO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 15:33:14 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:8656 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1750750AbWGFTdO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 15:33:14 -0400
Date: Thu, 6 Jul 2006 21:32:38 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Linus Torvalds <torvalds@osdl.org>
cc: "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, arjan@infradead.org
Subject: Re: [patch] spinlocks: remove 'volatile'
In-Reply-To: <Pine.LNX.4.64.0607060911530.12404@g5.osdl.org>
Message-ID: <Pine.LNX.4.61.0607062132150.2809@yvahk01.tjqt.qr>
References: <20060705114630.GA3134@elte.hu> <20060705101059.66a762bf.akpm@osdl.org>
 <20060705193551.GA13070@elte.hu> <20060705131824.52fa20ec.akpm@osdl.org>
 <Pine.LNX.4.64.0607051332430.12404@g5.osdl.org> <20060705204727.GA16615@elte.hu>
 <Pine.LNX.4.64.0607051411460.12404@g5.osdl.org> <20060705214502.GA27597@elte.hu>
 <Pine.LNX.4.64.0607051458200.12404@g5.osdl.org> <Pine.LNX.4.64.0607051555140.12404@g5.osdl.org>
 <20060706081639.GA24179@elte.hu> <Pine.LNX.4.61.0607060756050.8312@chaos.analogic.com>
 <Pine.LNX.4.64.0607060856080.12404@g5.osdl.org> <Pine.LNX.4.64.0607060911530.12404@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Any other use of "volatile" is almost certainly a bug, or just useless. 
>
>That's not just a theoretical notion, btw. We had _tons_ of these kinds of 
>"volatile"s in the original old networking code. They were _all_ wrong. 
>Every single one.
>

$ find linux-2.6.17 -type f -iname '*.[ch]' -print0 | xargs -0 grep 
volatile | wc -l
13948

Tough job.


Jan Engelhardt
-- 
