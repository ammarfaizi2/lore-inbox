Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263002AbTK3T6Y (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 14:58:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263008AbTK3T6X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 14:58:23 -0500
Received: from 204.Red-213-96-224.pooles.rima-tde.net ([213.96.224.204]:19725
	"EHLO betawl.net") by vger.kernel.org with ESMTP id S263002AbTK3T6W
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 14:58:22 -0500
Date: Sun, 30 Nov 2003 20:58:15 +0100
From: Santiago Garcia Mantinan <lkml@manty.net>
To: linux-kernel@vger.kernel.org
Subject: IDE DMA setting not available on 2.4.23 as a module
Message-ID: <20031130195815.GA2409@man.beta.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Yesterday I started to upgrade my systems to 2.4.23, some of them were
already running pre or rc versions, but when I tried my Pentium MMX wich
boots out of SCSI and on which I like to have IDE driver as a module, I
found that the DMA setting was not working, hdparm was saying:

 setting using_dma to 1 (on)
 HDIO_SET_DMA failed: Operation not permitted

So I changed the driver option to set DMA by default to ON, but nothing
changed, still the same problem, then I tried to compile the IDE driver into
the kernel instead of having it as a module and then the dma support started
to work, either having the driver enable it by default or by setting it with
hdparm.

The motherboard uses a 430TX chipset, thus with a PIIX4 IDE controller.

Is this a bug or is this a known and accepted limitation of having the IDE
driver as a module?

If you want me to test any patch to see if we can fix this, or need any more
info, don't hesitate to contact me.

Regards...
-- 
Manty/BestiaTester -> http://manty.net
