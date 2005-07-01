Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263442AbVGAThb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263442AbVGAThb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 15:37:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263445AbVGATh3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 15:37:29 -0400
Received: from cpe-24-93-204-161.neo.res.rr.com ([24.93.204.161]:35466 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S263442AbVGATgn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 15:36:43 -0400
Date: Fri, 1 Jul 2005 15:30:24 -0400
From: Adam Belay <ambx1@neo.rr.com>
To: Andi Kleen <ak@suse.de>
Cc: Pierre Ossman <drzeus-list@drzeus.cx>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ISA DMA suspend for x86_64
Message-ID: <20050701193024.GA3742@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Andi Kleen <ak@suse.de>, Pierre Ossman <drzeus-list@drzeus.cx>,
	linux-kernel@vger.kernel.org
References: <1117288285.2685.10.camel@localhost.localdomain.suse.lists.linux.kernel> <42A2B610.1020408@drzeus.cx.suse.lists.linux.kernel> <42A3061C.7010604@drzeus.cx.suse.lists.linux.kernel> <42B1A08B.8080601@drzeus.cx.suse.lists.linux.kernel> <20050616170622.A1712@flint.arm.linux.org.uk.suse.lists.linux.kernel> <42C3A698.9020404@drzeus.cx.suse.lists.linux.kernel> <1120130926.6482.83.camel@localhost.localdomain.suse.lists.linux.kernel> <42C3E3A4.3090305@drzeus.cx.suse.lists.linux.kernel> <42C432BB.407@drzeus.cx.suse.lists.linux.kernel> <p73u0jeg5lg.fsf@verdi.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p73u0jeg5lg.fsf@verdi.suse.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 01, 2005 at 12:53:31PM +0200, Andi Kleen wrote:
> Pierre Ossman <drzeus-list@drzeus.cx> writes:
> 
> > Reset the ISA DMA controller into a known state after a suspend. Primary
> > concern was reenabling the cascading DMA channel (4).
> > 
> > Signed-off-by: Pierre Ossman <drzeus@drzeus.cx>
> > 
> > Word of warning, I haven't tested this platform since I don't have any
> > x86_64 hardware. But it shouldn't differ from i386.
> 
> This is identical to the i386 version isn't it? 
> Please just reuse the i386 version then in the Makefile.
> 
> And the whole thing should be probably dependent on CONFIG_SOFTWARE_SUSPEND
> 
> -Andi

CONFIG_SOFTWARE_SUSPEND is only suspend-to-disk.  There are other power
management states that may need to be included (e.g. ACPI S1-S3).

Thanks,
Adam
