Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267515AbTBQOZ1>; Mon, 17 Feb 2003 09:25:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267446AbTBQOYZ>; Mon, 17 Feb 2003 09:24:25 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:25550
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S267424AbTBQOX3>; Mon, 17 Feb 2003 09:23:29 -0500
Date: Mon, 17 Feb 2003 09:31:38 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
cc: Richard Henderson <rth@twiddle.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH][2.5] Protect smp_call_function_data w/ spinlocks on
 Alpha
In-Reply-To: <20030217172319.A1161@jurassic.park.msu.ru>
Message-ID: <Pine.LNX.4.50.0302170930120.18087-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.50.0302140634000.3518-100000@montezuma.mastecende.com>
 <20030214175332.A19234@jurassic.park.msu.ru>
 <Pine.LNX.4.50.0302141158070.3518-100000@montezuma.mastecende.com>
 <20030217001544.A13101@twiddle.net> <Pine.LNX.4.50.0302170316500.18087-100000@montezuma.mastecende.com>
 <20030217172319.A1161@jurassic.park.msu.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Feb 2003, Ivan Kokshaysky wrote:

> On Mon, Feb 17, 2003 at 03:32:09AM -0500, Zwane Mwaikambo wrote:
> > Assigns whatever the pointer happens to be at the time, be it NULL or the 
> > next incoming message call.
> 
> No, the pointer is guaranteed to be valid.
> 
> > Therefore we'd need a lock to protect both the variable and critical 
> > section.
> 
> But smp_call_function_data pointer itself is exactly such a lock -
> other CPUs can't enter the section between 'if (pointer_lock())' and
> 'smp_call_function_data = 0', so there is no need for extra lock
> variable. Additionally, pointer_lock() with retry = 0 acts as spin_trylock.

Oh my mistake i thought you were talking about atomic assignment and not 
blocking at that point. I misunderstood what you stated.

	Zwane
-- 
function.linuxpower.ca
