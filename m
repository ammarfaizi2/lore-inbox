Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132848AbRDKSnO>; Wed, 11 Apr 2001 14:43:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132868AbRDKSnD>; Wed, 11 Apr 2001 14:43:03 -0400
Received: from lightning.hereintown.net ([207.196.96.3]:19621 "EHLO
	lightning.hereintown.net") by vger.kernel.org with ESMTP
	id <S132821AbRDKSmm>; Wed, 11 Apr 2001 14:42:42 -0400
Date: Wed, 11 Apr 2001 14:55:40 -0400 (EDT)
From: Chris Meadors <clubneon@hereintown.net>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
cc: "alan@lxorguk.ukuu.org.uk" <alan@lxorguk.ukuu.org.uk>,
        "torvalds@transmeta.com" <torvalds@transmeta.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fbdev@vuser.vu.union.edu" <linux-fbdev@vuser.vu.union.edu>
Subject: Re: [PATCH] matroxfb and mga XF4 driver coexistence...
In-Reply-To: <20010411201131.A1781@vana.vc.cvut.cz>
Message-ID: <Pine.LNX.4.31.0104111448010.15236-100000@rc.priv.hereintown.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Apr 2001, Petr Vandrovec wrote:

> Hi,
>    Alan, Linus, please apply this patch to matroxfb. It fixes complaints
> from people that screen is black after they exit from X back to console.
> Matrox driver does not know that it should return hardware state back to
> initial state after switch, but matroxfb relies on that (XF3 did that...).
> So now it reprograms hardware always from scratch...

I would like to see this fixed as much as anyone (even complained to the
XFree people from SuSE last ALS).  But I don't think the fix should be in
the kernel.  XF4 needs to be fixed.  The problem doesn't just effect the
maxtroxfb, but also the vgacon video mode selection.

If I put anything other than "normal" or "extended" in the "vga=" line of
my lilo.conf the machine starts okay, but upon exiting X bad stuff
happens.  The screen doesn't just go black.  Probally the majority of
Matrox owners have multisync monitors, but I'm stuck with an old monosync,
and it looses sync when trying to return to a VESA text mode.

I don't use the matroxfb driver so this patch wouldn't help me, and is
also why I say XFree 4.0 needs to be fixed.

-Chris
-- 
Two penguins were walking on an iceberg.  The first penguin said to the
second, "you look like you are wearing a tuxedo."  The second penguin
said, "I might be..."                         --David Lynch, Twin Peaks

