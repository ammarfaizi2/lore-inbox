Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129501AbQKJAS0>; Thu, 9 Nov 2000 19:18:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130209AbQKJASQ>; Thu, 9 Nov 2000 19:18:16 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:24678 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129501AbQKJASC>; Thu, 9 Nov 2000 19:18:02 -0500
Subject: Re: NFS, Can't get request slot
To: jordg@cpgen.cpg.com.au (Grahame Jordan)
Date: Fri, 10 Nov 2000 00:18:29 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org (Kernel Mailing List)
In-Reply-To: <3A0B3E17.9D7E3FFA@cpgen.cpg.com.au> from "Grahame Jordan" at Nov 10, 2000 11:15:19 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13u1tn-0001iI-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Nov 10 04:33:17 spc81 kernel: nfs: server student not responding, still trying
> Nov 10 04:33:17 spc81 kernel: nfs: server student OK

These are all one second or subsecond timeouts

> Nov 10 04:45:56 spc81 kernel: nfs: server student not responding, still trying
> Nov 10 04:46:00 spc81 kernel: nfs: task 20457 can't get a request slot
> Nov 10 04:46:00 spc81 kernel: nfs: server student OK

One four second one here

> We have changed the NIC on this server to 3Com 3c90x for no change in status.
> Clients are using  CNETPro120 200 and Intel eepro100

If samba is ok its not the NIC, it could be congestion on routers or hubs
but you have tried rsize 1024 (and wsize ??)

> Any more help is much appreciated.

You might want to just bump up the NFS timeouts for those warning messages
a couple of seconds. I dont think you have an actual problem. Timeouts are
configurable in mount


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
