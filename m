Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750815AbWGFUgq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750815AbWGFUgq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 16:36:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750822AbWGFUgq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 16:36:46 -0400
Received: from xenotime.net ([66.160.160.81]:28343 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750815AbWGFUgp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 16:36:45 -0400
Date: Thu, 6 Jul 2006 13:39:25 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Henne <henne@nachtwindheim.de>
Cc: Neela.Kolli@engenio.com, kernel-janitors@lists.osdl.org,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [KJ] [PATCH] fix legacy megaraid-driver to compile without
 CONFIG_PROC_FS
Message-Id: <20060706133925.e5fe6782.rdunlap@xenotime.net>
In-Reply-To: <44AD73AD.5080402@nachtwindheim.de>
References: <44AD6A5A.5060403@nachtwindheim.de>
	<20060706131447.ed46c3cb.rdunlap@xenotime.net>
	<44AD73AD.5080402@nachtwindheim.de>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 06 Jul 2006 22:33:49 +0200 Henne wrote:

> >> From: Henrik Kretzschmar <henne@nachtwindheim.de>
> >>
> >> Create an empty inline function to make the legacy megaraid-driver compile
> >> without PROC_FS.
> >> Signed-off-by: Henrik Kretzschmar <henne@nachtwindheim.de>
> >> ---
> >>
> >> --- linux-2.6.18-rc1/drivers/scsi/megaraid.h    2006-06-18 03:49:35.000000000 +0200
> >> +++ linux/drivers/scsi/megaraid.h       2006-07-06 21:39:59.000000000 +0200
> >> @@ -1039,6 +1039,9 @@
> >>  static int proc_rdrv_30(char *, char **, off_t, int, int *, void *);
> >>  static int proc_rdrv_40(char *, char **, off_t, int, int *, void *);
> >>  static int proc_rdrv(adapter_t *, char *, int, int);
> >> +#else
> >> +static inline void
> >> +mega_create_proc_entry(int index, struct proc_dir_entry *parent) {}
> >>  #endif
> >>
> >>  static int mega_adapinq(adapter_t *, dma_addr_t);
> > 
> > Already in -mm:
> > http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17/2.6.17-mm6/broken-out/drivers-scsi-megaraidc-add-a-dummy-mega_create_proc_entry-for-proc_fs=y.patch
> Great, but isn't it better to put that define stuff into the headers?

Sure it is.

---
~Randy
