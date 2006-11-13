Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932793AbWKMTJx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932793AbWKMTJx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 14:09:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755338AbWKMTJx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 14:09:53 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:2475 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1755333AbWKMTJw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 14:09:52 -0500
Date: Mon, 13 Nov 2006 20:08:57 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andi Kleen <ak@suse.de>
Cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ashok.raj@intel.com
Subject: Re: [patch] genapic: optimize & fix APIC mode setup
Message-ID: <20061113190857.GA29904@elte.hu>
References: <20061111151414.GA32507@elte.hu> <200611131529.46464.ak@suse.de> <20061113150415.GA20321@elte.hu> <200611131710.13285.ak@suse.de> <20061113163216.GA3480@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061113163216.GA3480@elte.hu>
User-Agent: Mutt/1.4.2.2i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> [...] If something is cheap then other costs added to (such as 
> cpu-mask scanning, and passing around the cpumask) definitely do 
> matter.

btw., i dont claim this is a big issue - we could solve this for the 
common case even in physical delivery mode by adding a 'single IPI 
delivery' callback to the genapic methods. That could be used by the 
reschedule IPI for example.

	Ingo
