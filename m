Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131519AbRAOVay>; Mon, 15 Jan 2001 16:30:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131535AbRAOVap>; Mon, 15 Jan 2001 16:30:45 -0500
Received: from tools.cfourusa.com ([209.254.33.11]:1540 "EHLO tools.c4usa.com")
	by vger.kernel.org with ESMTP id <S131519AbRAOVad>;
	Mon, 15 Jan 2001 16:30:33 -0500
Message-ID: <00a301c07f3a$6083e060$1a21fed1@chalice>
From: "Dan Egli" <dan@frankenstein-cpu.com>
To: <linux-kernel@vger.kernel.org>
Subject: ide-scsi not working in 2.4.0. Possible scsi  subsystem problems?
Date: Mon, 15 Jan 2001 14:30:26 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok. Here's a question for anyone. I have a computer here that I'm trying to
get IDE-SCSI to work on. It seems to be a complete dud from this point of
view.

System config: Dual P3-550, 256MB Ram
Scsi card: Adaptec 2940U2W.
                                2 Seagate LVD drives connected

Primary IDE slave: IDE CDRW Drive (Matshita)
Secondary IDE Master: IDE CD Drom (CD-540E, Teac)

When the driver for the SCSI Card loads, it goes through it's pases, detects
the drives, and all is happy. I run modprobe (or insmod) ide-scsi, it comes
up with the note in the kernel about the 2nd driver being loaded (dmesg),
but nothing shows on the bus, and anything that tries to access the scsi bus
sees ONLY the adaptec card.

Now boot 2.2.16 (RedHat's 2.2.16-22 from RH 7.0), boot up, First thing I
notice is that the HardDrives are not 'timing out'. If I boot 2.4.0, it sees
the drives, but it has to reset them saying the command had timed out.
Doesn't happen on 2.2.16. Also, when I modprobe the ide-scsi driver, it sees
the bus, and detects 2 devices, namely the 2 cd drives. A bus scan reveals
the 2 scsi busses, and sees all devices attached.

I am running the default Modutils package (2.3.14-3). I will try grabbing
Modutils 2.4.0 and see if that fixes it, if not then does anyone else have
any ideas?

Thanks in advance!


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
