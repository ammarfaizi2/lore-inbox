Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263369AbTEMHXP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 03:23:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263373AbTEMHWM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 03:22:12 -0400
Received: from dp.samba.org ([66.70.73.150]:26253 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S263370AbTEMHWH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 03:22:07 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Peter Chubb <peter@chubb.wattle.id.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: can't build IDE as modules in BK 2.5.69 
In-reply-to: Your message of "Tue, 13 May 2003 13:44:12 +1000."
             <16064.27148.819310.962984@wombat.chubb.wattle.id.au> 
Date: Tue, 13 May 2003 14:55:23 +1000
Message-Id: <20030513073453.480DD2C240@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <16064.27148.819310.962984@wombat.chubb.wattle.id.au> you write:
> 
> With the 2.5 bk linux as of 2003.05.13, and config options below,
> modutils seems to go into a seemingly infinite loop when trying to
> buld modules.dep on the resulting module set (and creates an extremely
> large modules.dep file -- 95M before the filesystem filled up)

Grrr... I thought that was fixed.  What version of depmod you using
(depmod -V).

Real problem is actual dependency loop in IDE modules, but depmod
should just report that and ignore the modules involved.

> WARNING: Module /lib/modules/2.5.69/kernel/drivers/scsi/ide-scsi.ko
> ignored, due to loop
> WARNING: Module /lib/modules/2.5.69/kernel/drivers/ide/pci/piix.ko
> ignored, due to loop
> WARNING: Module /lib/modules/2.5.69/kernel/drivers/ide/ide.ko ignored,
> due to loop
> WARNING: Module /lib/modules/2.5.69/kernel/drivers/ide/ide-taskfile.ko
> ignored, due to loop
> WARNING: Module /lib/modules/2.5.69/kernel/drivers/ide/ide-probe.ko
> ignored, due to loop

Thanks for the report,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
