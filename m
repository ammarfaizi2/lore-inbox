Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261323AbUK0U6I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261323AbUK0U6I (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 15:58:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261327AbUK0U6H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Nov 2004 15:58:07 -0500
Received: from main.gmane.org ([80.91.229.2]:14727 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261323AbUK0U5w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Nov 2004 15:57:52 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Pasi Savolainen <psavo@iki.fi>
Subject: Re: Is controlling DVD speeds via SET_STREAMING supported?
Date: Sat, 27 Nov 2004 20:57:47 +0000 (UTC)
Message-ID: <slrncqhqib.19r.psavo@varg.dyndns.org>
References: <33133.192.168.0.2.1101499190.squirrel@192.168.0.10> <32942.192.168.0.2.1101549298.squirrel@192.168.0.10>
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: a11a.mannikko1.ton.tut.fi
X-Face: $sk2zxhxVp'QPUj~kr+z:<m>#+84DO\Ab{4Hes1.P>]p=XhgsnwZM^[:"M?W#_x{W5[lu7i bqv7lOL`]5G%fH"Pgd5;+t"w)sOPDg::&T$Z9p#|xSMIb`$Udj6u14lh]imQ\z
User-Agent: slrn/0.9.8.1 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Thomas Fritzsche <tf@noto.de>:
> Hi Jens,
>
> I build a new version that addresse this issues.
>
> Usage: speed -x <speed> <device>
> (speed = 0 means reset to defaults)

Tried, didn't work. If there's some other info you need,
please tell me.

Thanks.


# ./dvdspeed /dev/dvd
Command failed: b6 00 00 00 00 00 00 00 00 00 1c 00  - sense: 05.20.00
ERROR.

# hdparm -i /dev/dvd

/dev/dvd:

 Model=SAMSUNG DVD-ROM SD-616E, FwRev=F502, SerialNo=
 Config={ Fixed Removeable DTR<=5Mbs DTR>10Mbs nonMagnetic }
 RawCHS=0/0/0, TrkSize=0, SectSize=0, ECCbytes=0
 BuffType=unknown, BuffSize=0kB, MaxMultSect=0
 (maybe): CurCHS=0/0/0, CurSects=0, LBA=yes, LBAsects=0
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4 
 DMA modes:  sdma0 sdma1 sdma2 mdma0 mdma1 mdma2 
 UDMA modes: udma0 udma1 *udma2 
 AdvancedPM=no
 Drive conforms to: device does not report version: 

 * signifies the current active mode

# tail -f /var/log/messages
...
Nov 27 22:52:49 tienel kernel: hdb: packet command error: status=0x51 { DriveReady SeekComplete Error }
Nov 27 22:52:49 tienel kernel: hdb: packet command error: error=0x54
Nov 27 22:52:49 tienel kernel: ide: failed opcode was 100


-- 
   Psi -- <http://www.iki.fi/pasi.savolainen>

