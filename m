Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932435AbVLNMfh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932435AbVLNMfh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 07:35:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932418AbVLNMfh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 07:35:37 -0500
Received: from mx1.redhat.com ([66.187.233.31]:30889 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932406AbVLNMfg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 07:35:36 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1134559121.25663.14.camel@localhost.localdomain> 
References: <1134559121.25663.14.camel@localhost.localdomain>  <13820.1134558138@warthog.cambridge.redhat.com> <20051213143147.d2a57fb3.pj@sgi.com> <20051213094053.33284360.pj@sgi.com> <dhowells1134431145@warthog.cambridge.redhat.com> <20051212161944.3185a3f9.akpm@osdl.org> <20051213075441.GB6765@elte.hu> <20051213090219.GA27857@infradead.org> <20051213093949.GC26097@elte.hu> <20051213100015.GA32194@elte.hu> <6281.1134498864@warthog.cambridge.redhat.com> <14242.1134558772@warthog.cambridge.redhat.com> 
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: David Howells <dhowells@redhat.com>, Paul Jackson <pj@sgi.com>,
       mingo@elte.hu, hch@infradead.org, akpm@osdl.org, torvalds@osdl.org,
       arjan@infradead.org, matthew@wil.cx, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation 
X-Mailer: MH-E 7.84; nmh 1.1; GNU Emacs 22.0.50.1
Date: Wed, 14 Dec 2005 12:35:07 +0000
Message-ID: <16315.1134563707@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> Why bother. As has already been discussed up and down are the natural
> and normal names for counting semaphores. You don't need to obsolete the
> old API thats just silly, you need to add a new one and wait for people
> to use it.

The vast majority of ups and downs are actually mutex related not semaphore
related, so by majority share, up/down perhaps ought to be repurposed to
mutexes: they _are_ the preeminent uses.

>From my modified tree, I see:

	semaphore	up	down	down_in	down_try
	Counting	41	59	1	0
	Mutex		4405	2824	362	107

> The old API is still very useful for some applications that want
> counting semaphores.

Whilst that is true, they're in a small minority, and it'd be easier to change
them.

David
