Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262813AbVA2PA3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262813AbVA2PA3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 10:00:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262925AbVA2PA3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 10:00:29 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:26760 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262813AbVA2PAZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 10:00:25 -0500
Date: Sat, 29 Jan 2005 15:00:23 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Christoph Hellwig <hch@infradead.org>,
       Pierre Ossman <drzeus-list@drzeus.cx>,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       LKML <linux-kernel@vger.kernel.org>, wbsd-devel@list.drzeus.cx
Subject: Re: [Wbsd-devel] [PATCH 540] MMC_WBSD depends on ISA
Message-ID: <20050129150023.GA959@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Pierre Ossman <drzeus-list@drzeus.cx>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	LKML <linux-kernel@vger.kernel.org>, wbsd-devel@list.drzeus.cx
References: <200501072250.j07MonUe012310@anakin.of.borg> <41E22B4F.4090402@drzeus.cx> <41FB91A3.7060404@drzeus.cx> <20050129135714.GA320@infradead.org> <20050129145417.A12311@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050129145417.A12311@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 29, 2005 at 02:54:17PM +0000, Russell King wrote:
> Christoph, did you mean to add anything?

Yes, this somehow got lost:

-----

> > Russell, please undo this patch. isa_virt_to_bus() is not dependent on 
> > CONFIG_ISA. It causes problems on x86_64 platforms which cannot enable 
> > ISA support.
> > 

Actually it is, x86_64 just refuses to set CONFIG_ISA despite having
isa-like devices.

Either way a new driver shouldn't use isa_virt_to_bus at all but rather
use the proper DMA API and all those problems go away.

