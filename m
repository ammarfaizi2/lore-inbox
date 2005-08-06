Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262161AbVHFH6b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262161AbVHFH6b (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Aug 2005 03:58:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261259AbVHFH63
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Aug 2005 03:58:29 -0400
Received: from mx1.elte.hu ([157.181.1.137]:53727 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262356AbVHFH6A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Aug 2005 03:58:00 -0400
Date: Sat, 6 Aug 2005 09:58:27 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Matt Mackall <mpm@selenic.com>, "David S. Miller" <davem@davemloft.net>,
       Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       John B?ckstrand <sandos@home.se>
Subject: Re: [PATCH] netpoll can lock up on low memory.
Message-ID: <20050806075827.GA6735@elte.hu>
References: <20050805135551.GQ8266@wotan.suse.de> <1123251013.18332.28.camel@localhost.localdomain> <20050805141426.GU8266@wotan.suse.de> <1123252591.18332.45.camel@localhost.localdomain> <20050805200156.GF7425@waste.org> <1123275420.18332.81.camel@localhost.localdomain> <20050805212808.GV8074@waste.org> <1123287835.18332.110.camel@localhost.localdomain> <20050806015310.GA8074@waste.org> <1123295548.18332.126.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1123295548.18332.126.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


btw., the current NR_SKBS 32 in netpoll.c seems quite low, especially 
e1000 can have a whole lot more skbs queued at once. Might be more 
robust to increase it to 128 or 256?

	Ingo
