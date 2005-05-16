Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261692AbVEPPUC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261692AbVEPPUC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 11:20:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261699AbVEPPT4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 11:19:56 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:54239 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S261692AbVEPPI3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 11:08:29 -0400
Subject: Re: Linux does not care for data integrity (was: Disk write cache)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Matthias Andree <matthias.andree@gmx.de>
Cc: Arjan van de Ven <arjan@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050516144831.GA949@merlin.emma.line.org>
References: <Pine.LNX.4.58.0505151657230.19181@artax.karlin.mff.cuni.cz>
	 <200505151121.36243.gene.heskett@verizon.net>
	 <20050515152956.GA25143@havoc.gtf.org>
	 <20050516.012740.93615022.okuyamak@dd.iij4u.or.jp>
	 <42877C1B.2030008@pobox.com> <20050516110203.GA13387@merlin.emma.line.org>
	 <1116241957.6274.36.camel@laptopd505.fenrus.org>
	 <20050516112956.GC13387@merlin.emma.line.org>
	 <1116252157.6274.41.camel@laptopd505.fenrus.org>
	 <20050516144831.GA949@merlin.emma.line.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1116256005.21388.55.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 16 May 2005 16:06:46 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think you need to get real if you want that degree of integrity with a
PC

Your typical PC setup means your precious data

	Gets written to un ecc protected memory over an unprotected bus
	Gets read back over the same
	Each PATA command is sent without any CRC or error recovery/correction
	The PATA data is pulled out of unprotected memory over PCI
	It goes to the drive (with a CRC) and gets stored in memory
	It's probably sitting in non ECC RAM on the disk
	It's probably fed through non ECC DSP logic
	It's mixed on the disk with other data and may get rewritten without
you knowing

You might want to amuse yourself trying to get the bit error rates for
the busses and ram to start documenting the probabilities.

I'd prefer Linux turned writecache off on old drives but Mark Lord has
really good points even there. And for scsi we do tagging and the
journals can be ordered depending on your need.

You are storing 40 billion bits of information on a lump of metal and
glass rotating at 10,000rpm and pushing into areas of quantum theory in
order to store you data. It should be no suprise it might not be there a
month later.

You also appear confused: It isn't the maintainers responsibility to
arrange for such info. It's the maintainers responsibility to process
contributed patches with such info.


