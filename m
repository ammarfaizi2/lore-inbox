Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262313AbVCPKKI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262313AbVCPKKI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 05:10:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262323AbVCPKKI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 05:10:08 -0500
Received: from mx1.elte.hu ([157.181.1.137]:40876 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262313AbVCPKJ6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 05:09:58 -0500
Date: Wed, 16 Mar 2005 11:09:14 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Frank Rowand <frowand@mvista.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] ppc RT: Realtime preempt support for PPC
Message-ID: <20050316100914.GA16012@elte.hu>
References: <422CCC1D.1050902@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <422CCC1D.1050902@mvista.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hi Frank - sorry about the late reply, was busy with other things. Your
ppc patches look mostly mergeable, with some small details still open:

* Frank Rowand <frowand@mvista.com> wrote:

> The patches are:
> 
>  1/5 ppc_rt.patch          - the core realtime functionality for PPC

what is the rationale behind the rt_lock.h changes? The #ifdef
CONFIG_PPC32 changes in generic code are not really acceptable, the -RT
tree tries to keep a single spinlock definition and debugging
primitives, across all architectures.

to drive things forward, i've applied the first 3 patches (except the
rt_lock.h chunk from the first patch), and released it as part of the
40-03 patch:

  http://redhat.com/~mingo/realtime-preempt/

so that you can send followup patches based on this. Patches #4 and #5
are routed via the upstream PPC tree, so -RT should not carry them,
right?

	Ingo
