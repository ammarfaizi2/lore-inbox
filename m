Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129626AbRBMAB0>; Mon, 12 Feb 2001 19:01:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129752AbRBMABQ>; Mon, 12 Feb 2001 19:01:16 -0500
Received: from smtp.bellnexxia.net ([209.226.175.26]:37595 "EHLO
	tomts6-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S129749AbRBMABI>; Mon, 12 Feb 2001 19:01:08 -0500
Date: Mon, 12 Feb 2001 19:01:12 -0500 (EST)
From: Scott Murray <scott@spiteful.org>
To: Chris Funderburg <chris@Funderburg.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: opl3sa not detected anymore
In-Reply-To: <Pine.LNX.4.30.0102122311180.1057-100000@pikachu.bti.com>
Message-ID: <Pine.LNX.4.30.0102121846040.10962-100000@godzilla.spiteful.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Feb 2001, Chris Funderburg wrote:

>
> After the updates to the opl3sa2 driver (2.4.2-pre3?) my card isn't being
> detected anymore.  Are there further updates to come, or do I need to
> change the settings?  The driver is being loaded as a module with the
> following in /etc/modules.conf:
[snip]
> The midi works fine, but 'modprobe sound' reports:
>
> opl3sa2: No cards found
> opl3sa2: 0 PnP card(s) found.

If you've configured ISA PnP support into the kernel, then the driver
ignores those settings unless you specify isapnp=0.  What I'd suggest
is that you try disabling the configuration done by the isapnp tools,
which can be done on RedHat and derived systems by renaming your
/etc/isapnp.conf to something else.  There seem to be some issues
with resetting the PnP configuration with isapnp after the in-kernel
ISA PnP driver has done its stuff, as a couple of other people have
mentioned similiar problems.

Scott


-- 
=============================================================================
Scott Murray                                        email: scott@spiteful.org
http://www.spiteful.org (coming soon)                 ICQ: 10602428
-----------------------------------------------------------------------------
     "Good, bad ... I'm the guy with the gun." - Ash, "Army of Darkness"

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/
