Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751137AbWDFRqv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751137AbWDFRqv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 13:46:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751292AbWDFRqv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 13:46:51 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:17936 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1751137AbWDFRqu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 13:46:50 -0400
Date: Thu, 6 Apr 2006 19:46:44 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: Greg KH <greg@kroah.com>, anton@samba.org, akpm@osdl.org, gregkh@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix pciehp driver on non ACPI systems
Message-ID: <20060406174644.GD6598@mars.ravnborg.org>
References: <20060406101731.GA9989@krispykreme> <20060406160527.GA2965@kroah.com> <20060406104113.08311cdc.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060406104113.08311cdc.rdunlap@xenotime.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 06, 2006 at 10:41:13AM -0700, Randy.Dunlap wrote:
> On Thu, 6 Apr 2006 09:05:27 -0700 Greg KH wrote:
> 
> > On Thu, Apr 06, 2006 at 08:17:31PM +1000, Anton Blanchard wrote:
> > > 
> > > Wrap some ACPI specific headers. ACPI hasnt taken over the whole world yet.
> > > 
> > > Signed-off-by: Anton Blanchard <anton@samba.org>
> > > ---
> > > 
> > > Index: kernel/drivers/pci/hotplug/pciehp_hpc.c
> > > ===================================================================
> > > --- kernel.orig/drivers/pci/hotplug/pciehp_hpc.c	2006-04-06 05:01:32.000000000 -0500
> > > +++ kernel/drivers/pci/hotplug/pciehp_hpc.c	2006-04-06 05:09:48.501122395 -0500
> > > @@ -38,10 +38,14 @@
> > >  
> > >  #include "../pci.h"

When one introdues relative apths like the above this is a good sign
that the header file ought to move to a common place somewhere in
include/.

	Sam
