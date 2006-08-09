Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751391AbWHIVnm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751391AbWHIVnm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 17:43:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751388AbWHIVnm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 17:43:42 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:53635 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750750AbWHIVnl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 17:43:41 -0400
Subject: Re: /dev/sd*
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
In-Reply-To: <20060809212124.GC3691@stusta.de>
References: <1155144599.5729.226.camel@localhost.localdomain>
	 <20060809212124.GC3691@stusta.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 09 Aug 2006 23:01:43 +0100
Message-Id: <1155160903.5729.263.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Mer, 2006-08-09 am 23:21 +0200, ysgrifennodd Adrian Bunk:
> It might be a bit out of the scope of this thread, but why do some many 
> subsystems use the /dev/sd* namespace?
> 
> Real SCSI devices use it.
> The USB mass storage driver uses it.

USB storage is real SCSI.

> libata uses it.
> 
> I'd expext SATA or PATA devices at /dev/hd* or perhaps at /dev/ata* - 
> but why are they at /dev/sd*?

ATA uses the top half of the scsi stack so ends up using the top layer
scsi drivers. Its probably more efficient than writing new driver
clones, especially as non disk ATA is also real SCSI (or very close).

You can use /dev/ata if you want - its just a udev problem ;)

Alan

