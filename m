Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131289AbRDFFwS>; Fri, 6 Apr 2001 01:52:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131296AbRDFFv7>; Fri, 6 Apr 2001 01:51:59 -0400
Received: from smtp2.free.fr ([212.27.32.6]:12812 "EHLO smtp2.free.fr")
	by vger.kernel.org with ESMTP id <S131289AbRDFFvl>;
	Fri, 6 Apr 2001 01:51:41 -0400
To: ramorris@dilithium.net, "Robert A. Morris" <ramorris@dilithium.net>
Subject: Re: 2.2.19 + ide 2.2.19 03252001 patch problem
Message-ID: <986536241.3acd59318b222@imp.free.fr>
Date: Fri, 06 Apr 2001 07:50:41 +0200 (MEST)
From: Willy Tarreau <wtarreau@free.fr>
Cc: linux-kernel@vger.kernel.org, bugs@linux-ide.org
In-Reply-To: <TradeClient.0.9.0.Linux-2.2.18.0104052013545D.1150@ryoko.unguez.net>
In-Reply-To: <TradeClient.0.9.0.Linux-2.2.18.0104052013545D.1150@ryoko.unguez.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: IMP/PHP IMAP webmail program 2.2.3
X-Originating-IP: 212.27.52.71
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting "Robert A. Morris" <ramorris@dilithium.net>:
[snip]
> Apr  5 18:15:14 ryoko kernel: hdb: task_no_data_intr: status=0x51 {
> DriveReady SeekComplete Error }
> Apr  5 18:15:14 ryoko kernel: hdb: task_no_data_intr: error=0x04 {
> DriveStatusError }
> Apr  5 18:15:14 ryoko kernel: hdb: Write Cache FAILED Flushing!
[snip]
> This did NOT happen with 2.2.18 and the corresponding 
> ide.2.2.18.1209.patch.  It does NOT seem to happen on
> /dev/hda or /dev/hdc, which is lucky, since /dev/hdb
> is unused.  I'm using lilo.conf to specify idebus=33.
[snip] 
> The controller is a VIA 82C686A (Asus K7V mainboard).
> hda: WDC WD307AA, 29333MB w/2048kB Cache, CHS=3739/255/63, UDMA(66)
> hdb: WDC AC28400R, 8063MB w/512kB Cache, CHS=1027/255/63, (U)DMA
> hdc: WDC WD307AA-00BAA0, 29333MB w/2048kB Cache, CHS=59598/16/63,
> UDMA(66)

same problem observed here on same motherboard. The hard disk is a WDC AC23200L
configured as hda. I have tested several ide/kernel combinations and all I can
say is that 2.2.18 and 2.2.19 behave the same, but it worked till
ide.2.2.18.1221 included, and the bug appeared since ide.2.2.18.02122001.
I tried with and without vojtech's via patches (3.2, 4.2 and 4.3), but this
didn't change anything (to be honest, some combinations were obviously not made
to live together, and I had so many problems fitting all patches in one kernel
that it sometimes even didn't boot).

I can also say that this problem didn't show up on other chipsets (ali and
intel) with the same kernel+ide patch.

finally, I made my kernel with ide.2.2.18.1221 and all seems to be OK (one week
now). The diffs between the 2 versions were too important and I have not
investigated further into this, but I'm ready to make some tests if needed.

Regards,
Willy

PS: BTW Andre, could you please name your patches ide-2.2.19-YYYYMMDD so that a
    directory listing show the chronological order ?
