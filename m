Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932129AbWA0AIg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932129AbWA0AIg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 19:08:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751336AbWA0AIg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 19:08:36 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:51133 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751296AbWA0AIg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 19:08:36 -0500
Date: Fri, 27 Jan 2006 01:08:54 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Cc: nickpiggin@yahoo.com.au, ak@suse.de, linux-kernel@vger.kernel.org,
       rohit.seth@intel.com, asit.k.mallick@intel.com,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [Patch] sched: new sched domain for representing multi-core
Message-ID: <20060127000854.GA16332@elte.hu>
References: <20060126015132.A8521@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060126015132.A8521@unix-os.sc.intel.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.2
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.2 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.6 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


a few minor nits:

* Siddha, Suresh B <suresh.b.siddha@intel.com> wrote:

> +config SCHED_MC
> +	bool "Multi-core scheduler support"
> +	depends on SMP
> +	default off

no need to add 'default off', that's the default.

> -#ifdef CONFIG_SCHED_SMT
> +#if defined(CONFIG_SCHED_SMT)

stale change.

Otherwise, looks pretty clean to me, both the scheduler and the x86_* 
arch level bits! Would be nice to get this tested in -mm too.

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
