Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276734AbRJPVTC>; Tue, 16 Oct 2001 17:19:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276736AbRJPVSv>; Tue, 16 Oct 2001 17:18:51 -0400
Received: from aslan.scsiguy.com ([63.229.232.106]:40713 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S276734AbRJPVSh>; Tue, 16 Oct 2001 17:18:37 -0400
Message-Id: <200110162118.f9GLIwY74376@aslan.scsiguy.com>
To: christophe =?iso-8859-1?Q?barb=E9?= <christophe.barbe@lineo.fr>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] export pci_table in aic7xxx for Hotplug 
In-Reply-To: Your message of "Tue, 16 Oct 2001 22:50:49 +0200."
             <20011016225049.A996@online.fr> 
Date: Tue, 16 Oct 2001 15:18:58 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Ok I switch ON the light in my brain and things are better now.
>
>The PCI layer notify the driver that one of its devices has been
>removed.
>This is done with the remove function in the pci_driver struct.
>
>In the case of the aic7xxx this is the function
>ahc_linux_pci_dev_remove().
>
>I should, at this point, precise that I use the driver v6.2.4.
>
>I look in the code but it looks like this part of the code is broken.

How so?  Because of the panic or something evident in the code?
I'm always interested in bug reports. 8-)

>Please Justin let me 1 month before starting looking at it. Otherwise I
>have no chance to find a bug by myself.

Well, it will be a few days before I get a laptop setup to test this
on, but from what I can tell, we properly unregister our bus from the
SCSI subsystem, but the actual devices hanging off the bus are never
removed.  I would expect the mid-layer to take care of this.

--
Justin
