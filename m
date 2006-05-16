Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932218AbWEPWZt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932218AbWEPWZt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 18:25:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932219AbWEPWZt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 18:25:49 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:22794 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932218AbWEPWZt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 18:25:49 -0400
Date: Wed, 17 May 2006 00:25:43 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Valdis.Kletnieks@vt.edu
Cc: "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc4-mm1 klibc build misbehavior
Message-ID: <20060516222543.GA25239@mars.ravnborg.org>
References: <200605151907.k4FJ7Olk006598@turing-police.cc.vt.edu> <20060515121630.2a91235b.akpm@osdl.org> <4468E4C7.9040701@zytor.com> <20060515212951.GA1329@mars.ravnborg.org> <200605160158.k4G1wEoc009125@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200605160158.k4G1wEoc009125@turing-police.cc.vt.edu>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 15, 2006 at 09:58:14PM -0400, Valdis.Kletnieks@vt.edu wrote:
> On Mon, 15 May 2006 23:29:51 +0200, Sam Ravnborg said:
> > On Mon, May 15, 2006 at 01:29:59PM -0700, H. Peter Anvin wrote:
> > > Andrew Morton wrote:
> > > >Valdis.Kletnieks@vt.edu wrote:
> > > >>Why does touching scripts/mod/modpost.c end up rebuilding all of klibc?
> 
> > Please post output of make V=1 after touching modpost.c
> 
> Blarg.  Now it won't do it.  Checking back, it looks like I managed to
> get the ownership/permissions trashed while I was debugging the
> modpost.c bug - looks like a 'make modules_install' rebuilt some stuff
> as root it shouldn't have, so the next build as non-root was unable to
> write some file and that scrogged the build...
> 
> Chalk this one up as collateral damage while debugging a real bug. :)
OK, thanks for reporting back on this one.

	Sam


