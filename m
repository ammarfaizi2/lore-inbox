Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267050AbTB0UbG>; Thu, 27 Feb 2003 15:31:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267070AbTB0UbG>; Thu, 27 Feb 2003 15:31:06 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:15379 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267050AbTB0UbA>; Thu, 27 Feb 2003 15:31:00 -0500
Date: Thu, 27 Feb 2003 12:38:43 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Daniel Jacobowitz <dan@debian.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Invalid compilation without -fno-strict-aliasing
In-Reply-To: <20030227203512.GA12623@nevyn.them.org>
Message-ID: <Pine.LNX.4.44.0302271234530.9696-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 27 Feb 2003, Daniel Jacobowitz wrote:
> 
> We could work around both of these: disable the sign compare warning,
> and use check_gcc to set a high number for -finline-limit...

Oh, both are work-aroundable, no question about it. The same way it was 
possible to work around the broken aliasing with previous releases. I'm 
just hoping that especially the inline thing can be resolved sanely, 
otherwise we'll end up having to use something ugly like

	-D'inline=inline __attribute__((force_inline))'

on every single command line..

(I find -finline-limit tasteless, since the limit number is apparently
totally meaningless as far as the user is concerned. It's clearly a
command line option that is totally designed for ad-hoc compiler tweaking,
not for any actual useful user stuff).

		Linus

