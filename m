Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261280AbTEYDOS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 May 2003 23:14:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261292AbTEYDOS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 May 2003 23:14:18 -0400
Received: from nn8.excitenetwork.com ([207.159.120.62]:33363 "EHLO
	xmxpita.excite.com") by vger.kernel.org with ESMTP id S261280AbTEYDOR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 May 2003 23:14:17 -0400
To: linux-kernel@vger.kernel.org
Subject: 2.4.21-rc3 PCMCIA serial_cs.c Reproducible Hang
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: ID = 21f2811f0b913155067498016a2ddcb2
Reply-To: paragw@excite.com
From: "Parag Warudkar" <paragw@excite.com>
MIME-Version: 1.0
X-Mailer: PHP
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <20030525032719.AB01DB6B7@xmxpita.excite.com>
Date: Sat, 24 May 2003 23:27:19 -0400 (EDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[NOT SUBSCRIBED ]Pls. CC me to all replies.

Using 2.4.21-rc3 - The kernel hangs in the process of booting, (No response to anything - including alt+sysrq) right after starting the PCMCIA service.
Distro is RH 8.0 and I have CompactModem card in socket 1 -
Cardctl ident reports this about the card:
Socket 1:
  product info: "PRETEC", "CompactModem 3.3V 56K", "021", "A"
  manfid: 0x0013, 0x0000
  function: 2 (serial)
The hang is reproducible - always.

Booting with RH kernel 2.4.20-21 doesn't show this problem.
Looking at drivers/char/pcmcia there seem to be good amount of
differences between plain 2.4.20 and 2.4.21-rc3 serial_cs.c.

If I go back to serial_cs.c (v1.128) from 2.4.20 and compile it with 2.4.21-rc3, the hang is no longer reproducible. (BTW, serial_cs.c is compiled as a module)

Will try to narrow down to the change which actually causes the hang in
2.4.21-rc3, so it can atleast be rolled back or better - fixed in 2.4.21.

--
Parag



_______________________________________________
Join Excite! - http://www.excite.com
The most personalized portal on the Web!
