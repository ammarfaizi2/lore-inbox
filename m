Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261421AbTIOTUb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 15:20:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261428AbTIOTUb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 15:20:31 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:22660 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S261421AbTIOTUa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 15:20:30 -0400
Date: Mon, 15 Sep 2003 20:34:18 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200309151934.h8FJYI84002544@81-2-122-30.bradfords.org.uk>
To: davidsen@tmr.com, john@grabjohn.com
Subject: Re: [PATCH] 2.6 workaround for Athlon/Opteron prefetch errata
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
       zwane@linuxpower.ca
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > I still like the idea of a single config variable to remove all special
> > > case code for non-configured CPUs, call it NO_BLOAT or MINIMALIST_KERNEL
> > > or EMBEDDED_HELPER as you will. The embedded folks would then have a good
> > > handle to do the work and identify sections to be so identified.
> > 
> > Removing the code for non-configured CPUs should be the default.  It's
> > common sense - if you configure a kernel to support Athlons only, why
> > have PIV workarounds in there, unless you're actually debugging a
> > kernel problem?
>
> If we adopt a bit-per-CPUtype or similar approach maybe. But then you have
> to go back and test each code section to see if it applies to multiple
> types. I'm happy to have existing code stay, as long as there's a way to
> clean it up (or attempt to do so). I don't think making super clean is
> compatible with stability, and I'd rather see sections marked as
> architecture specific as the performance and embedded folks look for
> places to clean up the kernel.

Yes, you're right, from a stability point of view I was being a bit
impractical.  Any idea how many developers are actually regularly
testing code on 386s these days, by the way?

> I'm not on a crusade to get the tiny kernel, just to (a) provide a path
> for future work started by the config "feature removal" menu, and (b)
> avoid inserting a chunk of very specific code without ifdefs, now that
> developers have started thinking about putting the kernel on a diet. I
> don't suggest we do anything which will break existing code, just not
> introduce new bloat right now.

Yeah, breaking existing code can wait until 2.7 :-).  Putting the
hooks in for future code removal is all we need to do - until somebody
actually feels the need to trim something, it might as well stay.

John.
