Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264400AbRFHXXX>; Fri, 8 Jun 2001 19:23:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264402AbRFHXXO>; Fri, 8 Jun 2001 19:23:14 -0400
Received: from msgbas1tx.cos.agilent.com ([192.6.9.34]:46576 "HELO
	msgbas1t.cos.agilent.com") by vger.kernel.org with SMTP
	id <S264401AbRFHXXE>; Fri, 8 Jun 2001 19:23:04 -0400
Message-ID: <FEEBE78C8360D411ACFD00D0B7477971880AA8@xsj02.sjs.agilent.com>
From: hiren_mehta@agilent.com
To: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: question about scsi generic behavior
Date: Fri, 8 Jun 2001 17:22:56 -0600 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi List,

I am trying to use sg_dd which goes through the scsi generic driver.
This is how use it.

sg_dd if=/dev/zero of=/dev/sg5 bs=4096 count=1

And sg5 is actually a disk. 

The question that I have is, does the scsi generic driver have a knowledge
about what kind of device it is dealing with ? As you know, all disk drives
have block size of 512 bytes. So, according to the above command, I am
suppose
write 4096 bytes of data. But when my driver gets the CDB, I see that
the transfer length is set to 1 block instead of 8 blocks. And to transfer
4096 bytes, obviously we need transfer length=8 in CDB. Since, the transfer
length
is set to 1, the drive comes back with 1 512 byte block and then comes back
with 
a good status because of which sg_dd command is not able to transfer all
4096 bytes
of data.

Any input on this ?

Regards,
-hiren
hiren_mehta@agilent.com
