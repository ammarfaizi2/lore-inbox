Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261815AbVASRvV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261815AbVASRvV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 12:51:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261794AbVASRtA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 12:49:00 -0500
Received: from mx1.elte.hu ([157.181.1.137]:15054 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261802AbVASRr2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 12:47:28 -0500
Date: Wed, 19 Jan 2005 18:47:09 +0100
From: Ingo Molnar <mingo@elte.hu>
To: John Richard Moser <nigelenki@comcast.net>
Cc: Linus Torvalds <torvalds@osdl.org>, Arjan van de Ven <arjan@infradead.org>,
       Christoph Hellwig <hch@infradead.org>, Dave Jones <davej@redhat.com>,
       Andrew Morton <akpm@osdl.org>, marcelo.tosatti@cyclades.com,
       Greg KH <greg@kroah.com>, chrisw@osdl.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: thoughts on kernel security issues
Message-ID: <20050119174709.GA19520@elte.hu>
References: <20050112182838.2aa7eec2.akpm@osdl.org> <20050113033542.GC1212@redhat.com> <Pine.LNX.4.58.0501122025140.2310@ppc970.osdl.org> <20050113082320.GB18685@infradead.org> <Pine.LNX.4.58.0501130822280.2310@ppc970.osdl.org> <1105635662.6031.35.camel@laptopd505.fenrus.org> <Pine.LNX.4.58.0501130909270.2310@ppc970.osdl.org> <41E6BE6B.6050400@comcast.net> <20050119103020.GA4417@elte.hu> <41EE96E7.3000004@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41EE96E7.3000004@comcast.net>
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


* John Richard Moser <nigelenki@comcast.net> wrote:

> Split-out portions of PaX (and of ES) don't make sense. [...]

which shows that you dont know the exec-shield patch at all, nor those
split-out portions. At which point it becomes pretty pointless to 
discuss any technical details, dont you think?

> PT_GNU_STACK annoys me :P  I'm more interested in 1) PaX' full set of
> markings (-ps for NX, -m for mprotect(), r for randmmap, x for
> randexec), [...]
>
> I guess it works on Exec Shield, but it frightens me that I have to
> audit every library an executable uses for a PT_GNU_STACK marking to
> see if it has an executable stack.

here there are two misconceptions:

1) you claim that the manual setting of markings is better than the
_automatic_ setting of markings in Fedora. Manual setting is a support
and maintainance nightmare, there can be false positives and false
negatives as well. Also, manual setting of markings assumes code review
or 'does this application break' type of feedback - neither is as
reliable as automatic detection done by the compiler.

2) you claim that you have to audit everything. You dont have to. It's
all automatic. _Fedora developers_ (not you) then check the markings and
reduce the number of executable stacks as much as possible.

> [...] ES' NX approximation fails if you relieve protections on a
> higher mapping-- which confuses me, isn't vsyscall() a high-address
> executable mapping, which would disable NX protection for the full
> address space?

another misconception. Read the patch and you'll see how it's solved. 

> Aside from that, I just trust the PaX developer more.  He's already
> got a more developed product; he's a security developer instead of a
> scheduler developer; and he reads CPU manuals for breakfast. 

this is your choice, and i respect it. Please show the same amount of
respect for the choice of others as well, without badmouthing anything
just because their choice is different from yours.

	Ingo
