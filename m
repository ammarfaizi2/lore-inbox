Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261923AbVCSXRM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261923AbVCSXRM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 18:17:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261924AbVCSXRM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 18:17:12 -0500
Received: from atlmail.prod.rxgsys.com ([64.74.124.160]:9706 "EHLO
	bastet.signetmail.com") by vger.kernel.org with ESMTP
	id S261923AbVCSXRI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 18:17:08 -0500
Date: Sat, 19 Mar 2005 18:16:41 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Andrew Morton <akpm@osdl.org>, Dave Jones <davej@redhat.com>,
       Greg KH <greg@kroah.com>,
       chas williams - CONTRACTOR <chas@cmf.nrl.navy.mil>,
       Leendert van Doorn <leendert@watson.ibm.com>,
       Reiner Sailer <sailer@watson.ibm.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] alpha build fixes
Message-ID: <20050319231641.GA28070@havoc.gtf.org>
References: <423BABBF.6030103@pobox.com> <20050319231116.GA4114@twiddle.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050319231116.GA4114@twiddle.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 19, 2005 at 03:11:16PM -0800, Richard Henderson wrote:
> On Fri, Mar 18, 2005 at 11:34:07PM -0500, Jeff Garzik wrote:
> > +/* TODO: integrate with include/asm-generic/pci.h ? */
> > +static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
> > +{
> > +	return channel ? 15 : 14;
> > +}
> 
> Am I missing something, or is this *only* used by drivers/ide/pci/amd74xx.c?
> Why in the world would we have this much infrastructure for one driver?  And
> why not just not compile that one for Alpha, since it'll never be used.

My presumption is that it will be used in other IDE drivers in the
future.  Bart?

If it will only be used in that one driver, then I agree.

	Jeff



