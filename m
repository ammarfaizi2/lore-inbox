Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261539AbTJCXeq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 19:34:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261538AbTJCXep
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 19:34:45 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:32979 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261539AbTJCXem
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 19:34:42 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] kill dummy init_dma_* from drivers/ide/pci/
Date: Sat, 4 Oct 2003 01:38:08 +0200
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310040138.08690.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ide_hwif_setup_dma() checks for !d->init_dma and calls ide_setup_dma()
in such case, there is no need for dummy init_dma_* functions.

Remove them from: cmd64x.c, cs5530.c, generic.c, hpt34x.c, it8172.c,
ns87415.c, opti621.c, pdcnew.c, piix.c, sc1200.c, siimage.c, sis5513.c
and slc90e66.c.

Patches will be posted as replies.

--bartlomiej

