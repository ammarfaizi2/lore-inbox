Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267793AbUG3TBi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267793AbUG3TBi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 15:01:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267789AbUG3TBi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 15:01:38 -0400
Received: from vsmtp14.tin.it ([212.216.176.118]:36347 "EHLO vsmtp14.tin.it")
	by vger.kernel.org with ESMTP id S267788AbUG3TAa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 15:00:30 -0400
Date: Fri, 30 Jul 2004 20:59:01 +0200
From: Giuliano Pochini <pochini@shiny.it>
To: Tom Rini <trini@kernel.crashing.org>
Cc: kumar.gala@freescale.com, tnt@246tNt.com, linuxppc-dev@lists.linuxppc.org,
       linux-kernel@vger.kernel.org, olh@suse.de, akpm@osdl.org
Subject: Re: [PATCH][PPC32] Makefile cleanups and gcc-3.4+binutils-2.14 c
Message-Id: <20040730205901.4d4181f4.pochini@shiny.it>
In-Reply-To: <20040729144347.GE16468@smtp.west.cox.net>
References: <20040728220733.GA16468@smtp.west.cox.net>
	<XFMail.20040729100549.pochini@shiny.it>
	<20040729144347.GE16468@smtp.west.cox.net>
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.10; powerpc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Jul 2004 07:43:47 -0700
Tom Rini <trini@kernel.crashing.org> wrote:

> > I had no time to do a lot of testing, but it seems that binutils 2.15 +
> > gcc 3.3.3 is a bad one too. I didn't try to compile the kernel (which
> > may also break), but at least I couldn't compile gcc 3.4.1 with the
> > above combination. It seems that as doesn't get the -mxxx parameter
> > required to compile altivec stuff. Hacking the Makefile to make it
> > pass -Wa,-m7455 helped a little, but it eventually failed in another
> > weird way. I hadn't time to investigate further, sorry.
>
> Stock gcc-3.3.3 or from the hammer branch ?

Stock.


> There is, I think, a second
> problem that was left out.  The problem with gcc-3.4 + binutils-2.14 is
> that -many gets passed, which zeros out previous flags.  -many is fine
> in binutils-2.15 (and 2.13 and 2.12 and 2.12.1 it seems), but 2.15 does
> require -maltivec to be passed in order to handle altivec instructions.
> Getting this right was part of the cleanup that conflicted with the
> mpc52xx changes (Andrew: trying to take care of getting this into Linus'
> tree now).

Ah, ok, this is useful to know. Btw, I compiled linux 2.6.7 with gcc 3.4.1
and binutils 2.15 without problems.



--
Giuliano.
