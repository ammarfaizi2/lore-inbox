Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129909AbRBFT5r>; Tue, 6 Feb 2001 14:57:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130157AbRBFT5h>; Tue, 6 Feb 2001 14:57:37 -0500
Received: from zooty.lancs.ac.uk ([148.88.16.231]:11731 "EHLO
	zooty.lancs.ac.uk") by vger.kernel.org with ESMTP
	id <S129909AbRBFT5Z>; Tue, 6 Feb 2001 14:57:25 -0500
Message-Id: <l03130303b6a6054060f8@[192.168.239.105]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Tue, 6 Feb 2001 19:57:17 +0000
To: Peter Horton <pdh@colonel-panic.com>, linux-kernel@vger.kernel.org
From: Jonathan Morton <chromi@cyberspace.org>
Subject: Re: VIA silent disk corruption - patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>I still get corruption with "I/O Recovery Time" enabled :-(
>
>I don't get corruption with the BIOS "normal" settings (1004D).
>
>I might update my BIOS to the latest BIOS in case it changes any other
>settings.

I'm using an Abit KT7 m/board, which uses the same KT133 chipset that I
believe you are all talking about.  Note this is distinct from the KT7-RAID
which has a UDMA-100 RAID chipset on it in addition to the normal IDE
bridge.  I've had no problems with disk corruption, despite turning
everything I dare in the BIOS to "full optimisation" settings - this
includes the "Fast CPU Command Decode" and "Enhance Chipset Performance".

The CPU is a Duron 700MHz, and the drives in question are a Seagate
Barracuda ST310210A on hda and a TEAC CD-540E on hdc.  /sbin/hdparm reports
both drives as NOT using DMA, I might try switching it on and seeing what
happens.

... half an hour later, i actually try it.  Machine appears to be locked
while performing hdparm -t /dev/hda, but waiting to see if it's actually a
timeout.  Performance is abysmal when UDMA is off, incidentally - less than
5Mb/sec from this 7200rpm drive.  The 10,000rpm IBM SCSI drive also in that
machine benchmarks at around 35Mb/sec.

... after about 10 minutes waiting, while adding to this e-mail, the box is
still hung.  Hmph...  *RESET*

--------------------------------------------------------------
from:     Jonathan "Chromatix" Morton
mail:     chromi@cyberspace.org  (not for attachments)
big-mail: chromatix@penguinpowered.com
uni-mail: j.d.morton@lancaster.ac.uk

The key to knowledge is not to rely on people to teach you it.

Get VNC Server for Macintosh from http://www.chromatix.uklinux.net/vnc/

-----BEGIN GEEK CODE BLOCK-----
Version 3.12
GCS$/E/S dpu(!) s:- a20 C+++ UL++ P L+++ E W+ N- o? K? w--- O-- M++$ V? PS
PE- Y+ PGP++ t- 5- X- R !tv b++ DI+++ D G e+ h+ r- y+
-----END GEEK CODE BLOCK-----


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
