Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262195AbTE0BDi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 21:03:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262426AbTE0BDh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 21:03:37 -0400
Received: from mx15.sac.fedex.com ([199.81.197.54]:27922 "EHLO
	mx15.sac.fedex.com") by vger.kernel.org with ESMTP id S262195AbTE0BDM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 21:03:12 -0400
Date: Tue, 27 May 2003 09:14:35 +0800 (SGT)
From: Jeff Chua <jchua@fedex.com>
X-X-Sender: root@boston.corp.fedex.com
To: Santiago Garcia Mantinan <manty@manty.net>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.21-rc3
In-Reply-To: <20030526131618.GA3354@man.beta.es>
Message-ID: <Pine.LNX.4.55.0305270912320.24405@boston.corp.fedex.com>
References: <Pine.LNX.4.55L.0305221915450.1975@freak.distro.conectiva>
 <20030526131618.GA3354@man.beta.es>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 05/27/2003
 09:16:18 AM,
	Serialize by Router on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 05/27/2003
 09:16:21 AM,
	Serialize complete at 05/27/2003 09:16:21 AM
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The only around the problem is to do this ...

	CONFIG_BLK_DEV_IDE=y
	CONFIG_BLK_DEV_IDEDISK=m
	CONFIG_BLK_DEV_IDECD=m
	CONFIG_BLK_DEV_IDEFLOPPY=m
	CONFIG_BLK_DEV_IDESCSI=m
	CONFIG_BLK_DEV_IDEPCI=y



Thanks,
Jeff
[ jchua@fedex.com ]

On Mon, 26 May 2003, Santiago Garcia Mantinan wrote:

> This has been around the 2.4.21 pre series for quite some time, I thought it
> was known, but as it has not yet been fixed, I'm doubting it.
>
> If you try to compile ide as modules you get unresolved symbols:
>
> depmod: *** Unresolved symbols in
> /lib/modules/2.4.21-rc3/kernel/drivers/ide/ide-disk.o
> depmod:         proc_ide_read_geometry
> depmod:         ide_remove_proc_entries
> depmod: *** Unresolved symbols in
> /lib/modules/2.4.21-rc3/kernel/drivers/ide/ide-probe.o
> depmod:         do_ide_request
> depmod:         ide_add_generic_settings
> depmod:         create_proc_ide_interfaces
> depmod: *** Unresolved symbols in
> /lib/modules/2.4.21-rc3/kernel/drivers/ide/ide.o
> depmod:         ide_release_dma
> depmod:         ide_add_proc_entries
> depmod:         pnpide_init
> depmod:         ide_scan_pcibus
> depmod:         proc_ide_read_capacity
> depmod:         proc_ide_create
> depmod:         ide_remove_proc_entries
> depmod:         destroy_proc_ide_drives
> depmod:         proc_ide_destroy
> depmod:         create_proc_ide_interfaces
>
> In case the compiler or anything else could affect this, I'm running gcc 3.3
> in Debian sid.
>
> Regards...
> --
> Manty/BestiaTester -> http://manty.net
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
