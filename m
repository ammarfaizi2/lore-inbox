Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316587AbSGHKTY>; Mon, 8 Jul 2002 06:19:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316659AbSGHKTX>; Mon, 8 Jul 2002 06:19:23 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:49426 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S316587AbSGHKTW>; Mon, 8 Jul 2002 06:19:22 -0400
Date: Mon, 8 Jul 2002 06:16:07 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Daniel Phillips <phillips@arcor.de>
cc: Jamie Lokier <lk@tantalophile.demon.co.uk>,
       Werner Almesberger <wa@almesberger.net>, Keith Owens <kaos@ocs.com.au>,
       linux-kernel@vger.kernel.org
Subject: Re: [OKS] Module removal
In-Reply-To: <E17RRum-0001Y5-00@starship>
Message-ID: <Pine.LNX.3.96.1020708060405.21693A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Jul 2002, Daniel Phillips wrote:

> That's not nice.  It requires the calling code to know it's calling a
> module and it imposes the inc/dec overhead on callers even when the
> target isn't compiled as a module.

I don't think so... the module knows, there's a bit of hard code for the
module anyway, so that could do the inc/dec and know when the module was
in the "about to be removed" state. It's not clear if "it works most of
the time now" means we just need to address some simple corner cases or if
the whole design of modules needs to be reimplemented to really sweep out
the corners, and they're not "simple" at all.

This has the feeling that someone could say "we could just..." at any
time, and the whole problem would vanish.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

