Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751090AbWFFU7D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751090AbWFFU7D (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 16:59:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751096AbWFFU7B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 16:59:01 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:36552 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751090AbWFFU7A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 16:59:00 -0400
Date: Tue, 6 Jun 2006 22:58:01 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Laurent Riffard <laurent.riffard@free.fr>
Cc: "Barry K. Nathan" <barryn@pobox.com>, Andrew Morton <akpm@osdl.org>,
       76306.1226@compuserve.com, linux-kernel@vger.kernel.org,
       jbeulich@novell.com, Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: 2.6.17-rc5-mm1
Message-ID: <20060606205801.GC17787@elte.hu>
References: <200606042101_MC3-1-C19B-1CF4@compuserve.com> <20060604181002.57ca89df.akpm@osdl.org> <44840838.7030802@free.fr> <4484584D.4070108@free.fr> <20060605110046.2a7db23f.akpm@osdl.org> <986ed62e0606051452x320cce2ap9598558b5343ae6b@mail.gmail.com> <20060606072628.GA28752@elte.hu> <4485E0D3.8080708@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4485E0D3.8080708@free.fr>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5001]
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Laurent Riffard <laurent.riffard@free.fr> wrote:

> Results:
> - 2.6.17-rc4-mm3 with 4K stack works fine (this is the latest good 4K-kernel).
> - 2.6.17-rc5-mm3 with 4K stack crashes, the stack seems to be corrupted.

that's vanilla mm3, or mm3 patched with extra lockdep patches? If it's 
patched then you should try vanilla mm3 too.

> - 2.6.17-rc5-mm3 with 8K stack works fine.
> - 2.6.17-rc5-mm3-lockdep with 8k stack works fine, although it exhibits high 
> stack usage while running pktsetup.

is the log you sent the highest footprint that my DEBUG_STACKOVERFLOW 
tracer detects?

	Ingo
