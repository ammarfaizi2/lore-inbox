Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269017AbUIMWRG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269017AbUIMWRG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 18:17:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269012AbUIMWRG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 18:17:06 -0400
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:45555 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S269000AbUIMWQ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 18:16:58 -0400
From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
To: Jeremy Higdon <jeremy@sgi.com>
Subject: Re: [patch][2/3] ide: add ide_hwif_t->dma_exec_cmd()
Date: Tue, 14 Sep 2004 00:11:21 +0200
User-Agent: KMail/1.6.2
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       Mikael Starvik <mikael.starvik@axis.com>,
       Erik Jacobson <erikj@subway.americas.sgi.com>
References: <200409130133.55663.bzolnier@elka.pw.edu.pl> <20040913213552.GA95513@sgi.com>
In-Reply-To: <20040913213552.GA95513@sgi.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409140011.22047.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 13 September 2004 23:35, Jeremy Higdon wrote:
> On Mon, Sep 13, 2004 at 01:33:55AM +0200, Bartlomiej Zolnierkiewicz wrote:
> > 
> > [patch] ide: add ide_hwif_t->dma_exec_cmd()
> > 
> > - split off ->dma_exec_cmd() from ->ide_dma_[read,write] functions
> > - choose command to execute by ->dma_exec_cmd() in higher layers
> >   and remove ->ide_dma_[read,write]
> > 
> > Some real bugs are also fixed:
> > - in Etrax ide.c driver REQ_DRIVE_TASKFILE requests weren't
> >   handled properly for drive->addressing == 0
> > - in trm290.c read and write commands were interchanged
> > - in sgiioc4.c commands weren't sent to disk devices

DMA commands, PIO ones were sent out

> Sgiioc4 only is used with multimedia devices.  I don't think disks will
> work with it, even if you do send commands.

It is hard to believe but if this is true it should be documented somewhere.

Anyway my changes don't make it worse. :-)
