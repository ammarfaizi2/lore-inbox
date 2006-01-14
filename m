Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423245AbWANBVE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423245AbWANBVE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 20:21:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423253AbWANBVE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 20:21:04 -0500
Received: from ns2.suse.de ([195.135.220.15]:36067 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1423245AbWANBVC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 20:21:02 -0500
From: Andi Kleen <ak@suse.de>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH 2.6.15] ia64: use i386 dmi_scan.c
Date: Sat, 14 Jan 2006 02:19:39 +0100
User-Agent: KMail/1.8
Cc: Matt Domsch <Matt_Domsch@dell.com>, linux-ia64@vger.kernel.org,
       openipmi-developer@lists.sourceforge.net, akpm@osdl.org,
       "Tolentino, Matthew E" <matthew.e.tolentino@intel.com>,
       linux-kernel@vger.kernel.org
References: <20060104221627.GA26064@lists.us.dell.com> <20060106223932.GB9230@lists.us.dell.com> <200601131724.42054.bjorn.helgaas@hp.com>
In-Reply-To: <200601131724.42054.bjorn.helgaas@hp.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200601140219.39765.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 14 January 2006 01:24, Bjorn Helgaas wrote:
> On Friday 06 January 2006 15:39, Matt Domsch wrote:
> > diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
> > ...
> > +config DMI
> > +       bool
> > +       default y
>
> Should we have a way to turn this off?

At least on i386/x86-64 it is largely used for hardware/firmware bug 
workaround and these have been traditionally always compiled in

Or do you want to spend a lot of time on a bug report from
a user only to discover they didn't enable the workarounds for
their particular platform?

You might not need that right now but I can predict that 
at some point you'll need board specific workarounds - and
then it will be very useful to have.

>
> > diff --git a/arch/ia64/kernel/Makefile b/arch/ia64/kernel/Makefile
> > ...
> > +dmi_scan-y                     += ../../i386/kernel/dmi_scan.o
>
> Ugh.  I really hate this sort of sharing.  Could dmi_scan.c go in
> drivers/firmware/ or something instead?

Well, i suppose it will be more common in the future. Perhaps
get over that particular hatered?

-Andi
