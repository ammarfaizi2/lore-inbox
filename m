Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750716AbVHPWrf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750716AbVHPWrf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 18:47:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750717AbVHPWrf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 18:47:35 -0400
Received: from fmr18.intel.com ([134.134.136.17]:14468 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750716AbVHPWre (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 18:47:34 -0400
Subject: Re: [Pcihpd-discuss] [PATCH] use bus_slot number for name
From: Kristen Accardi <kristen.c.accardi@intel.com>
To: Matthew Wilcox <matthew@wil.cx>
Cc: pcihpd-discuss@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       greg@kroah.com, rajesh.shah@intel.com
In-Reply-To: <20050810150154.GB16724@parcelfarce.linux.theplanet.co.uk>
References: <1123269366.8917.39.camel@whizzy>
	 <20050810150154.GB16724@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 16 Aug 2005 15:47:20 -0700
Message-Id: <1124232440.6584.75.camel@whizzy>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
X-OriginalArrivalTime: 16 Aug 2005 22:47:21.0138 (UTC) FILETIME=[763BF120:01C5A2B4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-08-10 at 16:01 +0100, Matthew Wilcox wrote:
> On Fri, Aug 05, 2005 at 12:16:06PM -0700, Kristen Accardi wrote:
> > For systems with multiple hotplug controllers, you need to use more than
> > just the slot number to uniquely name the slot.  Without a unique slot
> > name, the pci_hp_register() will fail.  This patch adds the bus number
> > to the name.
> 
> That doesn't make much sense.  The slot number should at least be unique
> to the chassis, if not to the whole machine.  HP's large machines with
> multiple cabinets encode the cabinet number in the return from _SUN.
> It ends up as something like 80103 for a large machine while still being
> merely slot 3 for the smaller machines.
> 
> IOW, I think this is a firmware bug which needs to be fixed there.
> 

Just wanted to let you know that I'm not ignoring your comment :).  I'm
checking now to see if the firmware is required to make the slot number
unique across all controllers.  I also am expecting a hardware/firmware
update for the machine that exhibited this behavior, and so will retest
when I get it and let you know.  although, I'm not sure if it's a good
idea to trust the BIOS to do this properly even if it's required.

