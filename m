Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932463AbVLPVeP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932463AbVLPVeP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 16:34:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932462AbVLPVeP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 16:34:15 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:716
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S932460AbVLPVeO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 16:34:14 -0500
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Andrew Morton <akpm@osdl.org>,
       linux-arch@vger.kernel.org,
       Linux Kernel Development <linux-kernel@vger.kernel.org>, matthew@wil.cx,
       arjan@infradead.org, Christoph Hellwig <hch@infradead.org>,
       mingo@elte.hu, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       nikita@clusterfs.com, pj@sgi.com, dhowells@redhat.com,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.62.0512152130390.16426@pademelon.sonytel.be>
References: <20051215085602.c98f22ef.pj@sgi.com>
	 <20051213143147.d2a57fb3.pj@sgi.com> <20051213094053.33284360.pj@sgi.com>
	 <dhowells1134431145@warthog.cambridge.redhat.com>
	 <20051212161944.3185a3f9.akpm@osdl.org> <20051213075441.GB6765@elte.hu>
	 <20051213090219.GA27857@infradead.org> <20051213093949.GC26097@elte.hu>
	 <20051213100015.GA32194@elte.hu>
	 <6281.1134498864@warthog.cambridge.redhat.com>
	 <14242.1134558772@warthog.cambridge.redhat.com>
	 <16315.1134563707@warthog.cambridge.redhat.com>
	 <1134568731.4275.4.camel@tglx.tec.linutronix.de> <43A0AD54.6050109@rtr.ca>
	 <20051214155432.320f2950.akpm@osdl.org>
	 <17313.29296.170999.539035@gargle.gargle.HOWL>
	 <1134658579.12421.59.camel@localhost.localdomain>
	 <4743.1134662116@warthog.cambridge.redhat.com>
	 <7140.1134667736@warthog.cambridge.redhat.com>
	 <Pine.LNX.4.64.0512150945410.3292@g5.osdl.org>
	 <20051215112115.7c4bfbea.akpm@osdl.org>
	 <1134678532.13138.44.camel@localhost.localdomain>
	 <Pine.LNX.4.62.0512152130390.16426@pademelon.sonytel.be>
Content-Type: text/plain
Organization: linutronix
Date: Fri, 16 Dec 2005 22:41:09 +0100
Message-Id: <1134769269.2806.17.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-12-15 at 21:32 +0100, Geert Uytterhoeven wrote:
> > Why have the "MUTEX" part in there?  Shouldn't that just be DECLARE_SEM
> > (oops, I mean DEFINE_SEM).  Especially that MUTEX_LOCKED! What is that?
> > How does a MUTEX start off as locked.  It can't, since a mutex must
> > always have an owner (which, by the way, helped us in the -rt patch to
> > find our "compat_semaphores").  So who's the owner of a
> > DEFINE_SEM_MUTEX_LOCKED?
> 
> No one. It's not really a mutex, but a completion.

Well, then let us use a completion and not some semantically wrong
workaround

	tglx


