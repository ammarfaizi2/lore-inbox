Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265857AbTAOJEy>; Wed, 15 Jan 2003 04:04:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265885AbTAOJEy>; Wed, 15 Jan 2003 04:04:54 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:6072 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S265857AbTAOJEw>;
	Wed, 15 Jan 2003 04:04:52 -0500
From: Mikael Pettersson <mikpe@csd.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15909.9796.157927.447889@harpo.it.uu.se>
Date: Wed, 15 Jan 2003 10:13:40 +0100
To: Jens Taprogge <taprogge@idg.rwth-aachen.de>
Cc: zwane@holomorphy.com, bvermeul@blackstar.nl, ya@slamail.org,
       linux-kernel@vger.kernel.org
Subject: Re: [BUG] cardbus/hotplugging still broken in 2.5.56
In-Reply-To: <20030115081109.GA3839@valsheda.taprogge.wh>
References: <20030115081109.GA3839@valsheda.taprogge.wh>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Taprogge writes:
 > The cardbus problems are caused by 
 > 
 > ChangeSet@1.797.145.6  2002-11-25 18:31:10-08:00 davej@codemonkey.org.uk
 > 
 > as far as I can tell. 
 > 
 > pci_enable_device() will fail at least on i386 (see
 > arch/i386/pci/i386.c: pcibios_enable_resource (line 260)) if the
 > resources have not been assigned previously. Hence the ostensible
 > resource collisions.
 > 
 > The attached patch should fix the problem.
 > 
 > I have send the patch to Dave Jones some time ago but did not hear from
 > him yet.
 > 
 > I am not subscribed to the list so please cc me on replys. 

Thanks. Your patch fixed the cardbus hotplug issue perfectly on my laptop.
It survives multiple insert/eject cycles without any problems.

The patch posted by Yaacov Akiba Slama today also fixed cardbus hotplug
for me, but with his patch the kernel still prints "PCI: No IRQ known for
interrupt pin A of device xx:xx.x. Please try using pci=biosirq" when the
cardbus NIC is inserted; Jens Taprogge's patch silenced that warning.

/Mikael
