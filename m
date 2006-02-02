Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751104AbWBBOkZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751104AbWBBOkZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 09:40:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751103AbWBBOkZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 09:40:25 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:20374 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751104AbWBBOkY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 09:40:24 -0500
Subject: Re: root=LABEL= problem [Was: Re: Linux Issue]
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Arjan van de Ven <arjan@infradead.org>,
       Bernd Petrovitsch <bernd@firmix.at>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Jiri Slaby <xslaby@fi.muni.cz>,
       kavitha s <wellspringkavitha@yahoo.co.in>, linux-kernel@vger.kernel.org
In-Reply-To: <20060202091900.469e7394@werewolf.auna.net>
References: <20060201114845.E41F222AF24@anxur.fi.muni.cz>
	 <Pine.LNX.4.61.0602011713410.22529@yvahk01.tjqt.qr>
	 <1138810616.16643.30.camel@tara.firmix.at>
	 <1138863107.3270.8.camel@laptopd505.fenrus.org>
	 <20060202091900.469e7394@werewolf.auna.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 02 Feb 2006 14:41:48 +0000
Message-Id: <1138891308.9861.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2006-02-02 at 09:19 +0100, J.A. Magallon wrote:
> > it's 100% done in the initrd.
> 
> Isn't this a matter of the bootloader ?


The boot loader knows very little and the BIOS may not even be able to
drive some of the hardware to go looking for volume labels. The sequence
used is that the initrd is the root file system and contains application
code run very early on in order to find out where the 'real' root fs is
by label. Having mounted that it can then pivot_root() itself into the
final desired configuration.

All userspace, and all the initrd building is done by a tool called
mkinitrd.

Alan

