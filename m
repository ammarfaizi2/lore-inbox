Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262499AbTFXVDQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 17:03:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262525AbTFXVDQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 17:03:16 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:10397 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S262499AbTFXVDP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 17:03:15 -0400
Message-Id: <200306242116.h5OLGQV0002891@eeyore.valparaiso.cl>
To: Ronald Bultje <rbultje@ronald.bitfreak.net>
cc: Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.21 doesn't boot: /bin/insmod.old: file not found 
In-Reply-To: Message from Ronald Bultje <rbultje@ronald.bitfreak.net> 
   of "24 Jun 2003 08:35:52 +0200." <1056436551.2674.2.camel@localhost.localdomain> 
X-Mailer: MH-E 7.1; nmh 1.0.4; XEmacs 21.4
Date: Tue, 24 Jun 2003 17:16:26 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ronald Bultje <rbultje@ronald.bitfreak.net> said:

[...]

> Adding insmod.static.old to the ramdisk image (add the line 'inst
> /sbin/insmod.static.old "$MNTIMAGE/bin/insmod.old"' in /sbin/mkinitrd)
> fixed the issue for me. Thanks for the pointer!

I'd make that:

[ -x /sbin/insmod.old ] && inst /sbin/insmod.static.old "$MNTIMAGE/bin/insmod.old"

Just paranoia...
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
