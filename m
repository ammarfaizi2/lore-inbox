Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932220AbWESEMU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932220AbWESEMU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 00:12:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932224AbWESEMU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 00:12:20 -0400
Received: from az33egw02.freescale.net ([192.88.158.103]:47326 "EHLO
	az33egw02.freescale.net") by vger.kernel.org with ESMTP
	id S932222AbWESEMT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 00:12:19 -0400
Message-ID: <9FCDBA58F226D911B202000BDBAD467306315075@zch01exm40.ap.freescale.net>
From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
To: Mark Lord <liml@rtr.ca>, Jeff Garzik <jgarzik@pobox.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       Paul Mackerras <paulus@samba.org>,
       linuxppc-dev list <linuxppc-dev@ozlabs.org>,
       Alexandre.Bounine@tundra.com,
       Yang Xin-Xin-r48390 <Xin-Xin.Yang@freescale.com>,
       Kumar Gala <galak@kernel.crashing.org>
Subject: RE: [PATCH/2.6.17-rc4 10/10]  bugs fix for marvell SATA on powerp
	 c pl atform
Date: Fri, 19 May 2006 12:12:08 +0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain;
	charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Jeff Garzik wrote:
> > Benjamin Herrenschmidt wrote:
> >> On Thu, 2006-05-18 at 12:03 +0800, Zang Roy-r61911 wrote:
> ..
> >>> @@ -1567,13 +1570,18 @@ static void mv5_read_preamp(struct mv_ho
> >>>  static void mv5_enable_leds(struct mv_host_priv *hpriv, 
> void __iomem
> >> *mmio)
> >>>  {
> >>>       u32 tmp;
> >>> -
> >>> +#ifndef CONFIG_PPC
> >>>       writel(0, mmio + MV_GPIO_PORT_CTL);
> >>> +#endif
> >>
> >> You'll have to do better here too... I don't wee why when 
> compiled on
> >> PPC, this driver should "magically" not clear those 
> bits... At the very
> >> least, you should test the machine type if you want to do something
> >> specific to your platform, but first, you'll have to 
> convince Jeff why
> >> this change has to be done in the first place and if there 
> is a better
> >> way to handle it.
> > 
> > Correct...  it does seem some bugs were found, but #ifdef 
> powerpc is 
> > certainly out of the question.  We want the driver to work without 
> > ifdefs on all platforms.
> 
> Yup.  I have a powerpc platform here with PCI-X, and a PCI-X 
> Marvell card
> to try in it.  So I'll pick up these changes and try to 
> integrate them a
> little more nicely in my internal updated driver, and then 
> pass it on to Jeff.
> 
> Cheers
> 

The reason why I use "ifdef" is that I do not want to affect other platform. I do not 
have other platform to verify. If you can verify my patch on your powerpc platform, 
please help to integrate it into your driver.
