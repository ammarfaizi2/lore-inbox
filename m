Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932537AbVLPWUo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932537AbVLPWUo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 17:20:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932530AbVLPWUo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 17:20:44 -0500
Received: from smtp.osdl.org ([65.172.181.4]:63133 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932529AbVLPWUn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 17:20:43 -0500
Date: Fri, 16 Dec 2005 14:19:58 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Thomas Gleixner <tglx@linutronix.de>
cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       Steven Rostedt <rostedt@goodmis.org>, Andrew Morton <akpm@osdl.org>,
       linux-arch@vger.kernel.org,
       Linux Kernel Development <linux-kernel@vger.kernel.org>, matthew@wil.cx,
       arjan@infradead.org, Christoph Hellwig <hch@infradead.org>,
       mingo@elte.hu, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       nikita@clusterfs.com, pj@sgi.com, dhowells@redhat.com
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
In-Reply-To: <1134770778.2806.31.camel@tglx.tec.linutronix.de>
Message-ID: <Pine.LNX.4.64.0512161414370.3698@g5.osdl.org>
References: <20051215085602.c98f22ef.pj@sgi.com>  <20051213143147.d2a57fb3.pj@sgi.com>
 <20051213093949.GC26097@elte.hu>  <20051213100015.GA32194@elte.hu> 
 <6281.1134498864@warthog.cambridge.redhat.com>  <14242.1134558772@warthog.cambridge.redhat.com>
  <16315.1134563707@warthog.cambridge.redhat.com>  <1134568731.4275.4.camel@tglx.tec.linutronix.de>
 <43A0AD54.6050109@rtr.ca>  <20051214155432.320f2950.akpm@osdl.org> 
 <17313.29296.170999.539035@gargle.gargle.HOWL>  <1134658579.12421.59.camel@localhost.localdomain>
  <4743.1134662116@warthog.cambridge.redhat.com>  <7140.1134667736@warthog.cambridge.redhat.com>
  <Pine.LNX.4.64.0512150945410.3292@g5.osdl.org>  <20051215112115.7c4bfbea.akpm@osdl.org>
  <1134678532.13138.44.camel@localhost.localdomain> 
 <Pine.LNX.4.62.0512152130390.16426@pademelon.sonytel.be> 
 <1134769269.2806.17.camel@tglx.tec.linutronix.de>  <Pine.LNX.4.64.0512161339140.3698@g5.osdl.org>
 <1134770778.2806.31.camel@tglx.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 16 Dec 2005, Thomas Gleixner wrote:
> 
> Well, in case of a semaphore it is a semantically correct use case. In
> case of of a mutex it is not.

I disagree.

Think of "initialization" as a user. The system starts out initializing 
stuff, and as such the mutex should start out being held. It's that 
simple. It _is_ mutual exclusion, with one user being the early bootup 
state.

		Linus
