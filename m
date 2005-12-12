Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751215AbVLLKhE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751215AbVLLKhE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 05:37:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751216AbVLLKhE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 05:37:04 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:12979 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751215AbVLLKhB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 05:37:01 -0500
Date: Mon, 12 Dec 2005 11:36:11 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Scott Garfinkle <scotteglist@gmail.com>
Cc: linux-kernel@vger.kernel.org, Matt Mackall <mpm@selenic.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 7/15] misc: Make x86 doublefault handling optional
Message-ID: <20051212103611.GA6416@elte.hu>
References: <8.282480653@selenic.com> <200511160713.07632.rob@landley.net> <20051116182145.GP31287@waste.org> <f1079b100511161121g1997cfb4jc8e8aec5072c1d92@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1079b100511161121g1997cfb4jc8e8aec5072c1d92@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Scott Garfinkle <scotteglist@gmail.com> wrote:

> I tend to agree with the spirit of Andi's comment -- disabling this 
> will (I think) make the rare time when it happens into something 
> impossible to debug without a new kernel and reproducing the problem.

in the past couple of years i saw double-faults at a rate of perhaps 
once a year - and i frequently hack lowlevel glue code! So the 
usefulness of this code in the field, and especially on an embedded 
platforms, is extremely limited.

in fact, i've experienced triple-faults (== spontaneous reboots) to be 
at least 10 times more frequent than double-faults! I.e. _if_ your 
kernel (or hardware) is screwed up to the degree that it would 
double-fault, it will much more likely also triple-fault.

IIRC we added the double-fault handler to debug the PAE code originally.  
Now years down the road, making it configurable-out if EMBEDDED makes 
lots of sense.

	Ingo
