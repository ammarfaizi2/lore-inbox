Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261426AbUJESff@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261426AbUJESff (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 14:35:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261405AbUJESf0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 14:35:26 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:47524 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261426AbUJESfJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 14:35:09 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Patrick Gefre <pfg@sgi.com>
Subject: Re: [PATCH] 2.6 SGI Altix I/O code reorganization
Date: Tue, 5 Oct 2004 11:34:55 -0700
User-Agent: KMail/1.7
Cc: "Luck, Tony" <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
References: <B8E391BBE9FE384DAA4C5C003888BE6F0221C647@scsmsx401.amr.corp.intel.com> <4162E5F0.30104@sgi.com>
In-Reply-To: <4162E5F0.30104@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410051134.55652.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, October 5, 2004 11:20 am, Patrick Gefre wrote:
> > These others are outside of my area (well I *might* push
> > the drivers that are only used by SGI ... but hotplug
> > and qla1280 are definitely not mine).  So they need to be
> > split out into separate patches.
>
> As a general comment, the changes to these files are because of mods in the
> reorg code - so they are needed for this base but not in the older code.
> So, in my mind, it is a package - or should be taken as a whole. I can
> break them out, but I think they need to go together.

Yeah, that's fine, but it's easier to review and integrate if patches to 
update the API are separate files and mails (e.g. 2/3, 3/3, etc.).  Makes for 
more detailed changelog comments and makes changes in the bk tree much easier 
to track.  In general, the smaller, the better.

> >   drivers/char/mmtimer.c
>
> This is Jesse's code. We made an include file change. Is this OK Jesse ?

Yeah, that's fine.

> >   drivers/ide/pci/sgiioc4.c
>
> More Lindent mods. We took out the endian code - not needed anymore.

Sounds like that could be a separate cleanup patch.

> >   drivers/pci/hotplug/Kconfig
>
> Took out SGI PCI Hotplug. Since there isn't any code behind it - we will
> add it back in when we submit the code for it.

Sounds good, probably a separate patch too.

Thanks,
Jesse
