Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268237AbUHKVOx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268237AbUHKVOx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 17:14:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268235AbUHKVOx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 17:14:53 -0400
Received: from the-village.bc.nu ([81.2.110.252]:26579 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268237AbUHKVOm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 17:14:42 -0400
Subject: Re: [PATCH] add PCI ROMs to sysfs
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: Greg KH <greg@kroah.com>, Jesse Barnes <jbarnes@engr.sgi.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Martin Mares <mj@ucw.cz>, linux-pci@atrey.karlin.mff.cuni.cz,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Petr Vandrovec <VANDROVE@vc.cvut.cz>
In-Reply-To: <20040811192411.36763.qmail@web14927.mail.yahoo.com>
References: <20040811192411.36763.qmail@web14927.mail.yahoo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1092255102.18968.276.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 11 Aug 2004 21:11:42 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2004-08-11 at 20:24, Jon Smirl wrote:
> Alan Cox had concerns about copying the ROMs for those devices that
> don't implement full address decoding. I'm using kmalloc for 40-60KB.
> Would vmalloc be a better choice? Very few drivers will use the copy
> option, mostly old hardware.

As I said before you don't need to allocate big chunks of kernel memory
for this because you don't want to store ROM copies in kernel, you just
disallow mmap in such a case and let the user use read().

I am opposed to anything that keeps ROM copies in the kernel.

