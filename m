Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129134AbRDCD73>; Mon, 2 Apr 2001 23:59:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129359AbRDCD7T>; Mon, 2 Apr 2001 23:59:19 -0400
Received: from gull.prod.itd.earthlink.net ([207.217.121.85]:26364 "EHLO
	gull.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S129134AbRDCD7I>; Mon, 2 Apr 2001 23:59:08 -0400
Date: Mon, 2 Apr 2001 19:59:15 -0700 (PDT)
From: James Simmons <jsimmons@linux-fbdev.org>
X-X-Sender: <jsimmons@linux.local>
To: Thorsten Glaser Geuer <eccesys@topmail.de>
cc: Boris Pisarcik <boris@acheron.sk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Basic Text Mode (was: Re: Question about SysRq)
Message-ID: <Pine.LNX.4.31.0104021953570.3867-100000@linux.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> One more property, that i'd like to have should be request key to force
> the most basic text mode (say 80x25) on the console, when eg. X freezes
> and i kill its session, then last gfx mode resides on the screen and
> see no way to restore back the text mode - /usr/bin/reset or something
> alike will not do it. But it seems to be not a good idea at all, does it
> ?

I'm working on this. In theory it should be possible with SAK. Alt-SysRq-k
resets the console. Here it set the vc_mode back to KD_TEXT and the
keyboard back to VC_XLATE. It even reset ths palette. What it doesn't do
is reset the hardware state. I hope to change this for 2.5.X. It is
possible using fbdev to do this very easily. I'm working on it so you can
go back and forth between fbdev and vgacon for those who want to if their
hardware supports it use vgacon. This can be applied to this problem very
easily.

MS: (n) 1. A debilitating and surprisingly widespread affliction that
renders the sufferer barely able to perform the simplest task. 2. A disease.

James Simmons  [jsimmons@linux-fbdev.org]               ____/|
fbdev/console/gfx developer                             \ o.O|
http://www.linux-fbdev.org                               =(_)=
http://linuxgfx.sourceforge.net                            U
http://linuxconsole.sourceforge.net

