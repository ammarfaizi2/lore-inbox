Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750828AbVLOR3V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750828AbVLOR3V (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 12:29:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750826AbVLOR3V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 12:29:21 -0500
Received: from mx1.redhat.com ([66.187.233.31]:41622 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750825AbVLOR3U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 12:29:20 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20051215085602.c98f22ef.pj@sgi.com> 
References: <20051215085602.c98f22ef.pj@sgi.com>  <17313.37200.728099.873988@gargle.gargle.HOWL> <1134559121.25663.14.camel@localhost.localdomain> <13820.1134558138@warthog.cambridge.redhat.com> <20051213143147.d2a57fb3.pj@sgi.com> <20051213094053.33284360.pj@sgi.com> <dhowells1134431145@warthog.cambridge.redhat.com> <20051212161944.3185a3f9.akpm@osdl.org> <20051213075441.GB6765@elte.hu> <20051213090219.GA27857@infradead.org> <20051213093949.GC26097@elte.hu> <20051213100015.GA32194@elte.hu> <6281.1134498864@warthog.cambridge.redhat.com> <14242.1134558772@warthog.cambridge.redhat.com> <16315.1134563707@warthog.cambridge.redhat.com> <1134568731.4275.4.camel@tglx.tec.linutronix.de> <43A0AD54.6050109@rtr.ca> <20051214155432.320f2950.akpm@osdl.org> <17313.29296.170999.539035@gargle.gargle.HOWL> <1134658579.12421.59.camel@localhost.localdomain> <4743.1134662116@warthog.cambridge.redhat.com> 
To: Paul Jackson <pj@sgi.com>
Cc: David Howells <dhowells@redhat.com>, nikita@clusterfs.com,
       alan@lxorguk.ukuu.org.uk, akpm@osdl.org, tglx@linutronix.de,
       mingo@elte.hu, hch@infradead.org, torvalds@osdl.org,
       arjan@infradead.org, matthew@wil.cx, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation 
X-Mailer: MH-E 7.84; nmh 1.1; GNU Emacs 22.0.50.1
Date: Thu, 15 Dec 2005 17:28:56 +0000
Message-ID: <7140.1134667736@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson <pj@sgi.com> wrote:

> 
> A phased change of just the renames:
> 	DECLARE_MUTEX ==> DECLARE_SEM
> 	init_MUTEX ==> init_SEM
> 	DECLARE_MUTEX_LOCKED ==> DECLARE_SEM_LOCKED
> 	init_MUTEX_LOCKED ==> init_SEM_LOCKED

I'd prefer:

	FROM				TO
	==============================	=========================
	DECLARE_MUTEX			DECLARE_SEM_MUTEX
	DECLARE_MUTEX_LOCKED		DECLARE_SEM_MUTEX_LOCKED
	Proper counting semaphore	DECLARE_SEM

That way people can show their intent and can be seen more easily when
violating it.

David
