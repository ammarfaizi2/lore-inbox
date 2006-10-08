Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750901AbWJHTBt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750901AbWJHTBt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 15:01:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751342AbWJHTBt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 15:01:49 -0400
Received: from mtagate5.uk.ibm.com ([195.212.29.138]:11894 "EHLO
	mtagate5.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1750901AbWJHTBs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 15:01:48 -0400
Date: Sun, 8 Oct 2006 21:01:44 +0200
From: Muli Ben-Yehuda <muli@il.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>, Andi Kleen <ak@muc.de>,
       "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       Andrew Morton <akpm@osdl.org>,
       Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] x86_64 irq: Allocate a vector across all cpus for genapic_flat.
Message-ID: <20061008190144.GQ14186@rhun.haifa.ibm.com>
References: <m1d5951gm7.fsf@ebiederm.dsl.xmission.com> <20061006202324.GJ14186@rhun.haifa.ibm.com> <m1y7rtxb7z.fsf@ebiederm.dsl.xmission.com> <20061007080315.GM14186@rhun.haifa.ibm.com> <m14pugxe47.fsf@ebiederm.dsl.xmission.com> <20061007175926.GN14186@rhun.haifa.ibm.com> <m1k63budt1.fsf_-_@ebiederm.dsl.xmission.com> <m1fydzudq8.fsf_-_@ebiederm.dsl.xmission.com> <m1bqomvs6l.fsf_-_@ebiederm.dsl.xmission.com> <m17izavrzo.fsf_-_@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m17izavrzo.fsf_-_@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 08, 2006 at 07:47:55AM -0600, Eric W. Biederman wrote:

> This should also fix the problem report where a hyperthreaded
> cpu was receving the irq on the wrong hyperthread when in
> logical delivery mode because the previous behaviour is restored.
> 
> This patch properly records our allocation of the first 16 irqs
> to the first 16 available vectors on all cpus.  This should be
> fine but it may run into problems with multiple interrupts at
> the same interrupt level.  Except for some badly maintained comments
> in the code and the behaviour of the interrupt allocator I have
> no real understanding of that problem.
> 
> Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>

Acked-by: Muli Ben-Yehuda <muli@il.ibm.com>

Cheers,
Muli
