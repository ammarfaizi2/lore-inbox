Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261833AbVBXRLp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261833AbVBXRLp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 12:11:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262420AbVBXRLp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 12:11:45 -0500
Received: from smtp3.wanadoo.fr ([193.252.22.28]:3377 "EHLO smtp3.wanadoo.fr")
	by vger.kernel.org with ESMTP id S261833AbVBXRLe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 12:11:34 -0500
X-ME-UUID: 20050224171131509.7C5691C0035B@mwinf0306.wanadoo.fr
Date: Thu, 24 Feb 2005 18:01:50 +0100
To: Meelis Roos <mroos@linux.ee>
Cc: Sven Luther <sven.luther@wanadoo.fr>, Tom Rini <trini@kernel.crashing.org>,
       linuxppc-dev@ozlabs.org, Sven Hartge <hartge@ds9.gnuu.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Christian Kujau <evil@g-house.de>
Subject: Re: [PATCH 2.6.10-rc3][PPC32] Fix Motorola PReP (PowerstackII Utah) PCI IRQ map
Message-ID: <20050224170150.GA7746@pegasos>
References: <20041206185416.GE7153@smtp.west.cox.net> <Pine.SOC.4.61.0502221031230.6097@math.ut.ee> <20050224074728.GA31434@pegasos> <Pine.SOC.4.61.0502241746450.21289@math.ut.ee> <20050224160657.GB11197@pegasos> <Pine.SOC.4.61.0502241832510.21289@math.ut.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <Pine.SOC.4.61.0502241832510.21289@math.ut.ee>
User-Agent: Mutt/1.5.6+20040907i
From: Sven Luther <sven.luther@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2005 at 06:34:03PM +0200, Meelis Roos wrote:
> >Oh, damn, need to fix my daily builder, should be ok for tomorrow. IN the
> >meanwhile, you can try :
> >
> > http://people.debian.org/~luther/d-i/images/2005-02-23/powerpc/netboot/vmlinuz-prep.initrd
> 
> This seems to work fine: onboard scsi is OK, pci nic with de4x5 is OK 
> too. Haven't got more PCI cards in there currently.

Ok, can you now install the 2.6.10-3 package from : 

  http://people.debian.org/~luther/powerpc/2.6.10-3 

(you need kernel-image-2.6.10-powerpc and mkvmlinuz), call mkvmlinuz on it (or
add it to kernel-img.conf as postinst_hook=/usr/sbin/mkvmlinuz).

You may probably want also to modify /etc/mkinitrd/mkinitrd:MODULES_DEP to dep
instead of MOST, or you may hit size problems with your initrd, i would be
interested in knowing that.

Then just dd your /boot/vmlinuz-2.6.10-powerpc to your prep partition, or
better yet to a tftp server, and try it out. If the scsi problems are there,
can you fill a bug report against kernel-source-2.6.10 ? 

Friendly,

Sven Luther

