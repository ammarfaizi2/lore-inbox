Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130417AbQLIKMV>; Sat, 9 Dec 2000 05:12:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130481AbQLIKML>; Sat, 9 Dec 2000 05:12:11 -0500
Received: from c334580-a.snvl1.sfba.home.com ([65.5.27.33]:43271 "HELO
	mail.hislinuxbox.com") by vger.kernel.org with SMTP
	id <S130417AbQLIKMB>; Sat, 9 Dec 2000 05:12:01 -0500
Message-ID: <011001c061c4$53ee8a00$0400a8c0@playtoy>
From: "David D.W. Downey" <pgpkeys@hislinuxbox.com>
To: <linux-kernel@vger.kernel.org>
Subject: Network delays with NE2K-PCI
Date: Sat, 9 Dec 2000 01:41:35 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

KERNEL VER: 2.4.0-test11
ADD. PATCHES: reiserfs patch
NETWORK CARD: NE2K-PCI Kingston KNE-111TX (P/N: 4460170-001.A00)
10/100BASE-TX
MOBO: MSI BX-Master with 20001013 BIOS update

PROBLEM:  Network hangs on all initial outbound traffic.

I need to do a ping in order to get any type of connection. Network response
starts out in the high thousand ms then "connects" and drops to a normal 23
ms average. If I do NOT do this initial ping or several nslookups or some
sort of outbound traffic I can not connect to the net nor does the box
respond to inbound packets. But once I do that first set of pings everything
works fine.. until the next reboot and I end up having to do that first set
of pings again.

This problem does not happen under any of the 2.2.x series of kernels with
reiserfs patch and same NIC module and network config. All versions of
network daemons like named, postfix, sendmail sshd ect ect are the same. (I
purposely built the setups under 2.2 and 2.4 the same just to make sure it
wasn't a daemon issue.)

I've searched through the list archvies under SUBJECT and found nothing
related to this.

POSSIBILITY: Driver issue with the 2.4.0-test11 and the ne2k-pci module when
used with this particular network card? It acts almost like the card is
"sleeping". I thought it might possibly be the WAKE ON LAN option in the
BIOS but I turned off all APM options in BIOS, disabled the apmd daemon and
compiled the kernel without APM support.

I thought it might be the fact that it's a 32 bit bus mastering PCI adapter
but I've tried enabling and disabling bus mastering in the BIOS to what
extent it allows.

At this point I'm totally clueless where to look.

All my other machines running various versions of 2.4.0 (test6 through
test11) all use the NetGear FA-310TX and i don't get this problem. Only with
this brand of card. (Tried 3 different physical cards of the same model.)


Any ideas?

David D.W. Downey


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
