Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932555AbVLMKA7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932555AbVLMKA7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 05:00:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932549AbVLMKA7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 05:00:59 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:56246 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932523AbVLMKA6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 05:00:58 -0500
Date: Tue, 13 Dec 2005 11:00:15 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       David Howells <dhowells@redhat.com>, torvalds@osdl.org,
       arjan@infradead.org, matthew@wil.cx, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
Message-ID: <20051213100015.GA32194@elte.hu>
References: <dhowells1134431145@warthog.cambridge.redhat.com> <20051212161944.3185a3f9.akpm@osdl.org> <20051213075441.GB6765@elte.hu> <20051213090219.GA27857@infradead.org> <20051213093949.GC26097@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051213093949.GC26097@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> > On Tue, Dec 13, 2005 at 08:54:41AM +0100, Ingo Molnar wrote:
> > > - i did not touch the 'struct semaphore' namespace, but introduced a
> > >   'struct compat_semaphore'.
> > 
> > Because it's totally braindead.  Your compat_semaphore is a real 
> > semaphore and your semaphore is a mutex.  So name them as such.
> 
> well, i had the choice between a 30K patch, a 300K patch and a 3000K 
> patch. I went for the 30K patch ;-)

in that sense i'm all for going for the 300K patch, which is roughly the 
direction David is heading into: rename to 'struct mutex' but keep the 
down/up APIs, and introduce sem_down()/sem_up()/ for the cases that need 
full semaphores.

i dont think the 3000K patch (full API rename, introduction of 
mutex_down()/mutex_up()) is realistic.

	Ingo
