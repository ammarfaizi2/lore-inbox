Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129747AbQLBTnw>; Sat, 2 Dec 2000 14:43:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130085AbQLBTnm>; Sat, 2 Dec 2000 14:43:42 -0500
Received: from colorfullife.com ([216.156.138.34]:14858 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S129747AbQLBTna>;
	Sat, 2 Dec 2000 14:43:30 -0500
To: linux-kernel@vger.kernel.org
Subject: 2.4.0-test11: arch/i386/boot/bootsect.S incompatible with Vaio C1VE (Crusoe) floppy
Message-ID: <975784573.3a294a7dcabfd@ssl.local>
Date: Sat, 02 Dec 2000 20:16:13 +0100 (CET)
From: Wolfgang Spraul <wspraul@q-ag.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: IMP/PHP IMAP webmail program 2.2.3
X-Originating-IP: 172.26.20.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.4.0-test11, arch/i386/boot/bootsect.S has a probe_loop: to determine the
number of sectors that can be read at once (i.e. in one track).

This routine does not work with the Sony UDF5 USB floppy disk, mapped as an
Int13 device by the Vaio C1VE (Crusoe) BIOS.
Therefore, a bzdisk floppy will not be bootable.

I solved the problem for me by changing "disksizes: .byte 36, 18, 15, 9" to
"disksizes: .byte 18, 18, 18, 18", but I think someone should do it right.
I will assist debugging if needed.

Regards,
Wolfgang
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
