Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267959AbTBMFIB>; Thu, 13 Feb 2003 00:08:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267962AbTBMFIB>; Thu, 13 Feb 2003 00:08:01 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:44645 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S267959AbTBMFIA>; Thu, 13 Feb 2003 00:08:00 -0500
To: Andi Kleen <ak@suse.de>
Cc: Jamie Lokier <jamie@shareable.org>, Dave Jones <davej@codemonkey.org.uk>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Bug 350] New: i386 context switch very slow compared to 2.4 due to wrmsr (performance)
References: <629040000.1045013743@flay>
	<20030212025902.GA14092@codemonkey.org.uk>
	<20030212075048.GA9049@wotan.suse.de>
	<20030212102741.GC10422@bjl1.jlokier.co.uk>
	<20030212104508.GA1273@wotan.suse.de>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 12 Feb 2003 22:17:21 -0700
In-Reply-To: <20030212104508.GA1273@wotan.suse.de>
Message-ID: <m1of5gwyhq.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> writes:

> On Wed, Feb 12, 2003 at 10:27:41AM +0000, Jamie Lokier wrote:
> > Andi Kleen wrote:
> > > +	/* FIXME should disable preemption here but how can we reenable it? */
> > > +
> > > +	enable_sysenter();
> > > +
> > 
> > Try this:
> 
> [...] I have no real interest in vm86 mode, perhaps one of the people
> interested in dosemu etc. could take care of it. I'm very glad it doesn't
> exist on my main architecture - x86-64 - given how many hacks it needs to be 
> supported.

There is certainly some old cruft in there, but...

I have been thinking evil thoughts lately about what it would take
to implement on x86-64.

Switching in and out of long mode is evil enough that I don't think it
is worth it.  And encouraging people to write good JIT compiling
emulators sounds much better, especially in the long run.  But it can
be written.

Eric
