Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261711AbTIPAtR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 20:49:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261712AbTIPAtQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 20:49:16 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:24080 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S261711AbTIPAtO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 20:49:14 -0400
Date: Mon, 15 Sep 2003 20:26:54 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Adrian Bunk <bunk@fs.tum.de>
cc: John Bradford <john@grabjohn.com>, zwane@linuxpower.ca,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6 workaround for Athlon/Opteron prefetch errata
In-Reply-To: <20030915205522.GP126@fs.tum.de>
Message-ID: <Pine.LNX.3.96.1030915202130.22907B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Sep 2003, Adrian Bunk wrote:

> On Mon, Sep 15, 2003 at 07:32:49AM +0100, John Bradford wrote:
> >...
> > It should be possible, and straightforward, to compile a kernel which:
> > 
> > 1. Supports, (I.E. has workarounds for), any combination of CPUs.
> >    E.G. a kernel which supports 386s, and Athlons _only_ would not
> >    need the F00F bug workaround.  Currently '386' kernels include it,
> >    because '386' means 'support 386 and above processors'.
> > 
> > 2. Has compiler optimisations for one particular CPU.
> >    E.G. the 386 and Athlon supporting kernel above could have
> >    alignment optimised for either 386 or Athlon.
> >...
> 
> That's the point where even I consider such a system to be too complex.

How does it strike you to have these:
 - compile support for any CPU which doesn't break the target
   (including slow it in some serious way)
 - drop support for any CPU except the target

It seems to me that this is what the vendors want (as general as possible)
and the size limited users want (small is beautiful).

Fitting the code to this model could be done gradually and hopefully with
some macros to prevent too much ugly ifdef code.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

