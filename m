Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261237AbTIOSbF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 14:31:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261244AbTIOSbF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 14:31:05 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:22543 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S261237AbTIOSbB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 14:31:01 -0400
Date: Mon, 15 Sep 2003 14:21:51 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: John Bradford <john@grabjohn.com>
cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
       zwane@linuxpower.ca
Subject: Re: [PATCH] 2.6 workaround for Athlon/Opteron prefetch errata
In-Reply-To: <200309151243.h8FCh8ne001294@81-2-122-30.bradfords.org.uk>
Message-ID: <Pine.LNX.3.96.1030915141415.20945B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Sep 2003, John Bradford wrote:

> > I still like the idea of a single config variable to remove all special
> > case code for non-configured CPUs, call it NO_BLOAT or MINIMALIST_KERNEL
> > or EMBEDDED_HELPER as you will. The embedded folks would then have a good
> > handle to do the work and identify sections to be so identified.
> 
> Removing the code for non-configured CPUs should be the default.  It's
> common sense - if you configure a kernel to support Athlons only, why
> have PIV workarounds in there, unless you're actually debugging a
> kernel problem?

If we adopt a bit-per-CPUtype or similar approach maybe. But then you have
to go back and test each code section to see if it applies to multiple
types. I'm happy to have existing code stay, as long as there's a way to
clean it up (or attempt to do so). I don't think making super clean is
compatible with stability, and I'd rather see sections marked as
architecture specific as the performance and embedded folks look for
places to clean up the kernel.

I'm not on a crusade to get the tiny kernel, just to (a) provide a path
for future work started by the config "feature removal" menu, and (b)
avoid inserting a chunk of very specific code without ifdefs, now that
developers have started thinking about putting the kernel on a diet. I
don't suggest we do anything which will break existing code, just not
introduce new bloat right now.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

