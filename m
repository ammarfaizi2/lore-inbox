Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264542AbUASLIY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 06:08:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264558AbUASLIY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 06:08:24 -0500
Received: from zigzag.lvk.cs.msu.su ([158.250.17.23]:6803 "EHLO
	zigzag.lvk.cs.msu.su") by vger.kernel.org with ESMTP
	id S264542AbUASLIR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 06:08:17 -0500
From: "Nikita V. Youshchenko" <yoush@cs.msu.su>
To: linux-kernel@vger.kernel.org
Subject: System died because of ide-scsi
Date: Mon, 19 Jan 2004 14:08:14 +0300
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401191408.14699@zigzag.lvk.cs.msu.su>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

I'm not sure where to report bugs in ide-scsi in kernel 2.4, so trying 
here ...

I've just suffered a system misbehaviour that ended with a system crash on 
a production server running Linux kernel 2.4.24 SMP. This server acts as 
terminal server here, running 10-15 KDE sessions.

The problem happened when someone started CD recording operation while CD 
was mounted. (It's interesting why he was able to do that, but that's 
another story).

After that, system because very unresponsive (up to 10 seconds to process a 
key press). System load meter was able to refresh it's screen for several 
times, and showed both CPUs were "100% SYS".

It wass possible to switch server console from X to text console (athough 
it took up to mitute to process Ctrl+Alt+F1). On the text cousole, about 
onse a second the following line was printed:

ide-scsi: Strange, packet command initiated yet DRQ isn't asserted

I could log in as root on the console and type several commands (again, up 
to 10 seconds to process a key press). I tried to reset the device using 
hdparm, and that caused kernel oops.


I don't feel I can debug this problem myself. However, if it will help, I 
will provide all system information on request.


