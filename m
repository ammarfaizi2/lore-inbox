Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265306AbUATKEj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 05:04:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265334AbUATKEj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 05:04:39 -0500
Received: from gprs214-67.eurotel.cz ([160.218.214.67]:13184 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S265306AbUATKEh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 05:04:37 -0500
Date: Tue, 20 Jan 2004 11:04:05 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       ncunningham@users.sourceforge.net, Hugang <hugang@soulinfo.com>,
       ncunningham@clear.net.nz,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Debian GNU/Linux PPC <debian-powerpc@lists.debian.org>
Subject: Re: Help port swsusp to ppc.
Message-ID: <20040120100405.GB183@elf.ucw.cz>
References: <20040119105237.62a43f65@localhost> <1074483354.10595.5.camel@gaston> <1074489645.2111.8.camel@laptop-linux> <1074490463.10595.16.camel@gaston> <20040119204551.GB380@elf.ucw.cz> <1074555531.10595.89.camel@gaston> <Pine.GSO.4.58.0401201052320.18625@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.58.0401201052320.18625@waterleaf.sonytel.be>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Well, then what you do is not swsusp.
> > >
> > > swsusp does assume same kernel during suspend and resume. Doing resume
> > > within bootloader (and thus avoiding this) would be completely
> > > different design.
> >
> > Wait... what the hell in swsusp requires this assumption ? It seems to
> > me like a completely unnecessary design limitation.
> 
> Swsusp saves the data structures from the suspended kernel, so they have to
> match the data structures of the resumed kernel, right?

Well, *all* the data pages are saved, so that would be okay (even if
they changed, as I'm replacing all the data pages, that should work),
but I'm not saving kernel text for example.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
