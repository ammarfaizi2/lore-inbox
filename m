Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750864AbVLOTWP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750864AbVLOTWP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 14:22:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750857AbVLOTWP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 14:22:15 -0500
Received: from smtp.osdl.org ([65.172.181.4]:44228 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750843AbVLOTWO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 14:22:14 -0500
Date: Thu, 15 Dec 2005 11:21:15 -0800
From: Andrew Morton <akpm@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: dhowells@redhat.com, pj@sgi.com, nikita@clusterfs.com,
       alan@lxorguk.ukuu.org.uk, tglx@linutronix.de, mingo@elte.hu,
       hch@infradead.org, arjan@infradead.org, matthew@wil.cx,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
Message-Id: <20051215112115.7c4bfbea.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0512150945410.3292@g5.osdl.org>
References: <20051215085602.c98f22ef.pj@sgi.com>
	<1134559121.25663.14.camel@localhost.localdomain>
	<13820.1134558138@warthog.cambridge.redhat.com>
	<20051213143147.d2a57fb3.pj@sgi.com>
	<20051213094053.33284360.pj@sgi.com>
	<dhowells1134431145@warthog.cambridge.redhat.com>
	<20051212161944.3185a3f9.akpm@osdl.org>
	<20051213075441.GB6765@elte.hu>
	<20051213090219.GA27857@infradead.org>
	<20051213093949.GC26097@elte.hu>
	<20051213100015.GA32194@elte.hu>
	<6281.1134498864@warthog.cambridge.redhat.com>
	<14242.1134558772@warthog.cambridge.redhat.com>
	<16315.1134563707@warthog.cambridge.redhat.com>
	<1134568731.4275.4.camel@tglx.tec.linutronix.de>
	<43A0AD54.6050109@rtr.ca>
	<20051214155432.320f2950.akpm@osdl.org>
	<17313.29296.170999.539035@gargle.gargle.HOWL>
	<1134658579.12421.59.camel@localhost.localdomain>
	<4743.1134662116@warthog.cambridge.redhat.com>
	<7140.1134667736@warthog.cambridge.redhat.com>
	<Pine.LNX.4.64.0512150945410.3292@g5.osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:
>
> On Thu, 15 Dec 2005, David Howells wrote:
>  > 
>  > 	FROM				TO
>  > 	==============================	=========================
>  > 	DECLARE_MUTEX			DECLARE_SEM_MUTEX
>  > 	DECLARE_MUTEX_LOCKED		DECLARE_SEM_MUTEX_LOCKED
>  > 	Proper counting semaphore	DECLARE_SEM
> 
>  That sounds fine.

They should be renamed to DEFINE_* while we're there.  A "declaration" is
"this thing is defined somewhere else".  A "definition" is "this thing is
defined here".

> I wouldn't be adverse to doing that

argh.
