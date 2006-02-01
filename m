Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030384AbWBARUg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030384AbWBARUg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 12:20:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030383AbWBARUg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 12:20:36 -0500
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:4054 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP
	id S1030380AbWBARUf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 12:20:35 -0500
X-ORBL: [67.117.73.34]
Date: Wed, 1 Feb 2006 09:20:13 -0800
From: Tony Lindgren <tony@atomide.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Joerg Sommrey <jo@sommrey.de>, linux-kernel@vger.kernel.org,
       linux-acpi@vger.kernel.org, arjan@infradead.org
Subject: Re: [PATCH] amd76x_pm: C3 powersaving for AMD K7
Message-ID: <20060201172013.GA15939@atomide.com>
References: <20060131185516.GA21769@sommrey.de> <20060131193446.7904ac6f.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060131193446.7904ac6f.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew Morton <akpm@osdl.org> [060131 19:35]:
> Joerg Sommrey <jo@sommrey.de> wrote:
> >
> > This is a processor idle module for AMD SMP 760MP(X) based systems.
> >  The patch was originally written by Tony Lindgren and has been around
> >  since 2002.  It enables C2 mode on AMD SMP systems and thus saves
> >  about 70 - 90 W of energy in the idle mode compared to the default idle
> >  mode.  The idle function has been rewritten and is now free of locking
> >  issues and is independent from the number of CPUs.  The impact
> >  from this module on the system clock and on i/o transfer are now fairly
> >  low.
> > 
> >  This patch can also be found at
> >  http://www.sommrey.de/amd76x_pm/amd76x_pm-2.6.15-4.patch
> > 
> >  In this version more locking was added to make sure all or no CPU enter
> >  C3 mode.
> > 
> >  Signed-off-by: Joerg Sommrey <jo@sommrey.de>
> 
> Thanks.  I'll merge this into -mm and shall plague the ACPI guys with it. 
> They have said discouraging things about board-specific drivers in the
> past.  We shall see.
> 
> Tony, could you please review section 11 of Documentation/SubmittingPatches
> and if OK, send a Signed-off-by:?

Sure, here you are:

Signed-off-by: Tony Lindgren <tony@atomide.com>
 
> Some minor pointlets, and a bug:
> 
> 
> Should CONFIG_AMD76X_PM depend on ACPI?

It works also without ACPI.

But in the long run something like this could be added for ACPI to allow
easy addition of custom PM modules. That was discussed briefly on the ACPI
list and people seemed to be OK with adding system for custom PM modules.

And if it was integrated with ACPI, only enabling the C states should be
enough, and then ACPI would just know how to use the C states...

Regards,

Tony
