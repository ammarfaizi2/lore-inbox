Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261599AbVBSAbk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261599AbVBSAbk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 19:31:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261596AbVBSAaV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 19:30:21 -0500
Received: from neapel230.server4you.de ([217.172.187.230]:38319 "EHLO
	neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S261599AbVBSA3H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 19:29:07 -0500
Date: Sat, 19 Feb 2005 01:29:03 +0100
From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
To: Herbert Poetzl <herbert@13thfloor.at>
Cc: Bodo Eggert <7eggert@gmx.de>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: Re: [PATCH] add umask parameter to procfs
Message-ID: <20050219002903.GA5380@lsrfire.ath.cx>
References: <fa.h7bdq0l.im6ej1@ifi.uio.no> <fa.fep4kfp.gmci2d@ifi.uio.no> <E1D1yjD-00035Y-5u@be1.7eggert.dyndns.org> <20050218035601.GA21343@mail.13thfloor.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050218035601.GA21343@mail.13thfloor.at>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 18, 2005 at 04:56:01AM +0100, Herbert Poetzl wrote:
> hmm, so what about debugger and similar not able to find the
> parent process or something like that?

You can walk the parentage chain up until you reach your login shell.
So you can look up info about the parent of every one of your processes
except for your login shell and any zombies.

> I'd say this needs some more investigation what tools and
> applications will break once it is enabled ...

Sure, that can't be bad.  I didn't really do anything so far that
warrants being called testing (compiles, runs, doesn't crash on boot --
send patch! ;).

But I also didn't invent this feature: it has been in OpenWall and
grsecurity for a long time now, so a form of restricted /proc has
received at least *some* testing.

Rene
