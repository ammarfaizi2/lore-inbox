Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261644AbTH2Su4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 14:50:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261684AbTH2Su4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 14:50:56 -0400
Received: from pc2-cmbg2-3-cust36.cmbg.cable.ntl.com ([80.2.245.36]:7111 "EHLO
	sphinx.ast.xaqithis.com") by vger.kernel.org with ESMTP
	id S261644AbTH2StU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 14:49:20 -0400
Date: Fri, 29 Aug 2003 19:49:19 +0100
From: cb-lkml@fish.zetnet.co.uk
To: linux-kernel@vger.kernel.org
Subject: [2.6.0-test4] IDE power management
Message-ID: <20030829184919.GA21155@xaqithis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Since 2.6.0-test4, and in -mmX IDE power management no longer works for
me.  Using Fn+F12 to initiate APM suspend-to-disk, the suspend starts as
normal, then the disk spins down, which is wrong, because the disk spins
up again to perform the actual save-to-disk operation.

The laptop is a Sony Vaio 333MHz celeron, with a PIIX4 IDE controller.

This used to work fine in all previous kernels.

I get the following log messages:

hda: start_power_step(step: 0)
hda: start_power_step(step: 1)
hda: complete_power_step(step: 1, stat: 50, err:0)
hda: completing PM request, suspend
hda: a request made it's way while we are power managing
--- power down/up occurs here
hda: Wakeup request inited, waiting for !BSY...
hda: start_power_step(step: 1000)
hda: completing PM request, resume
...
hda: lost interrupt

The hard disk won't allow any accesses any more.

APM suspend to RAM doesn't work properly on this machine, so I haven't
tested that.

Charlie
