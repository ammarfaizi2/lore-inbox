Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261645AbVCUIFp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261645AbVCUIFp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 03:05:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261656AbVCUIFp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 03:05:45 -0500
Received: from wproxy.gmail.com ([64.233.184.198]:59082 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261645AbVCUIFk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 03:05:40 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=uHjFaOKcSxldlhdKdXtEmr8CHPeaYkfgd/x1x6ErxF/iYKvg9XzqJ+nkcYgSydKviuhd8h3cZ3VAlgZKJ09uDdG1AhoH1TY3DuHcOb0cNtZv9zVFtYSZbg1vN5tL48E0vrwgbCB2VZfTjT96R33FgDrXXYjySOPnJUKkLDqPPec=
Message-ID: <58cb370e0503210005358cf200@mail.gmail.com>
Date: Mon, 21 Mar 2005 09:05:39 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] alpha build fixes
Cc: Andrew Morton <akpm@osdl.org>, Dave Jones <davej@redhat.com>,
       Greg KH <greg@kroah.com>,
       chas williams - CONTRACTOR <chas@cmf.nrl.navy.mil>,
       Leendert van Doorn <leendert@watson.ibm.com>,
       Reiner Sailer <sailer@watson.ibm.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20050319231641.GA28070@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <423BABBF.6030103@pobox.com> <20050319231116.GA4114@twiddle.net>
	 <20050319231641.GA28070@havoc.gtf.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Mar 2005 18:16:41 -0500, Jeff Garzik <jgarzik@pobox.com> wrote:
> On Sat, Mar 19, 2005 at 03:11:16PM -0800, Richard Henderson wrote:
> > On Fri, Mar 18, 2005 at 11:34:07PM -0500, Jeff Garzik wrote:
> > > +/* TODO: integrate with include/asm-generic/pci.h ? */
> > > +static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
> > > +{
> > > +   return channel ? 15 : 14;
> > > +}
> >
> > Am I missing something, or is this *only* used by drivers/ide/pci/amd74xx.c?
> > Why in the world would we have this much infrastructure for one driver?  And
> > why not just not compile that one for Alpha, since it'll never be used.
> 
> My presumption is that it will be used in other IDE drivers in the
> future.  Bart?

This code is meant to be used by other IDE/libata drivers.

[ Original thread can be found in linux-ide ML archive. ]
