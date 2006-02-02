Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932083AbWBBPnK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932083AbWBBPnK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 10:43:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932084AbWBBPnK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 10:43:10 -0500
Received: from vbn.0050556.lodgenet.net ([216.142.194.234]:24448 "EHLO
	vbn.0050556.lodgenet.net") by vger.kernel.org with ESMTP
	id S932083AbWBBPnI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 10:43:08 -0500
Subject: Re: root=LABEL= problem [Was: Re: Linux Issue]
From: Arjan van de Ven <arjan@infradead.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "J.A. Magallon" <jamagallon@able.es>, Bernd Petrovitsch <bernd@firmix.at>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Jiri Slaby <xslaby@fi.muni.cz>,
       kavitha s <wellspringkavitha@yahoo.co.in>, linux-kernel@vger.kernel.org
In-Reply-To: <1138891308.9861.9.camel@localhost.localdomain>
References: <20060201114845.E41F222AF24@anxur.fi.muni.cz>
	 <Pine.LNX.4.61.0602011713410.22529@yvahk01.tjqt.qr>
	 <1138810616.16643.30.camel@tara.firmix.at>
	 <1138863107.3270.8.camel@laptopd505.fenrus.org>
	 <20060202091900.469e7394@werewolf.auna.net>
	 <1138891308.9861.9.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 02 Feb 2006 16:42:34 +0100
Message-Id: <1138894954.3043.12.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-02-02 at 14:41 +0000, Alan Cox wrote:
> On Iau, 2006-02-02 at 09:19 +0100, J.A. Magallon wrote:
> > > it's 100% done in the initrd.
> > 
> > Isn't this a matter of the bootloader ?
> 
> 
> The boot loader knows very little and the BIOS may not even be able to
> drive some of the hardware to go looking for volume labels. The sequence
> used is that the initrd is the root file system and contains application
> code run very early on in order to find out where the 'real' root fs is
> by label. Having mounted that it can then pivot_root() itself into the
> final desired configuration.
> 
> All userspace, and all the initrd building is done by a tool called
> mkinitrd.

... which gets done for you automatically if you use "make install" from
the kernel sources after building. In addition "make install" is nice
enough for you to add the new kernel to your bootloader.

(and no this isn't a kernel patch either; "make install" basically has a
hook for a distribution specific script to be run, which at least for
Fedora causes the initrd to be made and the kernel+initrd to be added to
the bootloader)


