Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751300AbWF2XcW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751300AbWF2XcW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 19:32:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751306AbWF2XcW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 19:32:22 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:35726 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751300AbWF2XcV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 19:32:21 -0400
Date: Fri, 30 Jun 2006 01:27:39 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-mm4
Message-ID: <20060629232739.GA28306@elte.hu>
References: <20060629013643.4b47e8bd.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060629013643.4b47e8bd.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.1 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5001]
	0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> +profile-likely-unlikely-macros.patch

CONFIG_PROFILE_LIKELY doesnt quite work:

 Low memory ends at vaddr f7e00000
 node 0 will remap to vaddr f7e00000 - f8000000
 High memory starts at vaddr f7e00000
 found SMP MP-table at 000f5680
 NX (Execute Disable) protection: active
 Unknown interrupt or fault at EIP 00000060 c1d9f264 00000002
 Unknown interrupt or fault at EIP 00000060 c0100295 0000f264
 Unknown interrupt or fault at EIP 00000060 c0100295 00000294
 Unknown interrupt or fault at EIP 00000060 c0100295 00000294
 Unknown interrupt or fault at EIP 00000060 c0100295 00000294
 Unknown interrupt or fault at EIP 00000060 c0100295 00000294

disabling it makes these go away.

	Ingo
