Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268376AbTAMWLG>; Mon, 13 Jan 2003 17:11:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268377AbTAMWLG>; Mon, 13 Jan 2003 17:11:06 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:60678 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S268376AbTAMWLE>;
	Mon, 13 Jan 2003 17:11:04 -0500
Date: Mon, 13 Jan 2003 23:19:43 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: Sam Ravnborg <sam@ravnborg.org>,
       Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
       ebiederm@xmission.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Consolidate vmlinux.lds.S files
Message-ID: <20030113221942.GB2423@mars.ravnborg.org>
Mail-Followup-To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
	Sam Ravnborg <sam@ravnborg.org>,
	Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
	ebiederm@xmission.com, linux-kernel@vger.kernel.org
References: <20030113180450.GA1870@mars.ravnborg.org> <Pine.LNX.4.44.0301131309240.24477-100000@chaos.physics.uiowa.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0301131309240.24477-100000@chaos.physics.uiowa.edu>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 13, 2003 at 01:13:28PM -0600, Kai Germaschewski wrote:
> On Mon, 13 Jan 2003, Sam Ravnborg wrote:
> 
> > The purpose was to define common stuff in a single place.
> > Ask Rusty Russell if it is fun to add the same section to > 50
> > .lds files.
> > 
> > Based on the feedback I will try to come up with a lighter proposal,
> > that does not hurt readability.
> > I still want the common stuff separated away.
> 
> I second this, though I also agree that your first cut was hiding away 
> stuff more than necessary.
What I posted was to get feedback, not what I had in mind as first step.
I agree to take small steps - but wanted to find out the direction.

> I would suggest an approach like the following, of course showing only a 
> first simple step.

But you do not deal with different alingment of the sections.
I have not yet fully understood all the requirements, but wanted to
keep the original ALIGN settings.
In the patch you posted some architectures use ALIGN(4) {cris},
other nothing, but most of them ALIGN(16).
Is it OK to force them all to ALIGN(16) then?

> A series of steps like this should allow for a serious 
> reduction in size of arch/*/vmlinux.lds.S already, while being obviously 
> correct and allowing archs to do their own special thing if necessary (in 
> particular, IA64 seems to differ from all the other archs).

My main objective was that adding new stuff, like __gpl_ksyms could
be done in one place only.
Or .gnu.linkonce.vermagic, or whatever will be used for that.

Thats why I collected so much in INIT_SECTION_CMD(...).


I will come back with something during the week - as time permits.

	Sam

