Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136683AbREASRm>; Tue, 1 May 2001 14:17:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136690AbREASRd>; Tue, 1 May 2001 14:17:33 -0400
Received: from msgbas1x.cos.agilent.com ([192.6.9.33]:38868 "HELO
	msgbas1.cos.agilent.com") by vger.kernel.org with SMTP
	id <S136683AbREASRV>; Tue, 1 May 2001 14:17:21 -0400
Message-ID: <FEEBE78C8360D411ACFD00D0B7477971880A50@xsj02.sjs.agilent.com>
From: hiren_mehta@agilent.com
To: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: killing a process writing to a scsi drive freezes a system
Date: Tue, 1 May 2001 12:17:12 -0600 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi List,

I tried to do dd to a bunch of scsi drives running in background.

e.g. dd if=/dev/zero of=/dev/sdb bs=1024 &
     dd if=/dev/zero of=/dev/sdc bs=1024 &
     dd if=/dev/zero of=/dev/sdd bs=1024 &

Then I tried to kill the first dd process writing to /dev/sdb
and it freezes up the system. When I looked at the drives,
I can see that every 1 second the lights on all the drives (not
just sdb) flashes. This goes on for quite long time. Looks like 
after I issued the kill, the system is trying to flush its buffers. 
I am running this on ia64 system which has 4GB of memory and it 
takes lot of time to flush the buffers, because of delay of 1 second
between bunch of writes.

Can anybody tell what is going on here ? Is this is bug in the block
device driver ? If that the case, is it fixed in the lator versions
of kernel ? I am running 2.4.2 kernel.

I can switch between the vt's. But I cannot login from other vt's
until this flushing is done. Also, the current vt ( where I fired
all dd commands) and other vt's where I have already logged in, 
are completely frozen and I cannot do anything after I issue the 
kill command.

Regards,
-hiren

Regards,
-hiren
(408)970-3062
hiren_mehta@agilent.com
