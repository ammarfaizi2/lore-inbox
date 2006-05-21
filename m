Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964876AbWEUOCZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964876AbWEUOCZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 10:02:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964877AbWEUOCZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 10:02:25 -0400
Received: from ns.dynamicweb.hu ([195.228.155.139]:52641 "EHLO dynamicweb.hu")
	by vger.kernel.org with ESMTP id S964876AbWEUOCZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 10:02:25 -0400
Message-ID: <024c01c67cdf$1e72d070$1800a8c0@dcccs>
From: =?iso-8859-1?Q?Haar_J=E1nos?= <djani22@netcenter.hu>
To: "Andrew Morton" <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
References: <00e901c67cad$fe9a9d90$1800a8c0@dcccs> <20060521050326.3bbbdf3a.akpm@osdl.org>
Subject: Re: swapper: page allocation failure.
Date: Sun, 21 May 2006 16:01:49 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1437
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


----- Original Message ----- 
From: "Andrew Morton" <akpm@osdl.org>
To: "Haar János" <djani22@netcenter.hu>
Cc: <linux-kernel@vger.kernel.org>
Sent: Sunday, May 21, 2006 2:03 PM
Subject: Re: swapper: page allocation failure.


> Haar János <djani22@netcenter.hu> wrote:
> >
> > I seriously gets this, and dont know why.
> >  This server have 2GB ram, and ~1.1G always free!
> >  Anybody have an idea?
> >
> >  Thanks,
> >  Janos
> >
> >  May 21 09:05:35 st-0003 kernel: swapper: page allocation failure.
order:0,
> >  mode:0x20
> >  May 21 09:05:35 st-0003 kernel:  <c013c6ac> __alloc_pages+0x274/0x286
> >  <c014af1d> cache_alloc_refill+0x2a6/0x45c
> >  May 21 09:05:35 st-0003 kernel:  <c014b12b> __kmalloc+0x58/0x61
<c03d5bfc>
> >  __alloc_skb+0x49/0xf5
> >  May 21 09:05:35 st-0003 kernel:  <f88336b1>
> >  e1000_alloc_rx_buffers+0x5c/0x2e5 [e1000]   <f88315de>
>
> e1000 gobbled up all your lowmem memory from interrupt context.
>
> Increasing /proc/sys/vm/min_free_kbytes will help.

Yes, i know. ;-)

Thanks,

> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

