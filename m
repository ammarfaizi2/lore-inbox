Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932471AbVLVMs3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932471AbVLVMs3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 07:48:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932477AbVLVMs3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 07:48:29 -0500
Received: from adsl-69-232-92-238.dsl.sndg02.pacbell.net ([69.232.92.238]:44484
	"EHLO gnuppy.monkey.org") by vger.kernel.org with ESMTP
	id S932471AbVLVMs2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 07:48:28 -0500
Date: Thu, 22 Dec 2005 04:45:13 -0800
To: Linus Torvalds <torvalds@osdl.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Joe Korty <joe.korty@ccur.com>,
       Thomas Gleixner <tglx@linutronix.de>,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       Andrew Morton <akpm@osdl.org>, linux-arch@vger.kernel.org,
       Linux Kernel Development <linux-kernel@vger.kernel.org>, matthew@wil.cx,
       arjan@infradead.org, Christoph Hellwig <hch@infradead.org>,
       mingo@elte.hu, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       nikita@clusterfs.com, pj@sgi.com, dhowells@redhat.com
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
Message-ID: <20051222124513.GC14633@gnuppy.monkey.org>
References: <Pine.LNX.4.64.0512161339140.3698@g5.osdl.org> <1134770778.2806.31.camel@tglx.tec.linutronix.de> <Pine.LNX.4.64.0512161414370.3698@g5.osdl.org> <1134772964.2806.50.camel@tglx.tec.linutronix.de> <Pine.LNX.4.64.0512161439330.3698@g5.osdl.org> <20051217002929.GA7151@tsunami.ccur.com> <Pine.LNX.4.64.0512161647570.3698@g5.osdl.org> <Pine.LNX.4.58.0512162211320.6498@gandalf.stny.rr.com> <Pine.LNX.4.64.0512162323140.3698@g5.osdl.org> <20051222124027.GB14633@gnuppy.monkey.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051222124027.GB14633@gnuppy.monkey.org>
User-Agent: Mutt/1.5.11
From: Bill Huey (hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 22, 2005 at 04:40:27AM -0800, Bill Huey wrote:
> The current kernel mostly using traditional spinlocks doesn't have locking
> complicated enough to warrant it. However, the -rt patch does create[s] a
> circumstance where a fully preemptible [kernel] may sleep task with mutexes held create[ing]
> [-and needs] [a need to] resolve priority inversions that results from it. That's of

With corrections...

Sorry, I meant a fully preemptive kernel has priority inversion as an
inheritant property and needs to resolved using some kind of priority
inheritance.

> course assuming that priority is something that needs to be strictly
> obeyed in this variant of the kernel with consideration to priority
> inheritance.

bill

