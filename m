Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265331AbUAADDZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 22:03:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265332AbUAADDZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 22:03:25 -0500
Received: from colo.lackof.org ([198.49.126.79]:413 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S265331AbUAADDY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 22:03:24 -0500
Date: Wed, 31 Dec 2003 20:03:22 -0700
From: Grant Grundler <grundler@parisc-linux.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Matthew Wilcox <willy@debian.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       "David S. Miller" <davem@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH] pci_set_dac helper
Message-ID: <20040101030322.GA6516@colo.lackof.org>
References: <3FF2F57A.80801@pobox.com> <20031231185953.GJ6791@parcelfarce.linux.theplanet.co.uk> <3FF31DFB.9030907@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FF31DFB.9030907@pobox.com>
User-Agent: Mutt/1.3.28i
X-Home-Page: http://www.parisc-linux.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 31, 2003 at 02:05:31PM -0500, Jeff Garzik wrote:
> Matthew Wilcox wrote:
> > I note that both this and your patch will lead to two errors being
> > printed on 64-bit consistent failure; one by tg3 and one by the PCI
> > layer; this seems suboptimal.  I suspect you want to do away with the
> > error printk in the tg3 driver.
> 
> That was intentional in my patch, as it's a warning not an error in my 
> pci_set_dac.  In your version I would agree.

It's perfectly ok for some platforms to not support 64-bit DMA mask
for either type of DMA. The warning suggests it's not OK.
I don't see why we either a warning or error printed unless it would
lead to incorrect operation of the device.

grant
