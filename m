Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261383AbUK1BSa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261383AbUK1BSa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 20:18:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261384AbUK1BSa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Nov 2004 20:18:30 -0500
Received: from postman2.arcor-online.net ([151.189.20.157]:56229 "EHLO
	postman.arcor.de") by vger.kernel.org with ESMTP id S261383AbUK1BSW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Nov 2004 20:18:22 -0500
Message-ID: <33262.192.168.0.2.1101597468.squirrel@192.168.0.10>
In-Reply-To: <slrncqhqib.19r.psavo@varg.dyndns.org>
References: <33133.192.168.0.2.1101499190.squirrel@192.168.0.10>
    <32942.192.168.0.2.1101549298.squirrel@192.168.0.10>
    <slrncqhqib.19r.psavo@varg.dyndns.org>
Date: Sun, 28 Nov 2004 00:17:48 +0100 (CET)
Subject: Re: Is controlling DVD speeds via SET_STREAMING supported?
From: "Thomas Fritzsche" <tf@noto.de>
To: "Pasi Savolainen" <psavo@iki.fi>
Cc: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pasi,

the error message you receive means that your device don't support the SET
STREAMING command. But I'm wondering because an other user reported
success with exactly the DVD model you have. Do you use the latest FW? Do
you have any other special software / hardware setup that could explain
this difference?
What Kernel do you use?
I'm still testing on 2.4.27'er kernel.

Thanks for the feedback and regards,
 Thomas



> * Thomas Fritzsche <tf@noto.de>:
>> Hi Jens,
>>
>> I build a new version that addresse this issues.
>>
>> Usage: speed -x <speed> <device>
>> (speed = 0 means reset to defaults)
>
> Tried, didn't work. If there's some other info you need,
> please tell me.
>
> Thanks.
>
>
> # ./dvdspeed /dev/dvd
> Command failed: b6 00 00 00 00 00 00 00 00 00 1c 00  - sense: 05.20.00
> ERROR.
>
> # hdparm -i /dev/dvd
>
> /dev/dvd:
>
>  Model=SAMSUNG DVD-ROM SD-616E, FwRev=F502, SerialNo=
>  Config={ Fixed Removeable DTR<=5Mbs DTR>10Mbs nonMagnetic }
>  RawCHS=0/0/0, TrkSize=0, SectSize=0, ECCbytes=0
>  BuffType=unknown, BuffSize=0kB, MaxMultSect=0
>  (maybe): CurCHS=0/0/0, CurSects=0, LBA=yes, LBAsects=0
>  IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
>  PIO modes:  pio0 pio1 pio2 pio3 pio4
>  DMA modes:  sdma0 sdma1 sdma2 mdma0 mdma1 mdma2
>  UDMA modes: udma0 udma1 *udma2
>  AdvancedPM=no
>  Drive conforms to: device does not report version:
>
>  * signifies the current active mode
>
> # tail -f /var/log/messages
> ...
> Nov 27 22:52:49 tienel kernel: hdb: packet command error: status=0x51 {
> DriveReady SeekComplete Error }
> Nov 27 22:52:49 tienel kernel: hdb: packet command error: error=0x54
> Nov 27 22:52:49 tienel kernel: ide: failed opcode was 100
>
>
> --
>    Psi -- <http://www.iki.fi/pasi.savolainen>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>


