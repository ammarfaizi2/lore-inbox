Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932519AbVLPVzz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932519AbVLPVzz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 16:55:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932518AbVLPVzz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 16:55:55 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:19404
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S932499AbVLPVzy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 16:55:54 -0500
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Andrew Morton <akpm@osdl.org>
Cc: dhowells@redhat.com, lkml@rtr.ca, alan@lxorguk.ukuu.org.uk, pj@sgi.com,
       mingo@elte.hu, hch@infradead.org, torvalds@osdl.org,
       arjan@infradead.org, matthew@wil.cx, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
In-Reply-To: <20051215121817.2abb0166.akpm@osdl.org>
References: <20051214155432.320f2950.akpm@osdl.org>
	 <1134559121.25663.14.camel@localhost.localdomain>
	 <13820.1134558138@warthog.cambridge.redhat.com>
	 <20051213143147.d2a57fb3.pj@sgi.com> <20051213094053.33284360.pj@sgi.com>
	 <dhowells1134431145@warthog.cambridge.redhat.com>
	 <20051212161944.3185a3f9.akpm@osdl.org> <20051213075441.GB6765@elte.hu>
	 <20051213090219.GA27857@infradead.org> <20051213093949.GC26097@elte.hu>
	 <20051213100015.GA32194@elte.hu>
	 <6281.1134498864@warthog.cambridge.redhat.com>
	 <14242.1134558772@warthog.cambridge.redhat.com>
	 <16315.1134563707@warthog.cambridge.redhat.com>
	 <1134568731.4275.4.camel@tglx.tec.linutronix.de> <43A0AD54.6050109@rtr.ca>
	 <4336.1134661053@warthog.cambridge.redhat.com>
	 <20051215112855.31669dc1.akpm@osdl.org>
	 <20051215121817.2abb0166.akpm@osdl.org>
Content-Type: text/plain
Organization: linutronix
Date: Fri, 16 Dec 2005 23:02:49 +0100
Message-Id: <1134770569.2806.27.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-12-15 at 12:18 -0800, Andrew Morton wrote:

> Look at it from the POV of major architectures: there's no way the new
> mutex code will be faster than down() and up(), so we're adding a bunch of
> new tricky locking code which bloats the kernel and has to be understood
> and debugged for no gain.

Look at it from the semantical POV first, which is the most important
one.

semaphores are semantically different from mutexes, so they require
different APIs.

When you have semantically different APIs, you can still implement them
for whatever (e.g. peformance) reason on top of the same mechanism, but
you can not make this work the other way round.

	tglx
	


