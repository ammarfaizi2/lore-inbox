Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261921AbVCSXNS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261921AbVCSXNS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 18:13:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261923AbVCSXNS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 18:13:18 -0500
Received: from are.twiddle.net ([64.81.246.98]:30595 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id S261921AbVCSXNQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 18:13:16 -0500
Date: Sat, 19 Mar 2005 15:11:16 -0800
From: Richard Henderson <rth@twiddle.net>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andrew Morton <akpm@osdl.org>, Dave Jones <davej@redhat.com>,
       Greg KH <greg@kroah.com>,
       chas williams - CONTRACTOR <chas@cmf.nrl.navy.mil>,
       Leendert van Doorn <leendert@watson.ibm.com>,
       Reiner Sailer <sailer@watson.ibm.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] alpha build fixes
Message-ID: <20050319231116.GA4114@twiddle.net>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	Andrew Morton <akpm@osdl.org>, Dave Jones <davej@redhat.com>,
	Greg KH <greg@kroah.com>,
	chas williams - CONTRACTOR <chas@cmf.nrl.navy.mil>,
	Leendert van Doorn <leendert@watson.ibm.com>,
	Reiner Sailer <sailer@watson.ibm.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <423BABBF.6030103@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <423BABBF.6030103@pobox.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 18, 2005 at 11:34:07PM -0500, Jeff Garzik wrote:
> +/* TODO: integrate with include/asm-generic/pci.h ? */
> +static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
> +{
> +	return channel ? 15 : 14;
> +}

Am I missing something, or is this *only* used by drivers/ide/pci/amd74xx.c?
Why in the world would we have this much infrastructure for one driver?  And
why not just not compile that one for Alpha, since it'll never be used.


r~
