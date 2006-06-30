Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932418AbWF3Jyv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932418AbWF3Jyv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 05:54:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932420AbWF3Jyv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 05:54:51 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:16341 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932418AbWF3Jyt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 05:54:49 -0400
Date: Fri, 30 Jun 2006 11:50:00 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Dave Jones <davej@redhat.com>,
       Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: 2.6.17-mm4
Message-ID: <20060630095000.GB14603@elte.hu>
References: <20060629013643.4b47e8bd.akpm@osdl.org> <6bffcb0e0606291339s69a16bc5ie108c0b8d4e29ed6@mail.gmail.com> <20060629204330.GC13619@redhat.com> <20060629210950.GA300@elte.hu> <20060629230517.GA18838@elte.hu> <1151662073.31392.4.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1151662073.31392.4.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -3.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> Ar Gwe, 2006-06-30 am 01:05 +0200, ysgrifennodd Ingo Molnar:
> > it does things like:
> > 
> >         static const unsigned long qd_port[2] = { 0x30, 0xB0 };
> >         static const unsigned long ide_port[2] = { 0x170, 0x1F0 };
> > 
> >         [...]
> >                 unsigned long port = qd_port[i];
> >         [...]
> >                         r = inb_p(port);
> >                         outb_p(0x19, port);
> >                         res = inb_p(port);
> >                         outb_p(r, port);
> > 
> > so it reads/writes port 0x30 and 0xb0. Are those used by something else 
> > on modern hardware?
> 
> Not especially. Perhaps the best thing to do here would be to make qdi 
> compiled into the kernel (as opposed to modular) only do so if 
> "probe_qdi=1" or similar is set.

ok. Is that the standard way of dealing with potentially intrusive 
probes?

	Ingo
