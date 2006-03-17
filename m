Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751049AbWCQUeS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751049AbWCQUeS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 15:34:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751347AbWCQUeS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 15:34:18 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:45964 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751049AbWCQUeR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 15:34:17 -0500
Date: Fri, 17 Mar 2006 21:31:49 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "K.R. Foley" <kr@cybsft.com>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>, Esben Nielsen <simlo@phys.au.dk>,
       Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       Jan Altenberg <tb10alj@tglx.de>,
       Sastien Dugu <sebastien.dugue@bull.net>
Subject: Re: 2.6.16-rc6-rt3
Message-ID: <20060317203149.GA23069@elte.hu>
References: <20060314084658.GA28947@elte.hu> <4416C6DD.80209@cybsft.com> <20060314142458.GA21796@elte.hu> <4416F14E.1040708@cybsft.com> <20060317092351.GA18491@elte.hu> <441AE417.1030601@cybsft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <441AE417.1030601@cybsft.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.6
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.6 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.7 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* K.R. Foley <kr@cybsft.com> wrote:

> OK. Tried rt9 with a clean build and still no joy. I've attached the 
> log which looks like it could be a similar problem?

seems to be a different one:

> input: ImPS/2 Generic Wheel Mouse as /class/input/input1
> Freeing unused kernel memory: 284k freed
> Could not allocate 8 bytes percpu data
> sd_mod: Unknown symbol scsi_print_sense_hdr

could you increase PERCPU_ENOUGH_ROOM in include/linux/percpu.h? (to 
e.g. 65536)

	Ingo
