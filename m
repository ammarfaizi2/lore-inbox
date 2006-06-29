Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750755AbWF2O3Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750755AbWF2O3Z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 10:29:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750756AbWF2O3Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 10:29:25 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:31175 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750755AbWF2O3Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 10:29:24 -0400
Date: Thu, 29 Jun 2006 16:24:42 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Dipankar Sarma <dipankar@in.ibm.com>
Cc: linux-kernel@vger.kernel.org,
       Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
       Prasanna Panchamukhi <prasanna@in.ibm.com>
Subject: Re: [PATCH] 2.6.17-rt1 : fix x86_64 oops
Message-ID: <20060629142442.GA11546@elte.hu>
References: <20060627200105.GA13966@in.ibm.com> <20060628182137.GA23979@in.ibm.com> <20060628193256.GA4392@elte.hu> <20060628200247.GA7932@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060628200247.GA7932@in.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -3.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Dipankar Sarma <dipankar@in.ibm.com> wrote:

> OK, I need to catch up, but I see a lot of oops while running 
> rcutorture in my box (rt1). I am investigating this atm.

fyi, 2.6.17-mm4 throws tons of these:

 BUG: scheduling while atomic: rcu_torture_rea/0x00010000/1471
  [<c0106123>] show_trace+0xd/0x10
  [<c010613d>] dump_stack+0x17/0x1a
  [<c123b4e2>] schedule+0x61/0xc61
  [<c015f380>] rcu_torture_reader+0x12e/0x17e
  [<c014101f>] kthread+0xc4/0xf0
  [<c0102005>] kernel_thread_helper+0x5/0xb

	Ingo
