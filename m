Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751311AbVLPRbu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751311AbVLPRbu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 12:31:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751312AbVLPRbu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 12:31:50 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:62625 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S1751311AbVLPRbu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 12:31:50 -0500
Message-Id: <200512161729.jBGHTlGR017130@laptop11.inf.utfsm.cl>
To: Olof Johansson <olof@lixom.net>
cc: Michael Hanselmann <linux-kernel@hansmi.ch>, dtor_core@ameritech.net,
       kernel-stuff@comcast.net, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org, linux-input@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH 2.6 1/2] usb/input: Add relayfs support to appletouch driver 
In-Reply-To: Message from Olof Johansson <olof@lixom.net> 
   of "Thu, 15 Dec 2005 11:50:17 -0800." <20051215195017.GA7195@pb15.lixom.net> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 18)
Date: Fri, 16 Dec 2005 14:29:47 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b5 (inti.inf.utfsm.cl [200.1.19.1]); Fri, 16 Dec 2005 14:30:09 -0300 (CLST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olof Johansson <olof@lixom.net> wrote:

Just saw this.

> On Thu, Dec 15, 2005 at 12:31:08AM +0100, Michael Hanselmann wrote:

> > diff -rup linux-2.6.15-rc5.orig/drivers/usb/input/appletouch.c b/drivers/usb/input/appletouch.c
> > --- linux-2.6.15-rc5.orig/drivers/usb/input/appletouch.c	2005-12-13 22:44:24.000000000 +0100
> > +++ b/drivers/usb/input/appletouch.c	2005-12-15 00:25:09.000000000 +0100

[...]

> > +#if defined(CONFIG_RELAYFS_FS) || defined(CONFIG_RELAYFS_FS_MODULE)
> > +#include <linux/relayfs_fs.h>
> > +#endif

Why can't this be included regardless? If it does something that only makes
sense if relayfs is in use, better have that decision inside the header
file (least somebody just includes it and...).
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
