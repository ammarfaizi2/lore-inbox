Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751698AbWHXUD5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751698AbWHXUD5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 16:03:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751693AbWHXUD4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 16:03:56 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:49868 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030469AbWHXUDz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 16:03:55 -0400
Subject: RE: Generic Disk Driver in Linux
From: Arjan van de Ven <arjan@infradead.org>
To: Aleksey Gorelov <dared1st@yahoo.com>
Cc: jengelh@linux01.gwdg.de, daniel.rodrick@gmail.com,
       linux-kernel@vger.kernel.org, kernelnewbies@nl.linux.org,
       linux-newbie@vget.kernel.org, satinder.jeet@gmail.com
In-Reply-To: <20060824194012.77909.qmail@web83101.mail.mud.yahoo.com>
References: <20060824194012.77909.qmail@web83101.mail.mud.yahoo.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Thu, 24 Aug 2006 22:03:29 +0200
Message-Id: <1156449809.3014.84.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-24 at 12:40 -0700, Aleksey Gorelov wrote:
> 
> --- Arjan van de Ven <arjan@infradead.org> wrote:
> 
> > On Thu, 2006-08-24 at 11:19 -0700, Aleksey Gorelov wrote:
> > > >From: linux-kernel-owner@vger.kernel.org 
> > > >[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Jan Engelhardt
> > > >>
> > > >> I was curious that can we develop a generic disk driver that could
> > > >> handle all the kinds of hard drives - IDE, SCSI, RAID et al?
> > > >
> > > >ide_generic
> > > >sd_mod
> > > >
> > > >All there, what more do you want?
> > > 
> > > Unfortunately, not _all_. DMRAID does not support all fake raids yet. 
> > 
> > Hi,
> > 
> > it'll be easier and quicker to rev engineer 5 more formats than it will
> > be to get the bios thing working ;) And the performance of the bios
> probably true - I'm actually not great fan of originally proposed approach. But, 
> unfortunately, manufactures and vendors still look more to MS. Until market 
> situation changes, there is always a gap...

there are only so many different ways to describe raid0.
And those companies aren't going to keep changing that "just because",
changing costs them money, so there is an incentive for them to keep it
as is

> 
> > thing will be really really bad... (hint: real mode can access only 1Mb
> > of memory, so you will bounce buffer all IO's)
> This is true for non-dma case only. As I already mentioned before, most BIOSes 
> support dma, and there is no 1Mb limit for that (at least on modern hw).

but only DMA to lower regions usually


