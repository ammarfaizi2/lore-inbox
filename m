Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286351AbRL0Qcw>; Thu, 27 Dec 2001 11:32:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286348AbRL0Qcd>; Thu, 27 Dec 2001 11:32:33 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:28946 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S286346AbRL0QcW>; Thu, 27 Dec 2001 11:32:22 -0500
Subject: Re: hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
To: axboe@suse.de (Jens Axboe)
Date: Thu, 27 Dec 2001 16:42:04 +0000 (GMT)
Cc: andre@linux-ide.org (Andre Hedrick), alan@lxorguk.ukuu.org.uk (Alan Cox),
        stodden@in.tum.de (Daniel Stodden), linux-kernel@vger.kernel.org
In-Reply-To: <20011227155403.A1730@suse.de> from "Jens Axboe" at Dec 27, 2001 03:54:03 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16JdbY-00061d-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> retries belong at the low level, once you pass up info of failure to the
> upper layers it's fatal. time for FS to shut down.

Thats definitely not the case. Just because your file system is too dumb to
use the information please don't assume everyone elses isnt - in fact one
of the side properties of Daniel Phillips stuff is that it should be able
to sanely handle a bad block problem.

EVMS, MD, multipath all need to know about and do their own bad block 
handling. If the block driver knows how to recover stuff then great it
can recover it, but we should ensure its possible for the fs internals
to recover and work around a bad block. 

> Irk, software managed bad block remapping is horrible.

IBM have it working, so however horrible doesn't matter that much, someone
has done the work for you.

Alan
