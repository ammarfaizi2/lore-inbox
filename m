Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131608AbRBJS7X>; Sat, 10 Feb 2001 13:59:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131614AbRBJS7O>; Sat, 10 Feb 2001 13:59:14 -0500
Received: from [213.204.128.156] ([213.204.128.156]:60632 "HELO
	mail.worldonline.se") by vger.kernel.org with SMTP
	id <S131608AbRBJS7D>; Sat, 10 Feb 2001 13:59:03 -0500
From: "Fredrik Falk" <freddy@kurd.nu>
To: <linux-kernel@vger.kernel.org>
Subject: Problems with irda (irlap, ircomm)
Date: Sat, 10 Feb 2001 19:58:57 +0100
Message-ID: <AOELJLLKKFKGHCDLJFOAAEHPCAAA.freddy@kurd.nu>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
I got a problem with my irda stuff.
Version: "Linux version 2.4.2-pre2 (root@gozfand.ze) (gcc version 2.96
20000731 (Red Hat Linux 7.0)) #1 SMP Sat Feb 10 02:26:51 CET 2001"

I try to dial to the Internet via a cellphone/irda (Nokia 8850) Dongle =
Tekram IrMate 210B dongle

It works fine on the v2.2 kernel, but it dosen't work so nice on v2.4
(2.4.0 -> 2.4.2pre2 and all ac's)

I got irda-utils-0.9.13.tar.gz and irda-utils-0.9.13-5.i386.rpm (both works
exactly the same) and pppd version 2.4.0b2-2.
Started the ir with this command: irattach /dev/ttyS0 -d tekram

	Feb 10 17:46:01 gozfand kernel: IrLAP, no activity on link!
	Feb 10 17:46:10 gozfand chat[2608]: warning: read() on stdin returned 0
	Feb 10 17:46:10 gozfand chat[2608]: send (+++)
	Feb 10 17:46:11 gozfand chat[2608]:  -- write failed: Input/output error
	Feb 10 17:46:11 gozfand chat[2608]: Failed
	Feb 10 17:46:11 gozfand chat[2608]: Can't restore terminal parameters:
Input/output error
	Feb 10 17:46:11 gozfand pppd[2606]: Connect script failed

I get that problem. After like 20 tryes, i can get the link up, for a
shortwhile.. then the message "IrLAP, no activity on link!" appears. And
kills the link.

I have this under irda support in the menuconfig:
	<M> IrDA subsystem support
	<M>   IrCOMM protocol
	[*]   Ultra (connectionless) protocol
	[*]   IrDA protocol options
	[*]     Cache last LSAP
	[*]     Fast RRs
	<M> IrTTY (uses Linux serial driver)
	<M> IrPORT (IrDA serial driver)
	[*] Serial dongle support
	<M>   Tekram IrMate 210B dongle
And this is from "lsmod":
	ircomm-tty             32144   0
	ircomm                 13904   0  [ircomm-tty]
	tekram                  2192   1  (autoclean)
	irtty                   7728   2  (autoclean)
	irda                  157904   1  (autoclean) [ircomm-tty ircomm tekram
irtty]

I have tryed it on a other computer, with rh7 2.4, and it was the same
there.

Sorry for the misspelling!

Thanks,
Fredrik Falk
freddy@kurd.nu

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
