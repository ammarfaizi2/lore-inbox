Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313137AbSDSXPa>; Fri, 19 Apr 2002 19:15:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314137AbSDSXP3>; Fri, 19 Apr 2002 19:15:29 -0400
Received: from rwcrmhc53.attbi.com ([204.127.198.39]:7397 "EHLO
	rwcrmhc53.attbi.com") by vger.kernel.org with ESMTP
	id <S313137AbSDSXP1>; Fri, 19 Apr 2002 19:15:27 -0400
From: "Jordan Breeding" <jordan.breeding@attbi.com>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Trouble rebooting Tyan Thunder K7 (S2462UNG)
Date: Fri, 19 Apr 2002 23:15:23 -0000
Message-ID: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAAjQHXypTRWUeX0Da3WGxUUMKAAAAQAAAAb2jlXi9TM0a+IKeYbO47lAEAAAAA@attbi.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

  I am having trouble getting a brand new Tyan Thunder K7 S2462UNG (the
one with onboard SCSI) to reboot successfully using Linux.  This board
functions perfectly under Linux 2.4.19-pre6, Linux 2.5.8-dj1, Windows XP
Professional and will boot up and reboot off of both FreeBSD 4.5 and
5.0-DP1 cds.  Under Linux the board will boot up, never crash, and
shutdown, everything except for rebooting works.  Windows and FreeBSD
both have no problems rebooting.  If I try and reboot using Linux
2.4.19-pre6, 2.5.8-dj1, the RedHat 7.2.93 CD, the RedHat 7.2 CD or the
Gentoo Linux 1.0 CD it always behaves exactly the same:  init runs it's
shutdown sequence and then the words "Please stand by while rebooting
the system..." appear shortly followed by the words "Rebooting system."
at this point the screen does not clear and wait for the BIOS to
reinitialize the video as Linux does with other boards and Windows and
FreeBSD do with this board, instead the text stays there for at least
15-20 seconds (maybe longer) then when it finally blanks the video and
the monitor light begins to flash it goes straight into the Adaptec
SCSISelect scan (I can tell because my HD light comes on and the CDROMs
I have are accessed in order), immediately after the SCSISelect scan the
video stays off and instead of giving a successful BIOS beep (one tone)
and booting GRUB it gives a very weird sequence of tones and then the
box is permanently hung until I power it off and on again or until I hit
the hard reset switch on the front.  Again, this only occurs while
rebooting linux and does not happen while shutting down Linux (which
works perfectly) or while shutting down/rebooting other OSes.  Also, I
have tried the following combinations of Linux command line reboot
variants: reboot=bios, reboot=smp, reboot=hard, reboot=bios,cold,
reboot=hard,cold, reboot=bios,smp.  All of the previous entries behave
exactly the same, and they all behave the same across multiple BIOS
versions (though maybe a different BIOS would work).  I also used the
reboot=bios patch posted earlier today in my testing of rebooting
2.5.8-dj1.  Does anyone have any ideas about what might be happening to
the reboot sequence Linux tries to use or how to fix it for this board?
It uses 512 MB of Kingston Registered ECC PC2100 DDR SDRAM, a 450 Watt
Enhance Power Supply, and dual AMD Athlon MP 1900+ chips.  Thanks for
any help.

Jordan Breeding

