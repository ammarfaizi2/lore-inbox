Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266429AbRGCDCM>; Mon, 2 Jul 2001 23:02:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266430AbRGCDCD>; Mon, 2 Jul 2001 23:02:03 -0400
Received: from [211.58.12.166] ([211.58.12.166]:24329 "EHLO progress.plw.net")
	by vger.kernel.org with ESMTP id <S266429AbRGCDBt>;
	Mon, 2 Jul 2001 23:01:49 -0400
Date: Tue, 3 Jul 2001 12:01:16 +0900 (KST)
From: Byeong-ryeol Kim <jinbo21@hananet.net>
Reply-To: Byeong-ryeol Kim <jinbo21@hananet.net>
To: <linux-kernel@vger.kernel.org>
Subject: re: pcmcia lockup inserting or removing cards in 2.4.5-ac{13,22}
In-Reply-To: <3B448CA1@operamail.com>
Message-ID: <Pine.LNX.4.33.0107031139090.5430-100000@progress.plw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Jul 2001, mr sam jooky wrote:

>>Somewhere between 2.4.2 and 2.4.5-ac13, PCMCIA card insertion and
>>removal appears to have broken on my Toshiba Libretto. On 2.4.2 all was
>>fine. On both 2.4.5-ac13 and ac22 it's broken. The whole machine
>>freezes
>>solid, no SAK-s, SAK-u, SAK-b, no Ctrl-Alt-Fn to switch VC's. No
>>messages
>>are issued. Problem occurs when inserting/removing any of YE-Data
>>PCMCIA
>>floppy, TDK Smartmedia adapter (ide_cs), or 3c589 ethernet card.
>
>On my IBM Thinkpad 390E my PCMCIA works fine with 2.4.5, on very rare
>occasions
>the mouse will drift diagonaly to the lower right corner. I read in the kernel
>sources that this happens normaly due to probing of the PCMCIA which screws up
>the mouse device. It happens so rarely I have not yet taken the time to try to
>debug it.
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
...

Just FYI.(maybe worthless without ksymoops report)

My ThinkPad 600X(Coppermine 500 MHZ, 100 MHZ SDRAM 320 MB, NeoMagic 256Z
Video chipset, UDMA3 IDE hdd, cardbus IBM Etherjet 10/100 - Xircom oem,
tulip 21143 compatible, external mii tranceiver - Cirrus CS46XX sound
chipset) was completely locked up the system  while loading yenta_socket
and other modules.
But, Mr. David Hinds' pcmcia-cs-3.1.26(i82365, tulip_cs) always works well.
This was the first time for me to try to experiment with built-in pcmcia
support of regular linux kernel after 2.4.0 kernel was released.

I have been using only pcmcia-cs-3.1.2x since I bought 600X in Dec 2000,
because pcmcia drivers of 2.4.0-testX kernel doesn't worked wel at that
time.
I use kernel-2.4.3-ac22, gcc-2.96-88, binutils-2.11.90.0.19, glibc-2.2.3,
XFree86-4.1.0, ..).

-- 
Where there is a will, there is a way.       jinbo21@hananet.net
  For the future of you and me!              jinbo21@hitel.net
fingerprint = 1429 8AAF 8A2C 6043 DA2E  BD4C 964C 2698 687D 4B7D

