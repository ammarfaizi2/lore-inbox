Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262123AbTJIM5W (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 08:57:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262118AbTJIM5W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 08:57:22 -0400
Received: from intra.cyclades.com ([64.186.161.6]:13803 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S262076AbTJIM5T
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 08:57:19 -0400
Date: Thu, 9 Oct 2003 10:00:16 -0300 (BRT)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Erik Mouw <erik@harddisk-recovery.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Xose Vazquez Perez <xose@wanadoo.es>,
       linux-scsi <linux-scsi@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: two sym53c8xx.o modules
In-Reply-To: <20031009122428.GF11525@bitwizard.nl>
Message-ID: <Pine.LNX.4.44.0310090959550.3040-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 9 Oct 2003, Erik Mouw wrote:

> On Thu, Oct 09, 2003 at 08:41:49AM -0300, Marcelo Tosatti wrote:
> > On Thu, 9 Oct 2003, Xose Vazquez Perez wrote:
> > > kernel 2.4 has two modules with *same name*:
> > > /lib/modules/2.4.XX/kernel/drivers/scsi/sym53c8xx_2/sym53c8xx.o
> > > /lib/modules/2.4.XX/kernel/drivers/scsi/sym53c8xx.o
> > > 
> > > "# modprobe sym53c8xx" tries to load sym53c8xx.o first and then sym53c8xx_2/sym53c8xx.o
> > > bug or feature?
> > > 
> > > should be sym53c8xx_2/sym53c8xx.o renamed to sym53c8xx_2/sym53c8xx_2.o ?
> > 
> > One should not have both drivers loaded at the same time, so I think this
> > is alright.
> 
> No, it's not allright. Modprobe can't distinguish between
> sym53c8xx_2/sym53c8xx.o and sym53c8xx.o, you have to figure out the
> full path and insmod one of them manually. Xose is right in that
> sym53c8xx_2/sym53c8xx.o should be renamed in sym53c8xx_2/sym53c8xx_2.o.
> Compare with aic7xxx and aic7xxx_old.

True. Mind sending me a patch? 

