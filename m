Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266989AbSLPSGQ>; Mon, 16 Dec 2002 13:06:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266991AbSLPSGQ>; Mon, 16 Dec 2002 13:06:16 -0500
Received: from d146.dial.univie.ac.at ([131.130.203.146]:37767 "EHLO
	server.lan") by vger.kernel.org with ESMTP id <S266989AbSLPSGP>;
	Mon, 16 Dec 2002 13:06:15 -0500
Message-Id: <200212161813.gBGIDuHv029134@server.lan>
From: Melchior FRANZ <mfranz@users.sourceforge.net>
Subject: Re: 2.5.52 and modules (lots of unresolved symbols)?
To: linux-kernel@vger.kernel.org
Date: Mon, 16 Dec 2002 19:13:56 +0100
References: <20021216094514.GA735@ulima.unil.ch> <Pine.LNX.4.50L0.0212161114360.1154-100000@dust.ebiz-gw.wintek.com> <20021216171703.GD13198@ulima.unil.ch> <Pine.LNX.4.50L0.0212161207430.1154-100000@dust.ebiz-gw.wintek.com>
Organization: http://www.unet.univie.ac.at/~a8603365/
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Alex Goddard -- Monday 16 December 2002 19:32:
> Huh.  Like I said, reinstalling the mod tools and doing a rebuild after a
> make clean cleared it up for me.
> 
> Weird.

Not really. The problem is, that the kernel Makefile contains
an absolute path for depmod (/sbin/depmod) which doesn't seem
like a good idea. I you are installing the module-init-tools
to /usr/local/sbin, they don't take precedence over the old
depmod et al.

Why doesn't the Makefile simply define "DEPMOD = depmod"
instead of "DEPMOD = /sbin/depmod" (and likewise for
genksyms)? 

m.
