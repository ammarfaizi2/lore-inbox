Return-Path: <linux-kernel-owner+w=401wt.eu-S932701AbWLZQ2t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932701AbWLZQ2t (ORCPT <rfc822;w@1wt.eu>);
	Tue, 26 Dec 2006 11:28:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932707AbWLZQ2t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Dec 2006 11:28:49 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:36535 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932701AbWLZQ2t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Dec 2006 11:28:49 -0500
Date: Tue, 26 Dec 2006 17:26:16 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Andrew Morton <akpm@osdl.org>, Florin Iucha <florin@iucha.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.20-rc2
Message-ID: <20061226162616.GA6756@elte.hu>
References: <20061225224047.GB6087@iucha.net> <20061225225616.GA22307@iucha.net> <20061226022538.13ea8b3f.akpm@osdl.org> <20061226124019.GA3701@elte.hu> <20061226073610.1b86a7cc.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061226073610.1b86a7cc.randy.dunlap@oracle.com>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -5.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-5.9 required=5.9 tests=ALL_TRUSTED,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0002]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Randy Dunlap <randy.dunlap@oracle.com> wrote:

> I've had at least one more occurrence of it:
> 
> [   78.804940] BUG: scheduling while atomic: kbd/0x20000000/3444
> [   78.804944] 
> [   78.804945] Call Trace:

ok, i can think of a simpler scenario: add_preempt_count(PREEMPT_ACTIVE) 
/twice/, nested into each other.

	Ingo
