Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261713AbVCUJQa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261713AbVCUJQa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 04:16:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261721AbVCUJQa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 04:16:30 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:2250 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S261713AbVCUJQ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 04:16:28 -0500
Date: Mon, 21 Mar 2005 12:16:16 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>,
       Dave Jones <davej@redhat.com>, Greg KH <greg@kroah.com>,
       chas williams - CONTRACTOR <chas@cmf.nrl.navy.mil>,
       Leendert van Doorn <leendert@watson.ibm.com>,
       Reiner Sailer <sailer@watson.ibm.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] alpha build fixes
Message-ID: <20050321121616.A24129@jurassic.park.msu.ru>
References: <423BABBF.6030103@pobox.com> <20050319231116.GA4114@twiddle.net> <20050319231641.GA28070@havoc.gtf.org> <58cb370e0503210005358cf200@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <58cb370e0503210005358cf200@mail.gmail.com>; from bzolnier@gmail.com on Mon, Mar 21, 2005 at 09:05:39AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2005 at 09:05:39AM +0100, Bartlomiej Zolnierkiewicz wrote:
> On Sat, 19 Mar 2005 18:16:41 -0500, Jeff Garzik <jgarzik@pobox.com> wrote:
> > On Sat, Mar 19, 2005 at 03:11:16PM -0800, Richard Henderson wrote:
> > > On Fri, Mar 18, 2005 at 11:34:07PM -0500, Jeff Garzik wrote:
> > > > +/* TODO: integrate with include/asm-generic/pci.h ? */
> > > > +static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
> > > > +{
> > > > +   return channel ? 15 : 14;
> > > > +}
> > >
> > > Am I missing something, or is this *only* used by drivers/ide/pci/amd74xx.c?
> > > Why in the world would we have this much infrastructure for one driver?  And
> > > why not just not compile that one for Alpha, since it'll never be used.
> > 
> > My presumption is that it will be used in other IDE drivers in the
> > future.  Bart?
> 
> This code is meant to be used by other IDE/libata drivers.

Then isn't linux/ide.h the proper place for default pci_get_legacy_ide_irq()
implementation instead of asm-generic/pci.h? The latter is only used by
7 out of 23 architectures, so not only alpha gets broken.

Ivan.
