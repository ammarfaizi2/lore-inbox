Return-Path: <linux-kernel-owner+w=401wt.eu-S932645AbWLZPRh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932645AbWLZPRh (ORCPT <rfc822;w@1wt.eu>);
	Tue, 26 Dec 2006 10:17:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932647AbWLZPRh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Dec 2006 10:17:37 -0500
Received: from vervifontaine.sonytel.be ([80.88.33.193]:38037 "EHLO
	vervifontaine.sonycom.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S932645AbWLZPRg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Dec 2006 10:17:36 -0500
Date: Tue, 26 Dec 2006 16:17:27 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Randy Dunlap <randy.dunlap@oracle.com>
cc: 7eggert@gmx.de, =?ISO-8859-1?Q?J=F6rn?= Engel <joern@lazybastard.org>,
       Yakov Lerner <iler.ml@gmail.com>, Kernel <linux-kernel@vger.kernel.org>
Subject: Re: two architectures,same source tree
In-Reply-To: <20061222130027.a42f5cf6.randy.dunlap@oracle.com>
Message-ID: <Pine.LNX.4.62.0612261616360.30485@pademelon.sonytel.be>
References: <7uewg-7Un-7@gated-at.bofh.it> <7ueZm-17M-25@gated-at.bofh.it>
 <E1GxrGg-0001SL-3h@be1.lrz> <20061222130027.a42f5cf6.randy.dunlap@oracle.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-584337861-390717374-1167146247=:30485"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---584337861-390717374-1167146247=:30485
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Fri, 22 Dec 2006, Randy Dunlap wrote:
> On Fri, 22 Dec 2006 21:45:26 +0100 Bodo Eggert wrote:
> > Jörn Engel <joern@lazybastard.org> wrote:
> > > On Wed, 20 December 2006 20:32:20 +0200, Yakov Lerner wrote:
> > 
> > >> Is it easily possible to build two architectures in
> > >> the same source tree (so that intermediate fles
> > >> and resut files do not interfere ) ?
> > > 
> > > I'd try something like this:
> > > make O=../foo ARCH=foo
> > > make O=../bar ARCH=bar
> > > 
> > > But as I'm lazy I'll leave the debugging to you. :)
> > 
> > IIRC You'll have to specify ARCH= on each make call, but O= is saved in
> > ../foo/Makefile.
> 
> Hm, top-level README file says:
> 
>    Please note: If the 'O=output/dir' option is used then it must be
>    used for all invocations of make.

That should be: `... for all invocations of make in the source tree directory'.
It's done automaticallt when invoking make in the build directory.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
---584337861-390717374-1167146247=:30485--
