Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262474AbTH0X7E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 19:59:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262497AbTH0X7E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 19:59:04 -0400
Received: from ozlabs.org ([203.10.76.45]:34954 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262489AbTH0X67 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 19:58:59 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16205.17596.600646.259901@martins.ozlabs.org>
Date: Thu, 28 Aug 2003 09:54:36 +1000
To: linux-kernel@vger.kernel.org
Cc: B.Zolnierkiewicz@elka.pw.edu.pl, linux-ide@vger.kernel.org,
       Patrick Mochel <mochel@osdl.org>, Con Kolivas <kernel@kolivas.org>
Subject: 2.6.0-test4 suspends IDE devices after resume
X-Mailer: VM 7.17 under Emacs 21.3.2
From: "Martin Schwenke" <martin@meltin.net>
Reply-To: "Martin Schwenke" <martin@meltin.net>
X-Kernel: Linux 2.6.0-test4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm running 2.6.0-test4 (with Con Kolivas' interactivity patch) and
twice I've had my IDE devices re-suspend after I resume from an APM
suspend (to disk/hibernation).  This is obviously annoying, because
there's little you can do to recover from it!  :-) The machine is an
IBM ThinkPad T22 with an IDE interface that looks like this:

  00:07.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01)

I didn't see this problem with test3 (or test2 or test1).

Stuff I copied down from the console is at the end of this message.
"..." indicates intermingled USB stuff that I didn't write down.

Apart from that, I've also seen a message in my logs that looks like:

  hda: a request made it's way while we are power managing...

Any ideas?

peace & happiness,
martin
--------8<---------8<-------- CUT HERE --------8<---------8<--------
hda: start_power_step(step: 1000)
blk: queue dfe50800, I/O limit 4095Mb (mask 0xffffffff)
hda: completing PM request, resume
hdc: Wakeup request inited, waiting for !BSY...
hdc: start_power_step(step: 1000)
hdc: completing PM request, resume
...
hdc: start_power_step(step: 0)
hdc: completing PM request, suspend
hda: start_power_step(step: 0)
hda: start_power_step(step: 1)
hda: complete_power_step(step: 1, stat: 50, err: 0)
hda: completing PM request, suspend
hda: Wakeup request inited, waiting for !BSY...
hda: start_power_step(step: 1000)
blk: queue dfe50800, I/O limit 4095Mb (mask 0xffffffff)
hda: completing PM request, resume
hdc: Wakeup request inited, waiting for !BSY...
hdc: start_power_step(step: 1000)
hdc: completing PM request, resume
...
hdc: start_power_step(step: 0)
hdc: completing PM request, suspend
hda: start_power_step(step: 0)
hda: start_power_step(step: 1)
hda: complete_power_step(step: 1, stat: 50, err: 0)
hda: completing PM request, suspend
--------8<---------8<-------- CUT HERE --------8<---------8<--------

