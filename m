Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315429AbSFTSgG>; Thu, 20 Jun 2002 14:36:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315424AbSFTSgF>; Thu, 20 Jun 2002 14:36:05 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:58896 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S315423AbSFTSgD>; Thu, 20 Jun 2002 14:36:03 -0400
Date: Thu, 20 Jun 2002 11:36:25 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Patrick Mansfield <patmans@us.ibm.com>
cc: Andries Brouwer <aebr@win.tue.nl>, Martin Schwenke <martin@meltin.net>,
       Kurt Garloff <garloff@suse.de>,
       Linux kernel list <linux-kernel@vger.kernel.org>,
       Linux SCSI list <linux-scsi@vger.kernel.org>,
       Patrick Mochel <mochel@osdl.org>
Subject: Re: [PATCH] /proc/scsi/map
In-Reply-To: <20020620105233.A5506@eng2.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.44.0206201133180.8225-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 20 Jun 2002, Patrick Mansfield wrote:
>
> With Mike Sullivan'a patch for SCSI driverfs support:
>
> http://marc.theaimsgroup.com/?l=linux-scsi&m=102434655912858&w=2

Interesting, it does seem to set up most of the obvious stuff.

SCSI people, how does that patch look to you? Apparently it does
everything the scsimap thing does, in a way that is certainly acceptable
to me.

I personally think that the biggest problem with driverfs is it's lack of
a 2.4.x counterpart. Although the filesystem itself should be fairly easy
to port, moving around all the pci device structure members etc in order
to embed "struct device" into the PCI structure sounds like something you
definitely don't want to do in 2.4.x.

		Linus

