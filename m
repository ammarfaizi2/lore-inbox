Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261816AbVCUOzs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261816AbVCUOzs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 09:55:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261818AbVCUOzs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 09:55:48 -0500
Received: from [81.2.110.250] ([81.2.110.250]:34514 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S261816AbVCUOzr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 09:55:47 -0500
Subject: Re: [PATCH] alpha build fixes
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Richard Henderson <rth@twiddle.net>
Cc: Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>,
       Dave Jones <davej@redhat.com>, Greg KH <greg@kroah.com>,
       chas williams - CONTRACTOR <chas@cmf.nrl.navy.mil>,
       Leendert van Doorn <leendert@watson.ibm.com>,
       Reiner Sailer <sailer@watson.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050319231116.GA4114@twiddle.net>
References: <423BABBF.6030103@pobox.com> <20050319231116.GA4114@twiddle.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1111416728.14833.20.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 21 Mar 2005 14:52:10 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2005-03-19 at 23:11, Richard Henderson wrote:
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

The issue is bigger - it's needed for the CMD controllers on PA-RISC for
example it appears - and anything else where IDE legacy IRQ is wired
oddly.

