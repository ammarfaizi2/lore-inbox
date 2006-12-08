Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1425179AbWLHIcU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1425179AbWLHIcU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Dec 2006 03:32:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1032531AbWLHIcU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 03:32:20 -0500
Received: from gw-eur4.philips.com ([161.85.125.10]:55966 "EHLO
	gw-eur4.philips.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1032528AbWLHIcT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 03:32:19 -0500
In-Reply-To: <200612062117.27946.a1426z@gawab.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: typo in init/initramfs.c
MIME-Version: 1.0
X-Mailer: Lotus Notes Release 6.0.3 September 26, 2003
Message-ID: <OFFC8397EF.1D0C38CD-ONC125723E.002EA3BB-C125723E.002EE367@philips.com>
From: Jean-Paul Saman <jean-paul.saman@nxp.com>
Date: Fri, 8 Dec 2006 09:32:03 +0100
X-MIMETrack: Serialize by Router on ehvrmh02/H/SERVER/PHILIPS(Release 6.5.5HF805 | August
 26, 2006) at 08/12/2006 09:32:05,
	Serialize complete at 08/12/2006 09:32:05
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-kernel-owner@vger.kernel.org wrote on 06-12-2006 19:17:27:

> Jean-Paul Saman wrote:
> >
> > In populate_rootfs() the printk on line 554. It says "Unpacking
> > initramfs..", which is confusing because if that line is reached the 
code
> > has already decided that the image is an initrd image.
> 
> Are you sure?

Yes.

> 
> > The printk is thus
> > wrong in stating that it is unpacking an "initramfs". It should says
> > "initrd" instead. The attached patch corrects this typo.
> >
> > Signed-off-by: Jean-Paul Saman <jean-paul.saman@nxp.com>
> >
> > diff --git a/init/initramfs.c b/init/initramfs.c
> > index d28c109..f6020db 100644
> > --- a/init/initramfs.c
> > +++ b/init/initramfs.c
> > @@ -551,7 +551,7 @@ #ifdef CONFIG_BLK_DEV_RAM
> 
> This is where initramfs is discerned from initrd, as both are available.
> 
> >                         free_initrd();
> >                 }
> >  #else
> 
> Otherwise it's initramfs only.

No otherwise it falls under CONFIG_BLK_DEV_INITRD and it that suggests it 
must be a initrd, not a initramfs as the original printk() suggests.

> 
> > -               printk(KERN_INFO "Unpacking initramfs...");
> > +              printk(KERN_INFO "Unpacking initrd...");
> >                 err = unpack_to_rootfs((char *)initrd_start,
> >                         initrd_end - initrd_start, 0);
> >                 if (err)
> >
> > -

Kind greetings,

Jean-Paul Saman

NXP Semiconductors CTO/RTG DesignIP
