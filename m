Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265379AbUATLrB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 06:47:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265391AbUATLrB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 06:47:01 -0500
Received: from gate.crashing.org ([63.228.1.57]:41428 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S265379AbUATLq6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 06:46:58 -0500
Subject: Re: Help port swsusp to ppc.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       ncunningham@users.sourceforge.net, Hugang <hugang@soulinfo.com>,
       ncunningham@clear.net.nz,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Debian GNU/Linux PPC <debian-powerpc@lists.debian.org>
In-Reply-To: <20040120113630.GA380@elf.ucw.cz>
References: <20040119105237.62a43f65@localhost>
	 <1074483354.10595.5.camel@gaston> <1074489645.2111.8.camel@laptop-linux>
	 <1074490463.10595.16.camel@gaston> <20040119204551.GB380@elf.ucw.cz>
	 <1074555531.10595.89.camel@gaston>
	 <Pine.GSO.4.58.0401201052320.18625@waterleaf.sonytel.be>
	 <20040120100405.GB183@elf.ucw.cz> <1074598014.739.7.camel@gaston>
	 <20040120113630.GA380@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1074599060.793.11.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 20 Jan 2004 22:44:21 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-01-20 at 22:36, Pavel Machek wrote:
> Hi!
> 
> > > Well, *all* the data pages are saved, so that would be okay (even if
> > > they changed, as I'm replacing all the data pages, that should work),
> > > but I'm not saving kernel text for example.
> > 
> > Ahh... that's an interesting point. You aren't saving kernel text. I'm
> > not sure how that could be a problem for me. I think i'll just save it
> > along with the image though. 
> 
> Also pay attetion to page tables. I know that page tables "copy"
> routine is running from are same between suspend and resume kernel.

I plan to run everything provided by the suspended kernel actually. My idea
is to keep a handle to a page of the suspended kernel that contains that
code and just kick into it. Copying pages to their final location without
overriding the source pages is a bit of a funky job, but I had to do it
already with BootX so ... I'll work on that during one of the upcoming few
weeks hopefully, I'm a bit swamped with 3 different things at the moment.

ben.
 

