Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267010AbSLPSot>; Mon, 16 Dec 2002 13:44:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267013AbSLPSot>; Mon, 16 Dec 2002 13:44:49 -0500
Received: from rivmkt61.wintek.com ([206.230.0.61]:1408 "EHLO comcast.net")
	by vger.kernel.org with ESMTP id <S267010AbSLPSor>;
	Mon, 16 Dec 2002 13:44:47 -0500
Date: Mon, 16 Dec 2002 13:54:21 +0000 (UTC)
From: Alex Goddard <agoddard@purdue.edu>
To: Melchior FRANZ <mfranz@users.sourceforge.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.52 and modules (lots of unresolved symbols)?
In-Reply-To: <200212161813.gBGIDuHv029134@server.lan>
Message-ID: <Pine.LNX.4.50L0.0212161352240.1154-100000@dust.ebiz-gw.wintek.com>
References: <20021216094514.GA735@ulima.unil.ch>
 <Pine.LNX.4.50L0.0212161114360.1154-100000@dust.ebiz-gw.wintek.com>
 <20021216171703.GD13198@ulima.unil.ch> <Pine.LNX.4.50L0.0212161207430.1154-100000@dust.ebiz-gw.wintek.com>
 <200212161813.gBGIDuHv029134@server.lan>
X-GPG-PUBLIC_KEY: N/a
X-GPG-FINGERPRINT: BCBC 0868 DB78 22F3 A657 785D 6E3B 7ACB 584E B835
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Dec 2002, Melchior FRANZ wrote:

> * Alex Goddard -- Monday 16 December 2002 19:32:
> > Huh.  Like I said, reinstalling the mod tools and doing a rebuild after a
> > make clean cleared it up for me.
> > 
> > Weird.
> 
> Not really. The problem is, that the kernel Makefile contains
> an absolute path for depmod (/sbin/depmod) which doesn't seem
> like a good idea. I you are installing the module-init-tools
> to /usr/local/sbin, they don't take precedence over the old
> depmod et al.
> 
> Why doesn't the Makefile simply define "DEPMOD = depmod"
> instead of "DEPMOD = /sbin/depmod" (and likewise for
> genksyms)? 

Ah.  That makes sense.  Your question is the same as mine, then.  Why 
define an absolute path for depmod?

One suggestion for the person who started this thread, then, is to make 
sure that /sbin/depmod is, or is pointing to, a version of depmod that 
won't freak out over the modules.

-- 
Alex Goddard
agoddard@purdue.edu
