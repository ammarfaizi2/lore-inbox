Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946392AbWJ0LOy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946392AbWJ0LOy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 07:14:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946401AbWJ0LOy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 07:14:54 -0400
Received: from witte.sonytel.be ([80.88.33.193]:4265 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S1946392AbWJ0LOx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 07:14:53 -0400
Date: Fri, 27 Oct 2006 13:14:46 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
cc: Dick Streefland <dick.streefland@altium.nl>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       sam@ravnborg.org
Subject: Re: What about make mergeconfig ?
In-Reply-To: <Pine.LNX.4.61.0610271154260.17570@yvahk01.tjqt.qr>
Message-ID: <Pine.LNX.4.62.0610271311260.23917@pademelon.sonytel.be>
References: <3d6d.453f3a0f.92d2c@altium.nl> <1161755164.22582.60.camel@localhost.localdomain>
 <3d6d.453f3a0f.92d2c@altium.nl> <Pine.LNX.4.61.0610251336580.23137@yvahk01.tjqt.qr>
 <31ed.453f5399.96651@altium.nl> <Pine.LNX.4.61.0610261000210.29875@yvahk01.tjqt.qr>
 <Pine.LNX.4.62.0610261102520.1555@pademelon.sonytel.be>
 <Pine.LNX.4.61.0610261322120.29875@yvahk01.tjqt.qr>
 <Pine.LNX.4.62.0610261357080.1555@pademelon.sonytel.be>
 <Pine.LNX.4.61.0610271154260.17570@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Oct 2006, Jan Engelhardt wrote:
> >> >What about RCS merge?
> >> 
> >> I take it we do not want to depend on too many tools (remember the 
> >> kconfig implementation language debate).
> >
> >If you have CVS installed, you have RCS merge.
> 
> 11:54 ichi:~ > rpm -q cvs rcs
> cvs-1.12.12-19
> package rcs is not installed
> 
> 11:54 ichi:~ > gzip -cd /ARCHIVES.gz | grep "/merge$"
> ./CD1/suse/i586/rcs-5.7-879.i586.rpm:
>     -rwxr-xr-x    1 root    root 45252 May  2 09:42 /usr/bin/merge
> 
> CVS does not need RCS.

OK, so CVS assimilated RCS merge internally.

> >>>merge -p other.config .config.old .config > other.config.new
> >> 
> >> This also does not seem conflict-safe.
> >
> >Indeed, you can still have conflicts, which you have to resolve manually.
> >
> >But it depends on what you want to achieve: do you want to set each config
> >option in the destination config to max(config1.option, config2.option), or do
> >you want to apply the recent changes for one config (which may include
> >disabling options) to another config?
> 
> In my case, the latter.
> 
> >For the latter, merge should work fine.
> 
> Is merge a lot different from what `patch` is doing?

Yes, it does 3-way merges (merge `my' version with `your' version using a
common ancestor). I.e. it's better in resolving conflicts than patch.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
