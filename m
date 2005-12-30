Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750820AbVL3Mok@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750820AbVL3Mok (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 07:44:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751253AbVL3Mok
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 07:44:40 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:63963 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750820AbVL3Moj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 07:44:39 -0500
Subject: Re: PROBLEM: cannot boot 2.6.15-rc6 on Opteron machine
From: Arjan van de Ven <arjan@infradead.org>
To: Thomas Molina <tmolina@cablespeed.com>
Cc: Erez Zilber <erezz@voltaire.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.63.0512300725300.5860@dad.localdomain>
References: <43B3CA9E.7000804@voltaire.com>
	 <Pine.LNX.4.63.0512300725300.5860@dad.localdomain>
Content-Type: text/plain
Date: Fri, 30 Dec 2005 13:44:30 +0100
Message-Id: <1135946670.2941.21.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.8 (--)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-12-30 at 07:31 -0500, Thomas Molina wrote:
> On Thu, 29 Dec 2005, Erez Zilber wrote:
> 
> > Hi,
> > 
> > I've downloaded kernel 2.6.15-rc6 (had the same problem with rc7) and built it
> > on RHAS 4:
> > 
> > When I did that on an Opteron machine, after rebooting and selecting the
> > 2.6.15-rc6 entry in the grub menu, I get the following:
> > 
> > Uncompressing Linux... Ok, booting the kernel.
> > Kernel panic - not syncing: VFS: unable to mount root fs on unknown-block(0,0)
> > 
> > I made sure that ext2 is compiled with the kernel (not as a module).
> > 
> > When I do the same on an emt64 machine, everything works ok. Any idea?
> 
> Check on your /boot/grub.config.  The above error message is typically 
> seen when the root= parameter points to a symbolic disk label instead of a 
> specific disk such as /dev/hda1.  I'm not sure what the procedure for 
> updating where the label points (possibly a mkinitrd) because I normally 
> change the grub.conf to point to a specific disk.

there is no such procedure, because the disk labels are... ON THE DISK.
And the initrd reads them from all the disks at boot time to find the
one needed. This means that if your disk changes name (for example
because of a scsi bus order change or because of a different order you
load the device drivers... or even if you forget to compile the sata
drivers and suddenly the disk goes from /dev/sda to /dev/hda).... things
just remain working



