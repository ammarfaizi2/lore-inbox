Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262164AbUK3Q25@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262164AbUK3Q25 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 11:28:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262134AbUK3Q24
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 11:28:56 -0500
Received: from postman1.arcor-online.net ([151.189.20.156]:41669 "EHLO
	postman.arcor.de") by vger.kernel.org with ESMTP id S262164AbUK3Q2l
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 11:28:41 -0500
Message-ID: <33560.194.39.131.40.1101824878.squirrel@noto.dyndns.org>
Date: Tue, 30 Nov 2004 15:27:58 +0100 (CET)
Subject: growisofs / system load / dma setting
From: "Thomas Fritzsche" <tf@noto.de>
To: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linux-Hackers,

I posted this message first to the cdwriter mailing list (
http://www.mail-archive.com/cdwrite%40other.debian.org/msg07041.html )
but they told me this is a kernel problem, thus I post it here again.
Because I had this DVD-Device running without problem in 2.6.8 I can
exclude that it's a cabel/hw-problem.

Thanks and regards,
 Thomas Fritzsche
---------------------------------------
Hi all,

I'm using growisofs -Z /dev/hdc=/link/to/iso.iso to burn DVD-Video's. This
works, BUT the system load is very high while burning. I'l checked DMA
setting but DMA is on (and 32 bit). I googled around but can not find a
solution. I tried again and found that after burning dma is off!? I
checked dmesg and found message:
--------------------------------------
hdc: irq timeout: status=0xd0 { Busy }
hdc: irq timeout: error=0xd0LastFailedSense 0x0d
hdc: DMA disabled
hdc: ATAPI reset complete
--------------------------------------
I tested a few times and sometimes only the system load is very high but
DMA  is still set after the run, but often DMA setting is disabled and I
get the message above.

My system configuration is:

uname -a
Linux vdr.noto.de 2.4.27-ctvdr-1 #1 Fri Oct 15 18:38:29 UTC 2004 i686
GNU/Linux

hdparm -i /dev/hdc


/dev/hdc:

 Model=_NEC DVD_RW ND-3500AG, FwRev=2.16, SerialNo=
 Config={ Removeable DTR<=5Mbs DTR>10Mbs nonMagnetic }
 RawCHS=0/0/0, TrkSize=0, SectSize=0, ECCbytes=0
 BuffType=unknown, BuffSize=0kB, MaxMultSect=0
 (maybe): CurCHS=0/0/0, CurSects=0, LBA=yes, LBAsects=0
 IORDY=yes, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4
 DMA modes:  mdma0 mdma1 mdma2
 UDMA modes: udma0 udma1 *udma2
 AdvancedPM=no

 * signifies the current active mode

------------------------------

Is this a growisofs problem or a kernel problem? What causes this trouble?
What can I do to avoid this problems.

Thanks for any help and kind regards,
 Thomas Fritzsche



