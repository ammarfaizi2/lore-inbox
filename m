Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263239AbVCKJlS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263239AbVCKJlS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 04:41:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263248AbVCKJlS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 04:41:18 -0500
Received: from mx1.elte.hu ([157.181.1.137]:52698 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S263239AbVCKJkx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 04:40:53 -0500
Date: Fri, 11 Mar 2005 10:40:24 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, Badari Pulavarty <pbadari@us.ibm.com>,
       dhowells@redhat.com, torvalds@osdl.org, suparna@in.ibm.com,
       linux-aio@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rwsem: Make rwsems use interrupt disabling spinlocks
Message-ID: <20050311094024.GC19954@elte.hu>
References: <20050309032832.159e58a4.akpm@osdl.org> <20050308170107.231a145c.akpm@osdl.org> <1110327267.24286.139.camel@dyn318077bld.beaverton.ibm.com> <18744.1110364438@redhat.com> <20050309110404.GA4088@in.ibm.com> <1110366469.6280.84.camel@laptopd505.fenrus.org> <4175.1110370343@redhat.com> <1110395783.24286.207.camel@dyn318077bld.beaverton.ibm.com> <20050309114234.6598f486.akpm@osdl.org> <1110399036.6280.151.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1110399036.6280.151.camel@laptopd505.fenrus.org>
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


* Arjan van de Ven <arjan@infradead.org> wrote:

> > Ingo, we already have a touch_nmi_watchdog() in the sysrq code.  It might be
> > worth adding a touch_softlockup_watchdog() wherever we have a
> > touch_nmi_watchdog().
> 
> ....or add touch_softlockup_watchdog to touch_nmi_watchdog() instead
> and rename it tickle_watchdog() overtime.

you mean like:

+extern void touch_softlockup_watchdog(void);

in:

 http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11/2.6.11-mm2/broken-out/detect-soft-lockups.patch

?

	Ingo
