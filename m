Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751099AbWAOEls@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751099AbWAOEls (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 23:41:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751114AbWAOEls
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 23:41:48 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:6572 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751099AbWAOElr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 23:41:47 -0500
Date: Sun, 15 Jan 2006 05:42:05 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Brice Goglin <Brice.Goglin@ens-lyon.org>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.15-mm4
Message-ID: <20060115044205.GA7456@elte.hu>
References: <43C919ED.8070801@ens-lyon.org> <20060115040741.GA23968@elte.hu> <43C9CE62.9070302@ens-lyon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43C9CE62.9070302@ens-lyon.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.1 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.7 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Brice Goglin <Brice.Goglin@ens-lyon.org> wrote:

> >Could you try the patch below?
> 
> Yes, it does fix it. What's the bug ? The mutexes are supposed to work 
> where semaphores do, aren't they ?

no, not always. We could introduce mutex_trylock_irqsafe() and 
mutex_unlock_irqsafe(), but it's probably not worth doing it - it's just 
3-4 cases so far, out of hundreds of mutex conversions.

	Ingo
