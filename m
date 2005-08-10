Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965140AbVHJO7O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965140AbVHJO7O (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 10:59:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965142AbVHJO7O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 10:59:14 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:27087 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S965140AbVHJO7N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 10:59:13 -0400
Date: Wed, 10 Aug 2005 16:01:54 +0100
From: Matthew Wilcox <matthew@wil.cx>
To: Kristen Accardi <kristen.c.accardi@intel.com>
Cc: pcihpd-discuss@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       greg@kroah.com, rajesh.shah@intel.com
Subject: Re: [Pcihpd-discuss] [PATCH] use bus_slot number for name
Message-ID: <20050810150154.GB16724@parcelfarce.linux.theplanet.co.uk>
References: <1123269366.8917.39.camel@whizzy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1123269366.8917.39.camel@whizzy>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 05, 2005 at 12:16:06PM -0700, Kristen Accardi wrote:
> For systems with multiple hotplug controllers, you need to use more than
> just the slot number to uniquely name the slot.  Without a unique slot
> name, the pci_hp_register() will fail.  This patch adds the bus number
> to the name.

That doesn't make much sense.  The slot number should at least be unique
to the chassis, if not to the whole machine.  HP's large machines with
multiple cabinets encode the cabinet number in the return from _SUN.
It ends up as something like 80103 for a large machine while still being
merely slot 3 for the smaller machines.

IOW, I think this is a firmware bug which needs to be fixed there.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
