Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262225AbRETUQL>; Sun, 20 May 2001 16:16:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262219AbRETUQA>; Sun, 20 May 2001 16:16:00 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:6671 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S262218AbRETUPt>;
	Sun, 20 May 2001 16:15:49 -0400
Date: Sun, 20 May 2001 16:13:21 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Jonathan Morton <chromi@cyberspace.org>
Cc: David Woodhouse <dwmw2@infradead.org>,
        Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Background to the argument about CML2 design philosophy
Message-ID: <20010520161321.D4488@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Jonathan Morton <chromi@cyberspace.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20010518112625.A14309@thyrsus.com> <20010518113726.A29617@devserv.devel.redhat.com> <20010518114922.C14309@thyrsus.com> <8485.990357599@redhat.com> <20010520111856.C3431@thyrsus.com> <15823.990372866@redhat.com> <20010520114411.A3600@thyrsus.com> <16267.990374170@redhat.com> <20010520131457.A3769@thyrsus.com> <l03130301b72db986b2dc@[192.168.239.105]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <l03130301b72db986b2dc@[192.168.239.105]>; from chromi@cyberspace.org on Sun, May 20, 2001 at 07:31:12PM +0100
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Morton <chromi@cyberspace.org>:
> One caveat though - not all Macs have SCSI controllers, and not all that do
> even have one of the two standard ones.

I know.  But these derivations are only for the old 68K macs, which don't
have PCI.  Closed issue.

> >3. The MVME derivations are correct *if* (and only if) you agree to ignore
> >the possibility that somebody could want to ignore the onboard hardware,
> >plug outboard disk or Ethernet cards into the VME-bus connector, and
> >do something like running SCSI-over-ATAPI to the outboard device.
> 
> ...and then someone else mentioned the possibility of f*x0r3d hardware.  In
> this case, I would say this *isn't* a kernel-configuration issue but one of
> being able to disable the drivers for the malfunctioning hardware.

But the other side is going to ask: suppose you're memory-limited
(quite likely on older SBCs) and don't want to pay the core cost of
drivers you won't use?  I don't really think we can duck this question
by talking about boot-time parameters.

> I think the MVME derivations are *perfectly* sensible - if the reference
> board and most (read: virtually all) derivatives have those features, turn
> them on by all means.

That's my gut feeling, too.  But a lot of people insist that the only right 
way is totally fine-grained control, even in weird edge cases like this one.

>                 To satisfy some others, you might want to say "Hey,
> these guys might want to *explicitly turn off* some of this stuff" - so
> provide an option under "Are you insane?" which presents all the "derived"
> symbols and allows the hackers to manually turn stuff off.

Interesting thought...
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

I cannot undertake to lay my finger on that article of the
Constitution which grant[s] a right to Congress of expending, on
objects of benevolence, the money of their constituents.
	-- James Madison, 1794
