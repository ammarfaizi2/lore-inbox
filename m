Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935708AbWK1Iof@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935708AbWK1Iof (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 03:44:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935696AbWK1Ims
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 03:42:48 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:38331 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S935698AbWK1ImW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 03:42:22 -0500
Date: Mon, 27 Nov 2006 13:36:06 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Avi Kivity <avi@qumranet.com>
Cc: kvm-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [PATCH 1/38] KVM: Create kvm-intel.ko module
Message-ID: <20061127123606.GA11825@elte.hu>
References: <456AD5C6.1090406@qumranet.com> <20061127121136.DC69A25015E@cleopatra.q>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061127121136.DC69A25015E@cleopatra.q>
User-Agent: Mutt/1.4.2.2i
X-ELTE-SpamScore: -4.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-4.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_00,DATE_IN_PAST_12_24 autolearn=no SpamAssassin version=3.0.3
	0.7 DATE_IN_PAST_12_24     Date: is 12 to 24 hours before Received: date
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
	1.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Avi Kivity <avi@qumranet.com> wrote:

> --- linux-2.6.orig/drivers/kvm/kvm.h
> +++ linux-2.6/drivers/kvm/kvm.h

please move this from drivers/kvm/ to kernel/kvm/ [or even into a 
toplevel kvm/ directory] - KVM is not a "driver", KVM enhances the core 
Linux kernel with hypervisor functionality.

Guest paravirtualization drivers (once KVM implements them) can go into 
drivers/kvm/.

	Ingo
