Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264521AbTDPRkk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 13:40:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264527AbTDPRkj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 13:40:39 -0400
Received: from smtp016.mail.yahoo.com ([216.136.174.113]:61444 "HELO
	smtp016.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264521AbTDPRkh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 13:40:37 -0400
From: Michael Buesch <fsdeveloper@yahoo.de>
To: Valdis.Kletnieks@vt.edu
Subject: Re: 2.4.x Problem with cd writing
Date: Wed, 16 Apr 2003 19:52:12 +0200
User-Agent: KMail/1.5
References: <200304161919.08615.fsdeveloper@yahoo.de> <200304161743.h3GHhXSt005248@turing-police.cc.vt.edu>
In-Reply-To: <200304161743.h3GHhXSt005248@turing-police.cc.vt.edu>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304161952.12830.fsdeveloper@yahoo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 16 April 2003 19:43, Valdis.Kletnieks@vt.edu wrote:
> I thought this was a generic IDE issue - fixation requires the controller's
> undivided attention and was basically a hardware restriction.  Are you sure
> that it's ever NOT frozen the interface?

There is just no access to the ide-bus. No bit is let through.
With the kernel used in SuSE 7.3 (was something around 2.4.10)
writing worked fine.

mb@lfs:/proc/ide> cat /proc/ide/drivers 
ide-scsi version 0.93
ide-cdrom version 4.59
ide-disk version 1.16

mb@lfs:/proc/ide/ide0> cat /proc/ide/ide0/config 
pci bus 00 device f9 vendor 8086 device 244b channel 0
86 80 4b 24 05 00 80 02 05 80 01 01 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
01 fc 00 00 00 00 00 00 00 00 00 00 62 14 81 39
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
77 e3 77 e3 bb 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 10 04 10 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 47 0f 00 00 00 00 00 00
mb@lfs:/proc/ide/ide0> cat /proc/ide/ide1/config 
pci bus 00 device f9 vendor 8086 device 244b channel 1
86 80 4b 24 05 00 80 02 05 80 01 01 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
01 fc 00 00 00 00 00 00 00 00 00 00 62 14 81 39
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
77 e3 77 e3 bb 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 10 04 10 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 47 0f 00 00 00 00 00 00

mb@lfs:/proc/ide> cat /proc/ide/piix 

Controller: 0

                                Intel PIIX4 Ultra 100 Chipset.
--------------- Primary Channel ---------------- Secondary Channel -------------
                 enabled                          enabled
--------------- drive0 --------- drive1 -------- drive0 ---------- drive1 ------
DMA enabled:    yes              yes             yes               yes
UDMA enabled:   no               no              no                no 
UDMA enabled:   X                X               X                 X
UDMA
DMA
PIO


-- 
Regards Michael Buesch.
http://www.8ung.at/tuxsoft

$ cat /dev/zero > /dev/null
/dev/null: That's *not* funny! :(

