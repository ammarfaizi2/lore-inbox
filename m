Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266322AbSKLN5N>; Tue, 12 Nov 2002 08:57:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266578AbSKLN5M>; Tue, 12 Nov 2002 08:57:12 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:13478 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266322AbSKLN5M>; Tue, 12 Nov 2002 08:57:12 -0500
Subject: Re: [PATCH] IDE: correct partially initialised hw structures
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Peter Denison <lkml@marshadder.uklinux.net>
Cc: Andre Hedrick <andre@linux-ide.org>, Alan Cox <alan@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0211071845350.6917-100000@marshall.localnet>
References: <Pine.LNX.4.44.0211071845350.6917-100000@marshall.localnet>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 12 Nov 2002 14:28:59 +0000
Message-Id: <1037111339.8313.14.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-11-07 at 19:04, Peter Denison wrote:
> Actually, if the patch that moves ide_init_default_hwifs() is applied then
> maybe this isn't strictly necessary. The whole area needs cleaning up, but
> I was loathe to start doing major changes. I've done large parts of the
> call tree for the ide driver, and I _still_ don't fully understand what
> should be called when. Just as a sample, there's:
> 	ide_init_data
> 	ide_init_default_hwifs
> 	ide_init_hwif_ports
> 	init_hwif_data
> 	ideprobe_init
> 	probe_hwif_init
> 	hwif_init
> 	etc.

Can you leave that bit alone for the moment. I'm currently splitting
ide.c into ide.c and ide-io.c so that all the crap is in one place ready
for extermination


