Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266425AbUIANE3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266425AbUIANE3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 09:04:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266473AbUIANE1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 09:04:27 -0400
Received: from the-village.bc.nu ([81.2.110.252]:3979 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S266425AbUIANEY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 09:04:24 -0400
Subject: Re: IDE class driver with SATA controllers
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrew Chew <achew@nvidia.com>
Cc: linux-ide@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       jgarzik@pobox.com,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
In-Reply-To: <DBFABB80F7FD3143A911F9E6CFD477B03F969B@hqemmail02.nvidia.com>
References: <DBFABB80F7FD3143A911F9E6CFD477B03F969B@hqemmail02.nvidia.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1094040111.2476.43.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 01 Sep 2004 13:01:53 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2004-08-31 at 22:03, Andrew Chew wrote:
> In my perusal of the kernel code, I noticed that the IDE subsystem
> handles IDE controllers at legacy IO ports if no other driver claims
> them (albeit without DMA support).  I was wondering if it could be
> extended to support SATA controllers 
> that aren't mapped to legacy I/O ports.

Generally no. It depends how the SATA controller provides interfaces.
If it provides the standards based interface with BIOS configured DMA
and timings but has no other support then add it to pci/generic.c. If it
doesn't then it'll need a driver anyway.

Alan

