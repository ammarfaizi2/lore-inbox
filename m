Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262902AbUBJUIy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 15:08:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265592AbUBJUIy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 15:08:54 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:384 "EHLO shadow.ucw.cz")
	by vger.kernel.org with ESMTP id S262902AbUBJUIx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 15:08:53 -0500
Date: Tue, 10 Feb 2004 21:08:51 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: linux-kernel@vger.kernel.org
Cc: Greg Norris <haphazard@kc.rr.com>
Subject: Re: [patch] Re: psmouse.c, throwing 3 bytes away
Message-ID: <20040210200851.GA261@ucw.cz>
References: <200402041820.39742.wnelsonjr@comcast.net> <200402060006.32732.wnelsonjr@comcast.net> <20040207004700.0dd5e626.mikeserv@bmts.com> <200402070911.42569.murilo_pontes@yahoo.com.br> <20040209004812.GA18512@ucw.cz> <20040210025627.GA2117@yggdrasil.localdomain> <20040210070735.GA257@ucw.cz> <20040210194855.GA10591@yggdrasil.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040210194855.GA10591@yggdrasil.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 10, 2004 at 01:48:55PM -0600, Greg Norris wrote:
> On Tue, Feb 10, 2004 at 08:07:35AM +0100, Vojtech Pavlik wrote:
> > USB?? This was for PS/2 mice. If it fixed your USB mouse problem, you
> > were using PS/2 drivers with your USB mouse, which is wrong (although it
> > can work). You need to use USB drivers.
> 
> I thought I was... all of the appropriate USB drivers are enabled, and
> I haven't done anything special to load the psmouse module.  I guess
> it's possible that a bootup script is loading it automagically,
> tho.  I'll check into this.

The most suspicious issue here is that not only psmouse gets loaded, but
that it finds a mouse attached! Note that ehci-hcd is not enough, you
also will need either uhci or ohci.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
