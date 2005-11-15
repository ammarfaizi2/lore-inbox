Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751396AbVKOJGQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751396AbVKOJGQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 04:06:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751398AbVKOJGQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 04:06:16 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:11977 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751396AbVKOJGO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 04:06:14 -0500
Date: Tue, 15 Nov 2005 09:06:12 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, eranian@hpl.hp.com, ak@muc.de,
       benh@kernel.crashing.org, paulus@samba.org, stephane.eranian@hp.com,
       tony.luck@intel.com
Subject: Re: + perfmon2-reserve-system-calls.patch added to -mm tree
Message-ID: <20051115090612.GA22160@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
	eranian@hpl.hp.com, ak@muc.de, benh@kernel.crashing.org,
	paulus@samba.org, stephane.eranian@hp.com, tony.luck@intel.com
References: <200511142329.jAENTfmS004600@shell0.pdx.osdl.net> <200511150050.27556.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511150050.27556.arnd@arndb.de>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2005 at 12:50:26AM +0100, Arnd Bergmann wrote:
> > --- 25/include/asm-powerpc/unistd.h~perfmon2-reserve-system-calls???????Mon Nov 14 15:27:32 2005
> > +++ 25-akpm/include/asm-powerpc/unistd.h????????Mon Nov 14 15:27:32 2005
> > @@ -296,8 +296,20 @@
> > ?#define __NR_inotify_init??????275
> > ?#define __NR_inotify_add_watch?276
> > ?#define __NR_inotify_rm_watch??277
> > +#define __NR_pfm_create_context????????278
> > +#define __NR_pfm_write_pmcs????279
> > +#define __NR_pfm_write_pmds????280
> > +#define __NR_pfm_read_pmds?????281
> > +#define __NR_pfm_load_context??282
> > +#define __NR_pfm_start?????????283
> > +#define __NR_pfm_stop??????????284
> > +#define __NR_pfm_restart???????285
> > +#define __NR_pfm_create_evtsets????????286
> > +#define __NR_pfm_getinfo_evtsets 287
> > +#define __NR_pfm_delete_evtsets 288
> > +#define __NR_pfm_unload_context????????289
> > ?
> > -#define __NR_syscalls??????????278
> > +#define __NR_syscalls??????????290

I thought we didn't reserve syscall numbers?

anyway, this is an awfull lot of syscalls numbers for what essentially
is a driver not core kernel functionality.  I think we should do an API
review first.

and why didn't this patch get sent to lkml for review?
