Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268991AbUIMVjB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268991AbUIMVjB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 17:39:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268914AbUIMVjA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 17:39:00 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:33164 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S268907AbUIMVgI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 17:36:08 -0400
Date: Mon, 13 Sep 2004 14:35:52 -0700
From: Jeremy Higdon <jeremy@sgi.com>
To: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       Mikael Starvik <mikael.starvik@axis.com>,
       Erik Jacobson <erikj@subway.americas.sgi.com>
Subject: Re: [patch][2/3] ide: add ide_hwif_t->dma_exec_cmd()
Message-ID: <20040913213552.GA95513@sgi.com>
References: <200409130133.55663.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409130133.55663.bzolnier@elka.pw.edu.pl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2004 at 01:33:55AM +0200, Bartlomiej Zolnierkiewicz wrote:
> 
> [patch] ide: add ide_hwif_t->dma_exec_cmd()
> 
> - split off ->dma_exec_cmd() from ->ide_dma_[read,write] functions
> - choose command to execute by ->dma_exec_cmd() in higher layers
>   and remove ->ide_dma_[read,write]
> 
> Some real bugs are also fixed:
> - in Etrax ide.c driver REQ_DRIVE_TASKFILE requests weren't
>   handled properly for drive->addressing == 0
> - in trm290.c read and write commands were interchanged
> - in sgiioc4.c commands weren't sent to disk devices

Sgiioc4 only is used with multimedia devices.  I don't think disks will
work with it, even if you do send commands.

jeremy
