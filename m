Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130078AbRAKRij>; Thu, 11 Jan 2001 12:38:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130382AbRAKRiX>; Thu, 11 Jan 2001 12:38:23 -0500
Received: from hose.mail.pipex.net ([158.43.128.58]:53141 "HELO hose.pipex.net")
	by vger.kernel.org with SMTP id <S130078AbRAKRiG>;
	Thu, 11 Jan 2001 12:38:06 -0500
From: Chris Rankin <rankinc@zip.com.au>
Message-Id: <200101111733.f0BHXkW00891@wittsend.ukgateway.net>
Subject: 2.4.0-ac6 : Processes missing from "ps -ef" output
To: linux-kernel@vger.kernel.org
Date: Thu, 11 Jan 2001 17:33:46 +0000 (GMT)
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have been trying out 2.4.0-ac6, and the RedHat 6.1 init scripts really don't like it. (They liked 2.4.0-ac3 OK.) The visible symptom is that rc.sysinit now hangs, waiting for me to press 'i'. Once I do, it successfully hands over to the correct runlevel script, and I can go back to non-interactive boot-up by pressing 'C'.

Once I've finally booted, "ps -ef" looks suspiciously empty:

UID        PID  PPID  C STIME TTY          TIME CMD
root         1     0  3 17:12 ?        00:00:04 init
root         2     1  0 17:12 ?        00:00:00 [keventd]
root         3     1  0 17:12 ?        00:00:00 [kswapd]
root         4     1  0 17:12 ?        00:00:00 [kreclaimd]
root         5     1  0 17:12 ?        00:00:00 [bdflush]
root         6     1  0 17:12 ?        00:00:00 [kupdate]
root        68     1  0 17:12 ?        00:00:00 [khubd]
root       102     1  0 17:12 ?        00:00:00 [usb-storage-0]
root       521     1  0 17:13 tty2     00:00:00 /sbin/mingetty tty2
root       522     1  0 17:13 tty3     00:00:00 /sbin/mingetty tty3
root       523     1  0 17:13 tty4     00:00:00 /sbin/mingetty tty4
root       524     1  0 17:13 tty5     00:00:00 /sbin/mingetty tty5
root       525     1  0 17:13 tty6     00:00:00 /sbin/mingetty tty6
root       528   520  0 17:13 tty1     00:00:00 -bash
root       544   528  0 17:14 tty1     00:00:00 ps -ef

These are the processes running on my system, according to the /proc
filesystem:

344
355
371
387
403
419
459
477
520
521
522
523
524
525
528
545

It looks as if all userspace processes unser 500 are missing, for some reason. Does -ac6 need an update for ps, or is this a kernel bug?

I am using a UP i586 (P90), no devfs.

Cheers,
Chris
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
