Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030284AbWGFQOF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030284AbWGFQOF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 12:14:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030303AbWGFQOF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 12:14:05 -0400
Received: from smtp.osdl.org ([65.172.181.4]:15005 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030284AbWGFQOE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 12:14:04 -0400
Date: Thu, 6 Jul 2006 09:13:54 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, arjan@infradead.org
Subject: Re: [patch] spinlocks: remove 'volatile'
In-Reply-To: <Pine.LNX.4.64.0607060856080.12404@g5.osdl.org>
Message-ID: <Pine.LNX.4.64.0607060911530.12404@g5.osdl.org>
References: <20060705114630.GA3134@elte.hu> <20060705101059.66a762bf.akpm@osdl.org>
 <20060705193551.GA13070@elte.hu> <20060705131824.52fa20ec.akpm@osdl.org>
 <Pine.LNX.4.64.0607051332430.12404@g5.osdl.org> <20060705204727.GA16615@elte.hu>
 <Pine.LNX.4.64.0607051411460.12404@g5.osdl.org> <20060705214502.GA27597@elte.hu>
 <Pine.LNX.4.64.0607051458200.12404@g5.osdl.org> <Pine.LNX.4.64.0607051555140.12404@g5.osdl.org>
 <20060706081639.GA24179@elte.hu> <Pine.LNX.4.61.0607060756050.8312@chaos.analogic.com>
 <Pine.LNX.4.64.0607060856080.12404@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 6 Jul 2006, Linus Torvalds wrote:
> 
> Any other use of "volatile" is almost certainly a bug, or just useless. 

Side note: it's also totally possible that a volatiles _hides_ a bug, ie 
removing the volatile ends up having bad effects, but that's because the 
software itself isn't actually following the rules (or, more commonly, the 
rules are broken, and somebody added "volatile" to hide the problem).

That's not just a theoretical notion, btw. We had _tons_ of these kinds of 
"volatile"s in the original old networking code. They were _all_ wrong. 
Every single one.

			Linus
