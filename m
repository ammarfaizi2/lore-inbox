Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264329AbUFKSnw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264329AbUFKSnw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 14:43:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264304AbUFKSnw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 14:43:52 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:6834 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264295AbUFKSnu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 14:43:50 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH] IDE update for 2.6.7-rc3 [4/12]
Date: Fri, 11 Jun 2004 20:47:58 +0200
User-Agent: KMail/1.5.3
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       Russell King <rmk@arm.linux.org.uk>
References: <200406111755.02325.bzolnier@elka.pw.edu.pl> <20040611181106.GB12953@linux-sh.org>
In-Reply-To: <20040611181106.GB12953@linux-sh.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200406112047.58373.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 11 of June 2004 20:11, Paul Mundt wrote:
> On Fri, Jun 11, 2004 at 05:55:02PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > [PATCH] ide: kill hw_regs_t->dma
> >
> > hw_regs_t->dma is needed only by icside.c so make it local to this driver
> > (add unsigned int dma to struct icside_state) and kill it from hw_regs_t.
> > This allows us also to remove arm specific NO_DMA define from
> > <linux/ide.h>.
>
> sh will be making use of this as well for multiple drivers. Obviously we
> can make this local to each driver though if that's going to be the
> preferred approach.

Currently it is used only by icside for storing DMA number
from struct expansion_card.  What is the usage pattern on sh?

