Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261596AbVEBBbk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261596AbVEBBbk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 May 2005 21:31:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261578AbVEBBbk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 May 2005 21:31:40 -0400
Received: from gate.crashing.org ([63.228.1.57]:24734 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261575AbVEBBbg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 May 2005 21:31:36 -0400
Subject: Re: [2.6 patch] drivers/ide/: possible cleanups
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       list linux-ide <linux-ide@vger.kernel.org>
In-Reply-To: <20050501142915.GF3592@stusta.de>
References: <20050430200750.GM3571@stusta.de>
	 <1114954660.11309.154.camel@localhost.localdomain>
	 <20050501142915.GF3592@stusta.de>
Content-Type: text/plain
Date: Mon, 02 May 2005 11:27:24 +1000
Message-Id: <1114997244.7112.360.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-05-01 at 16:29 +0200, Adrian Bunk wrote:
> On Sun, May 01, 2005 at 02:37:43PM +0100, Alan Cox wrote:
> > On Sad, 2005-04-30 at 21:07, Adrian Bunk wrote:
> > > This patch contains the following possible cleanups:
> > > - pci/cy82c693.c: make a needlessly global function static
> > > - remove the following unneeded EXPORT_SYMBOL's:
> > >   - ide-taskfile.c: do_rw_taskfile
> > >   - ide-iops.c: default_hwif_iops
> > >   - ide-iops.c: default_hwif_transport
> > >   - ide-iops.c: wait_for_ready
> > 
> > default_*_ops are very much API items not currently used. You need them
> > if you
> > want to switch from mmio back to pio (eg doing S3 resume) although
> > nobody is currently doing that.
> 
> My patch only removes the EXPORT_SYMBOL's.
> 
> The functions themselves stay (since they are used), and if someone 
> wants at some time in the future use them from a module, re-adding them 
> will be trivial.

Hrm... well, that means if I ever want ide-pmac for example to be a
module, I'll have to add them back...

On the other hand, I agree that their names aren't very nice for
exported symbols... they should have been ide_* 

Ben.


