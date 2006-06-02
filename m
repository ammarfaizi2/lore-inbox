Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932123AbWFBONc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932123AbWFBONc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 10:13:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932130AbWFBONc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 10:13:32 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:42984 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932123AbWFBONb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 10:13:31 -0400
Date: Fri, 2 Jun 2006 16:13:49 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Paolo Ornati <ornati@fastwebnet.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc5-mm2
Message-ID: <20060602141349.GA8974@elte.hu>
References: <20060601014806.e86b3cc0.akpm@osdl.org> <20060602120952.615cea39@localhost> <20060602111053.GA22306@elte.hu> <20060602111704.GA22841@elte.hu> <20060602133403.4eed2de7@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060602133403.4eed2de7@localhost>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5010]
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Paolo Ornati <ornati@fastwebnet.it> wrote:

> On Fri, 2 Jun 2006 13:17:04 +0200
> Ingo Molnar <mingo@elte.hu> wrote:
> 
> > > please send me the real full config you used for the build - this one 
> > > has only the =y entries. (from which it's hard to reproduce your 
> > > original config)
> > 
> > when running it through 'make oldconfig' and grepping for =y it didnt 
> > match your original config, but the resulting kernel was just as broken 
> > as yours, so it's good enough for now ;-) Below is the crashlog over 
> > serial.
> 
> Anyway, full config attached.

thanks. Your config triggered 4 different bugs! 1 nasty slab.c one and 3 
locking-selftest bugs.

> It's a .17-rc5-mm2 + 2 hot-fixes:
> 	lock-validator-x86_64-irqflags-trace-entrys-fix.patch
> 	revert-git-cfq.patch

please try my latest lockdep-combo patch:

  http://redhat.com/~mingo/lockdep-patches/lockdep-combo-2.6.17-rc5-mm2.patch

ontop of vanilla -mm2. The combo patch includes all current -mm2 
hotfixes plus all current lockdep fixes.

	Ingo
