Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265855AbRF2Kx2>; Fri, 29 Jun 2001 06:53:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265859AbRF2KxS>; Fri, 29 Jun 2001 06:53:18 -0400
Received: from picard.csihq.com ([204.17.222.1]:19344 "EHLO picard.csihq.com")
	by vger.kernel.org with ESMTP id <S265855AbRF2KxE>;
	Fri, 29 Jun 2001 06:53:04 -0400
Message-ID: <061801c10089$a5e89fd0$e1de11cc@csihq.com>
From: "Mike Black" <mblack@csihq.com>
To: "linux-kernel@vger.kernel.or" <linux-kernel@vger.kernel.org>
Subject: Qlogic Fiber Channel
Date: Fri, 29 Jun 2001 06:52:53 -0400
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

I have been running successfully with qla2x00src-4.15Beta.tgz for several
months now over several kernel versions up to 2.4.5.
When I tested 2.4.6-pre6 I decided to use the qlogicfc driver -- BAD
MISTAKE!!!

#1 - My system had crashed (for a different reason) and when the raid5 was
resyncing and e2fsck happening at the same time the kernel locked with
messages from qlogicfc.o:
qlogicfc0: no handle slots, this should not happen.
hostdata->queue  is 2a, inptr: 74
I was able to repeat this several times so it's a consistent error.
Waiting for the raid resync to finish did allow this complete -- but now
when I come in the next morning the console is locked up and no network
access either.  So I reset it.  Checked the logs and here it is again:
Jun 29 03:39:21 yeti kernel: qlogicfc0 : no handle slots, this should not
happen.
Jun 29 03:39:21 yeti kernel: hostdata->queued is 36, in_ptr: 13
This was during a tape backup.

So I'm switching back to qla2x00src-4.15Beta.tgz -- which does the resync
and e2fsck just fine together BTW.
Jun 29 06:22:47 yeti kernel: qla2x00: detect() found an HBA
Jun 29 06:22:47 yeti kernel: qla2x00: VID=1077 DID=2100 SSVID=0 SSDID=0

Only problem is I don't see this package on qlogic's website anymore and
their "beta" directory is empty now.  I'm waiting to see what their tech
support says.

________________________________________
Michael D. Black   Principal Engineer
mblack@csihq.com  321-676-2923,x203
http://www.csihq.com  Computer Science Innovations
http://www.csihq.com/~mike  My home page
FAX 321-676-2355

