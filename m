Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261399AbULARuv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261399AbULARuv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 12:50:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261401AbULARuv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 12:50:51 -0500
Received: from mail5.speakeasy.net ([216.254.0.205]:42419 "EHLO
	mail5.speakeasy.net") by vger.kernel.org with ESMTP id S261399AbULARuq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 12:50:46 -0500
Date: Wed, 1 Dec 2004 11:50:45 -0600
From: John Lash <jlash@speakeasy.net>
To: linux-kernel@vger.kernel.org
Subject: dma errors with sata_sil and Seagate disk
Message-ID: <20041201115045.3ab20e03@homer.sarvega.com>
X-Mailer: Sylpheed-Claws 0.9.12cvs102 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm using the sata_sil driver on a Tyan 2885. It has onboard Silicon Image 3114
SATA interfaces. There's one disk connected now, a Seagate ST380013AS. I've been
seeing persistent problems with errors (DriveStatusError) on the device. It
seems to happen pretty quickly under a load (trying to copy a couple of GB of
files to the disk).

I noticed that the sil_blacklist had quite a few Seagate entries and on
searching the web, found that these were dma problems that looked pretty similar
to mine. Since then I've added this model number to the sil_blacklist table,
rebuilt and rebooted. Now it's stable (just copied 20 GB of data to it). Is this
another problematic drive? Or am I masking the original problem?

I see the problem consistently on 2.6.8.1, 2.6.9, and 2.6.10-rc2-bk13. Also saw
the problems when I tried this on an older AMD MP system with a SI 3112 PCI
controller card.

I don't see any indication that Seagate has released any public firmware
upgrades for this drive. Anybody have a suggestion?

--john
