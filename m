Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265415AbUATL5t (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 06:57:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265422AbUATL5t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 06:57:49 -0500
Received: from gprs214-67.eurotel.cz ([160.218.214.67]:31105 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S265415AbUATL5s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 06:57:48 -0500
Date: Tue, 20 Jan 2004 12:57:40 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       ncunningham@users.sourceforge.net, Hugang <hugang@soulinfo.com>,
       ncunningham@clear.net.nz,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Debian GNU/Linux PPC <debian-powerpc@lists.debian.org>
Subject: Re: Help port swsusp to ppc.
Message-ID: <20040120115740.GB522@elf.ucw.cz>
References: <1074483354.10595.5.camel@gaston> <1074489645.2111.8.camel@laptop-linux> <1074490463.10595.16.camel@gaston> <20040119204551.GB380@elf.ucw.cz> <1074555531.10595.89.camel@gaston> <Pine.GSO.4.58.0401201052320.18625@waterleaf.sonytel.be> <20040120100405.GB183@elf.ucw.cz> <1074598014.739.7.camel@gaston> <20040120113630.GA380@elf.ucw.cz> <1074599060.793.11.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1074599060.793.11.camel@gaston>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > Well, *all* the data pages are saved, so that would be okay (even if
> > > > they changed, as I'm replacing all the data pages, that should work),
> > > > but I'm not saving kernel text for example.
> > > 
> > > Ahh... that's an interesting point. You aren't saving kernel text. I'm
> > > not sure how that could be a problem for me. I think i'll just save it
> > > along with the image though. 
> > 
> > Also pay attetion to page tables. I know that page tables "copy"
> > routine is running from are same between suspend and resume kernel.
> 
> I plan to run everything provided by the suspended kernel actually. My idea
> is to keep a handle to a page of the suspended kernel that contains that
> code and just kick into it. Copying pages to their final location without
> overriding the source pages is a bit of a funky job, but I had to do it
> already with BootX so ... I'll work on that during one of the upcoming few
> weeks hopefully, I'm a bit swamped with 3 different things at the
> moment.

You actually *know* that half of memory is free during resume, so you
can load kernel-to-be-resumed data into that free memory. That's how
swsusp works. It makes it quite simple...
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
