Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290211AbSBKTV3>; Mon, 11 Feb 2002 14:21:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290218AbSBKTVV>; Mon, 11 Feb 2002 14:21:21 -0500
Received: from rj.SGI.COM ([204.94.215.100]:6290 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S290211AbSBKTVG>;
	Mon, 11 Feb 2002 14:21:06 -0500
Date: Mon, 11 Feb 2002 13:17:44 -0600
From: John Hesterberg <jh@sgi.com>
To: torvalds@transmeta.com, marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org, linux-ia64@linuxia64.org
Subject: driver location for platform-specific drivers
Message-ID: <20020211131744.A16032@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus & Marcelo,

For SGI's upcoming Linux platform (nicknamed Scalable Node, or SN),
we have some platform specific device drivers.  Where should these go?
I see several precedents in the current kernels.

    1) Integrate in drivers/*.
       Integrate SN drivers into appropriate directories.
       Put them directly in char, net, misc, etc., as appropriate.

    2) Company (sgi) directory.
       There is already an sgi directory, strangely enough.
       I *think* this was meant to be a platform directory for the
       discontinued SGI 320/540 Visual Workstations.  However, maybe
       it was intended to be a new precedent of company specific
       directories.  In this case, we'd probably create a platform
       directory under the company directory, so there would likely
       be drivers/sgi/sn (some of our SN drivers are here today in
       our internal development tree).  However, there is no other
       precedent for "company" subdirectories under drivers.  Apple
       didn't do it.  IBM didn't do it.  HP hasn't done it.  Was the
       drivers/sgi directory really intended to start a new
       precedent of company specific directories under drivers?

    3) New platform directory.
       Create a platform directory for SN, probably drivers/sn.
       There is precedence for this with the drivers/macintosh
       and drivers/s390.  Also, as noted, the SGI Visual Workstation
       drivers are in drivers/sgi.  In this case, it might also make
       sense to rename drivers/sgi to drivers/visws to indicate
       these are drivers for the Visual Workstation platform, and
       not generic SGI drivers.

    4) New architecture directory.
       Another suggestion is to create an architecture directory,
       in this case drivers/ia64/{char,net,etc.}/.

I'm happy with whatever you'll accept.  To give you something to
either agree with or shoot down, I'll suggest #3.  SGI's Scalable
Node product will be different enough, with enough platform specific
drivers, that it justifies it's own subdirectory, and that this
should be called drivers/sn.

John Hesterberg
jh@sgi.com
