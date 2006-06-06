Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932195AbWFFOnN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932195AbWFFOnN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 10:43:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932196AbWFFOnM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 10:43:12 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:4582 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932195AbWFFOnM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 10:43:12 -0400
Date: Tue, 6 Jun 2006 16:42:42 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: genirq
Message-ID: <20060606144242.GB29798@elte.hu>
References: <20060604135011.decdc7c9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060604135011.decdc7c9.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5034]
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> genirq-rename-desc-handler-to-desc-chip.patch
> genirq-rename-desc-handler-to-desc-chip-power-fix.patch
> genirq-rename-desc-handler-to-desc-chip-ia64-fix.patch
> genirq-rename-desc-handler-to-desc-chip-ia64-fix-2.patch
> genirq-sem2mutex-probe_sem-probing_active.patch
> genirq-cleanup-merge-irq_affinity-into-irq_desc.patch
> genirq-cleanup-remove-irq_descp.patch
> genirq-cleanup-remove-irq_descp-fix.patch
> genirq-cleanup-remove-fastcall.patch
> genirq-cleanup-misc-code-cleanups.patch
> genirq-cleanup-reduce-irq_desc_t-use-mark-it-obsolete.patch
> genirq-cleanup-include-linux-irqh.patch
> genirq-cleanup-merge-irq_dir-smp_affinity_entry-into-irq_desc.patch
> genirq-cleanup-merge-pending_irq_cpumask-into-irq_desc.patch
> genirq-cleanup-turn-arch_has_irq_per_cpu-into-config_irq_per_cpu.patch
> genirq-debug-better-debug-printout-in-enable_irq.patch
> genirq-add-retrigger-irq-op-to-consolidate-hw_irq_resend.patch
> genirq-doc-comment-include-linux-irqh-structures.patch
> genirq-doc-handle_irq_event-and-__do_irq-comments.patch
> genirq-cleanup-no_irq_type-cleanups.patch
> genirq-doc-add-design-documentation.patch
> genirq-add-genirq-sw-irq-retrigger.patch
> genirq-add-irq_noprobe-support.patch
> genirq-add-irq_norequest-support.patch
> genirq-add-irq_noautoen-support.patch
> genirq-update-copyrights.patch
> genirq-core.patch
> genirq-msi-fixes-2.patch
> genirq-add-irq-chip-support.patch
> genirq-add-irq-chip-support-fix.patch
> genirq-add-handle_bad_irq.patch
> genirq-add-irq-wake-power-management-support.patch
> genirq-add-sa_trigger-support.patch
> genirq-cleanup-no_irq_type-no_irq_chip-rename.patch
> genirq-convert-the-x86_64-architecture-to-irq-chips.patch
> genirq-convert-the-i386-architecture-to-irq-chips.patch
> genirq-convert-the-i386-architecture-to-irq-chips-fix-2.patch
> genirq-more-verbose-debugging-on-unexpected-irq-vectors.patch
> genirq-add-chip-eoi-fastack-fasteoi.patch
> genirq-add-chip-eoi-fastack-fasteoi-fix.patch
> 
>  Still stabilising.  It's looking more like 2.6.19 material.  Needs 
>  more review from arch maintainers too.

there hasnt been any real problem since the MSI one. The core bits are 
rather stable. The patch-queue had positive input from the maintainers 
of the two architectures with the most complex IRQ hardware (arm and 
ppc*), and that's reassuring. But in any case, other architectures are 
not affected at all (sans brow paperbag build bugs and typos), their 
__do_IRQ() handling remains unchanged. So i'd like to see this in 
2.6.18. (there a good deal of stuff we have ontop of genirq)

(the irqpoll discussions are unrelated to genirq - they are fixes for an 
irqpoll problem that the lock validator uncovered, and naturally those 
patches were ontop of genirq.)

	Ingo
