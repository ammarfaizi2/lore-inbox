Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751508AbWHaBRJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751508AbWHaBRJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 21:17:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751565AbWHaBRJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 21:17:09 -0400
Received: from atpro.com ([12.161.0.3]:2308 "EHLO atpro.com")
	by vger.kernel.org with ESMTP id S1751508AbWHaBRI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 21:17:08 -0400
Date: Wed, 30 Aug 2006 21:16:45 -0400
From: Jim Crilly <jim@why.dont.jablowme.net>
To: David Lang <dlang@digitalinsight.com>
Cc: Sven Luther <sven.luther@wanadoo.fr>, Olaf Hering <olaf@aepfle.de>,
       Michael Buesch <mb@bu3sch.de>, Greg KH <greg@kroah.com>,
       Oleg Verych <olecom@flower.upol.cz>,
       James Bottomley <James.Bottomley@steeleye.com>,
       debian-kernel@lists.debian.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MODULE_FIRMWARE for binary firmware(s)
Message-ID: <20060831011645.GF2986@mail>
Mail-Followup-To: David Lang <dlang@digitalinsight.com>,
	Sven Luther <sven.luther@wanadoo.fr>, Olaf Hering <olaf@aepfle.de>,
	Michael Buesch <mb@bu3sch.de>, Greg KH <greg@kroah.com>,
	Oleg Verych <olecom@flower.upol.cz>,
	James Bottomley <James.Bottomley@steeleye.com>,
	debian-kernel@lists.debian.org, linux-kernel@vger.kernel.org
References: <20060829201314.GA28680@aepfle.de> <Pine.LNX.4.63.0608291341060.30381@qynat.qvtvafvgr.pbz> <20060830054433.GA31375@aepfle.de> <Pine.LNX.4.63.0608301048180.31356@qynat.qvtvafvgr.pbz> <20060830181310.GA11213@powerlinux.fr> <Pine.LNX.4.63.0608301119170.31356@qynat.qvtvafvgr.pbz> <20060830191544.GA17203@powerlinux.fr> <Pine.LNX.4.63.0608301219520.31356@qynat.qvtvafvgr.pbz> <20060830205739.GA26475@powerlinux.fr> <Pine.LNX.4.63.0608301408590.31356@qynat.qvtvafvgr.pbz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0608301408590.31356@qynat.qvtvafvgr.pbz>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/30/06 02:11:51PM -0700, David Lang wrote:
> >Yep, but initramfs is initialized ways earlier than normal userspace.
> >
> >>however this is not soon enough to supply the firmware for devices like
> >>this.
> >
> >Are you sure of this ? This is somewhat contrary to what i have heard, and 
> >it
> >sure would make sense to be able to access the initramfs ramdisk much 
> >earlier.
> 
> I could easily be wrong about this. can someone who really knows weigh in 
> on this?
> 

>From looking at my current boot logs it appears that initramfs is setup right
after the CPUs are brought up, so it should be available before any drivers
are initialized and they should be able to get to their firmware in the
initramfs as long as it's in the right path in the image.  I don't have any
drivers that require external firmware to test that theory out with though.

[4294668.249000] checking TSC synchronization across 2 CPUs: passed.
[4294668.250000] Brought up 2 CPUs
[4294668.277000] migration_cost=1000
[4294668.277000] checking if image is initramfs... it is
[4294668.452000] Freeing initrd memory: 1358k freed
[4294668.452000] NET: Registered protocol family 16
[4294668.453000] ACPI: bus type pci registered
[4294668.453000] PCI: PCI BIOS revision 2.10 entry at 0xfd7e0, last bus=1

Jim.
