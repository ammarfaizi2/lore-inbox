Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751173AbWJRGEB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751173AbWJRGEB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 02:04:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751429AbWJRGEB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 02:04:01 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:58059 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751173AbWJRGEA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 02:04:00 -0400
Date: Wed, 18 Oct 2006 07:55:42 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix generic WARN_ON message
Message-ID: <20061018055542.GA14784@elte.hu>
References: <4535902E.1000608@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4535902E.1000608@goop.org>
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


* Jeremy Fitzhardinge <jeremy@goop.org> wrote:

> A warning is a warning, not a BUG.

> -		printk("BUG: warning at %s:%d/%s()\n", __FILE__,	\
> +		printk("WARNING at %s:%d %s()\n", __FILE__,	\

i'm not really happy about this change.

Firstly, most WARN_ON()s are /bugs/, not warnings ... If it's a real 
warning, a KERN_INFO printk should be done.

Secondly, the reason i changed it to the 'BUG: ...' format is that i 
tried to make it easier for automated tools (and for users) to figure 
out that a kernel bug happened.

	Ingo
