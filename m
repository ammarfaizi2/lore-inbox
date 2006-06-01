Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751294AbWFBMV6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751294AbWFBMV6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 08:21:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751286AbWFBMV6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 08:21:58 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:44265 "EHLO
	out.lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751294AbWFBMV5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 08:21:57 -0400
Subject: Re: Query: No IDE DMA for IBM 365X with PIIX chipset?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Mark Lord <lkml@rtr.ca>
Cc: Grant Coady <gcoady.lk@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <447F2257.4000404@rtr.ca>
References: <j9bi729h2u4dcn9da7na3t1d8ckk477d9b@4ax.com>
	 <1149169812.12932.20.camel@localhost>  <447F2257.4000404@rtr.ca>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 01 Jun 2006 19:52:13 +0100
Message-Id: <1149187933.12932.70.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2006-06-01 at 13:22 -0400, Mark Lord wrote:
> That's the original Intel "triton" chipset.
> I have a spare printed Intel document for the chipset (Intel #290519-001)
> which I can mail you (Alan).  Email me privately with a postal address.

>From the other docs it appears 0x122E is the ISA bridge and this laptop
has 0x122E (PIIX bridge) and an 82437MX system controller, but no PIIX
IDE. That actually suggests its more like the "MPIIX" which has a PIO
only IDE controller existing (logically anyway) on the ISA side of the
system.

That would explain the observed behaviour and fit with the pattern of
PCI identifiers. Now to hunt 82437 docs.

(In the mean time try adding the 0x1235 id to the 2.6.17-mm kernel in
drivers/scsi/pata_mpiix and see if that works with the new libata layer
not drivers/ide).

Alan

