Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267391AbUIMO0v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267391AbUIMO0v (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 10:26:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266833AbUIMO0v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 10:26:51 -0400
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:48063 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S267391AbUIMOZn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 10:25:43 -0400
From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [patch][0/6] ide: sanitize PIO code, take 2
Date: Mon, 13 Sep 2004 14:16:37 +0200
User-Agent: KMail/1.6.2
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       Russell King <rmk+lkml@arm.linux.org.uk>
References: <200409110026.20064.bzolnier@elka.pw.edu.pl> <4144EB28.6070401@pobox.com>
In-Reply-To: <4144EB28.6070401@pobox.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409131416.37972.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 13 September 2004 02:34, Jeff Garzik wrote:
> Bartlomiej Zolnierkiewicz wrote:
> > - bugfix: use sg->length instead of sg_dma_len(sg)
> >   (found thanks to rmk's concerns)
> 
> Details?

Unlike libata we don't use DMA API for PIO.

> IIRC this breaks ia64 and/or other platforms?

No pci_[un]map_sg() so sg->length won't be ever changed.

Bartlomiej
