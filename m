Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267512AbUHEA2V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267512AbUHEA2V (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 20:28:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267524AbUHEA2U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 20:28:20 -0400
Received: from avalon.servus.at ([193.170.194.18]:6533 "EHLO wildsau.enemy.org")
	by vger.kernel.org with ESMTP id S267512AbUHEA2T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 20:28:19 -0400
From: "H.Rosmanith (Kernel Mailing List)" <kernel@wildsau.enemy.org>
Message-Id: <200408050025.i750P3Li010082@wildsau.enemy.org>
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
In-Reply-To: <20040804124335.GK10340@suse.de>
To: Jens Axboe <axboe@suse.de>
Date: Thu, 5 Aug 2004 02:25:02 +0200 (MET DST)
CC: linux-kernel@vger.kernel.org, schilling@fokus.fraunhofer.de
X-Mailer: ELM [version 2.4ME+ PL100 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > + * Sat Jun 12 12:48:12 CEST 2004 herp - Herbert Rosmanith
> > + *     Force ATAPI driver if dev= starts with /dev/hd and device
> > + *     is present in /proc/ide/hdX
> > + *
> 
> That's an extremely bad idea, you want to force ATA driver in either
> case.

I don't think so.

If "dev=/dev/hd?" and "/dev/hd?" is *not* present in /proc/ide, then
cdrtools falls back to the default behaviour, which is: treat it as
scsi device.

If the device cannot be found in /proc/ide, it simply does not make sense
to treat it as atapi device - because it is none.

best regards,
Herbert Rosmanith

