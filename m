Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262050AbRETPpx>; Sun, 20 May 2001 11:45:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262056AbRETPpn>; Sun, 20 May 2001 11:45:43 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:47118 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S262050AbRETPpe>;
	Sun, 20 May 2001 11:45:34 -0400
Date: Sun, 20 May 2001 11:44:11 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: CML2 design philosophy heads-up
Message-ID: <20010520114411.A3600@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20010518034307.A10784@thyrsus.com> <E150fV9-0006q1-00@the-village.bc.nu> <20010518105353.A13684@thyrsus.com> <3B053B9B.23286E6C@redhat.com> <20010518112625.A14309@thyrsus.com> <20010518113726.A29617@devserv.devel.redhat.com> <20010518114922.C14309@thyrsus.com> <8485.990357599@redhat.com> <20010520111856.C3431@thyrsus.com> <15823.990372866@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <15823.990372866@redhat.com>; from dwmw2@infradead.org on Sun, May 20, 2001 at 04:34:26PM +0100
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse <dwmw2@infradead.org>:
> On one hand you have dependencies which are present to make life easier for 
> Aunt Tillie, by refraining from confusing her with strange questions to 
> which the answer is _probably_ 'no'. Like the question of whether she has 
> an IDE controller on her MVME board.
> 
> One the other hand, you have the dependencies present in the existing CML1
> configuration, which are _absolute_ dependencies - which specify for example
> that you cannot enable support for PCI peripherals if !CONFIG_PCI, etc.
> These dependencies are there to prevent you from enabling combinations of
> options which are utterly meaningless, and usually won't even compile.

There are no `advisory' dependencies in CML2.  They're all absolute.

What you call an `advisory' dependency would be simulated by having a 
policy symbol for Aunt Tillie mode and writing constraints like this:

require AUNT_TILLIE implies FOO >= BAR

This is exactly why the CML2 ruleset has EXPERT, WIZARD, and TUNING 
policy symbols, as hooks for doing things like this. 
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

No one who's seen it in action can say the phrase "government help" without
either laughing or crying.
