Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757839AbWK0SEa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757839AbWK0SEa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 13:04:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757861AbWK0SEa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 13:04:30 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:43427 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1757839AbWK0SE3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 13:04:29 -0500
Date: Mon, 27 Nov 2006 18:10:33 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: avl@logic.at
Cc: linux-kernel@vger.kernel.org
Subject: Re: Allow turning off hpa-checking.
Message-ID: <20061127181033.58e72d9a@localhost.localdomain>
In-Reply-To: <20061127175647.GD2352@gamma.logic.tuwien.ac.at>
References: <20061120165601.GS6851@gamma.logic.tuwien.ac.at>
	<20061120172812.64837a0a@localhost.localdomain>
	<20061121115117.GU6851@gamma.logic.tuwien.ac.at>
	<20061121120614.06073ce8@localhost.localdomain>
	<20061122105735.GV6851@gamma.logic.tuwien.ac.at>
	<20061123170557.GY6851@gamma.logic.tuwien.ac.at>
	<20061127130953.GA2352@gamma.logic.tuwien.ac.at>
	<20061127133044.28b8b4ed@localhost.localdomain>
	<20061127160144.GB2352@gamma.logic.tuwien.ac.at>
	<20061127163328.3f1c12eb@localhost.localdomain>
	<20061127175647.GD2352@gamma.logic.tuwien.ac.at>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> What else (if not sector remapping) could make the "current"
> size gradually smaller between reboots. And why is "native"
> size still constant?  And why does now even access to the but-last
> native sector fail? The explanation with block-reads no longer
> works.

The presented size of an ATA disk is constant. It keeps additional space
for error blocks. The HPA merely tells the disk to lie about its size.
 
> > This is a matter for the partitioning tool. You don't know at boot time
> > what you wish to do with the HPA so a boot option is inappropriate.
> 
> If I boot linux (e.g. from CD) on some precious windows-machine,
> I do know that at boot time. Ditto if I connect a foreign
> windows-disk in my machine (ata is afaik not yet hot-pluggable),
> I'm also bound to know that at boot time.

Some ATA is hot pluggable. The new libata stuff very much so (although it
at the moment doesn't handle HPA)
 
> There are also user-land tools (using ioctl) to manipulate 
> this, in case I change my mind lateron.
> 
> How should the partitioning tool know, if I want to ignore the
> HPA, or respect it (knowing it contains stuff that I might need in
> future).  Does there exist any that asks me?

I have no idea. If not perhaps one should be written.
