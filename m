Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264030AbTGWO2X (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 10:28:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268160AbTGWO2X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 10:28:23 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:17106 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S264030AbTGWO2V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 10:28:21 -0400
Date: Wed, 23 Jul 2003 16:42:41 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: "David S. Miller" <davem@redhat.com>
cc: Christoph Hellwig <hch@infradead.org>, solca@guug.org, zaitcev@redhat.com,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       sparclinux@vger.kernel.org, debian-sparc@lists.debian.org
Subject: Re: sparc scsi esp depends on pci & hangs on boot
In-Reply-To: <20030723002008.538dc163.davem@redhat.com>
Message-ID: <Pine.GSO.4.21.0307231641180.27805-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jul 2003, David S. Miller wrote:
> On Wed, 23 Jul 2003 08:02:22 +0100
> Christoph Hellwig <hch@infradead.org> wrote:
> 
> > On Tue, Jul 22, 2003 at 11:57:14PM -0700, David S. Miller wrote:
> > > I don't see why this is a problem.  Either do this, or fix
> > > asm-generic/dma-mapping.h which is not GENERIC because it
> > > depends upon something SPECIFIC, specifically PCI.
> > 
> > The latter is what need to be done.  
> 
> I'll do the following for now.
> 
> # This is a BitKeeper generated patch for the following project:
> # Project Name: Linux kernel tree
> # This patch format is intended for GNU patch command version 2.5 or higher.
> # This patch includes the following deltas:
> #	           ChangeSet	1.1518  -> 1.1519 
> #	include/asm-sparc64/dma-mapping.h	1.1     -> 1.2    
> #	include/asm-sparc/dma-mapping.h	1.1     -> 1.2    
> #
> # The following is the BitKeeper ChangeSet Log
> # --------------------------------------------
> # 03/07/23	davem@nuts.ninka.net	1.1519
> # [SPARC]: Do not include asm-generic/dma-mapping.h if !CONFIG_PCI.

Yep, that's what I did for m68k as well (inspired by s390 which never has PCI
and thus an empty dma-mapping.h).

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

