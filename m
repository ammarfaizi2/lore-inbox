Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270451AbRHUBVQ>; Mon, 20 Aug 2001 21:21:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270460AbRHUBVH>; Mon, 20 Aug 2001 21:21:07 -0400
Received: from Overkill.EnterZone.Net ([66.35.65.2]:21572 "EHLO
	Overkill.EnterZone.Net") by vger.kernel.org with ESMTP
	id <S270451AbRHUBU6>; Mon, 20 Aug 2001 21:20:58 -0400
Date: Mon, 20 Aug 2001 21:21:02 -0400 (EDT)
From: John Fraizer <atm@EnterZone.Net>
To: "Adam J. Richter" <adam@yggdrasil.com>
cc: linux-atm-general@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Linux-ATM-General] PATCH: linux-2.4.9/drivers/atm to new
 module_{init,exit} + some pci_device_id tables
In-Reply-To: <20010820075826.A368@baldur.yggdrasil.com>
Message-ID: <Pine.LNX.4.21.0108202119020.29741-100000@Overkill.EnterZone.Net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Just a quick question.  Please be gentl.  I'm not a kernel hack.  I just
want to make sure that it will still be possible to build a monolythic
kernel with ATM support.  If not, that is a BAD thing.  



On Mon, 20 Aug 2001, Adam J. Richter wrote:

> 	The following patch moves linux-2.4.9/drivers/atm
> to the relatively new module_{init,exit} interface, simplifying
> the code and removing the reference to the ATM drivers from
> linux/drivers/genhd.c (this is partly motivated by my effort to get
> rid of genhd.c).  The changes also include some pci_device_id tables,
> which enable automatic loading of the modules via pcimodules (or
> a similar program).  These changes are also all steps toward porting
> the atm drivers to the new PCI interface.  In the case zatm.c, I
> have actually ported it to the new PCI interface, although it
> shares the stock zatm driver's deficiency of not supporting
> module removal.
> 
> 	Note that this change deletes linux-2.4.9/drivers/atmdev_init.c,
> since the conversion to module_{init,exit} completely obseletes that file.
> 
> 	If these changes look OK, I would like to get them
> into the stock kernel.  If there is a maintainer on linux-atm-general
> who shepherds these patches to Alan and Linus, and if these changes
> are good, please let me know if you are going to "officially" send them
> to Alan and Linus or if you want me to do so or if there is some other
> procedure that I should follow.
> 
> -- 
> Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
> adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
> +1 408 261-6630         | g g d r a s i l   United States of America
> fax +1 408 261-6631      "Free Software For The Rest Of Us."
> 
> _______________________________________________
> Linux-atm-general mailing list
> Linux-atm-general@lists.sourceforge.net
> http://lists.sourceforge.net/lists/listinfo/linux-atm-general
> 

