Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261354AbTAQUmB>; Fri, 17 Jan 2003 15:42:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261529AbTAQUmB>; Fri, 17 Jan 2003 15:42:01 -0500
Received: from [209.184.141.189] ([209.184.141.189]:54065 "HELO ubergeek")
	by vger.kernel.org with SMTP id <S261354AbTAQUmA>;
	Fri, 17 Jan 2003 15:42:00 -0500
Subject: Two on the kernel.
From: GrandMasterLee <masterlee@digitalroadkill.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1042836639.1292.16.camel@UberGeek>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 17 Jan 2003 14:50:39 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey all, 
I've got two issues here. Both issues were seen with 2.4.19aa1. The
second issue was seen with 2.4.20aa1 also.


1. This message between two linux machines during backup (rsync), across
GBE:

"TCP: Treason uncloaked! Peer 10.1.1.40:37859/873 shrinks window
2430745930:2430747378. Repaired."
"TCP: Treason uncloaked! Peer 10.1.1.40:37859/873 shrinks window
2430745930:2430747378. Repaired.
XFS mounting file"

I saw some info on LKML archives about this, but no resolution or
reason. The system reporting the errors has an EEPRO1000 and is
connected via crossover to a system with embedded BCM5700s. MTU is 9000

2. tar xjvf breaks the machine: Usually black-screens.

When untarring say, bzipped kernel source, though other tars have caused
this too, the system will get very slow, the untarring will stop, and
then about 2 - 5 mins later, everything stops. Sometimes this causes a
black screen, other times, it's just frozen with whatever's on the
screen. The system must be hard booted for it to recover, usually
needing to hold the power button down till forced power off too.(5
seconds)

I thought this might be memory related, so I umounted /dev/shm after a
reboot, and tried my untar test again. Usually I could untar 2 times
before the system entered the aforementioned state. I then tried
2.4.20aa1, and got the same result. I then tried just 2.4.20 + XFS
patches, and now my system is actually faster at most things than it was
prior. I'm not sure why.

The system mentioned in #2 is an AMD Athlon-C with 512MB RAM two HDDs a
CDRW and a DVD-ROM drive. It is 100% XFS and LVM is used for 5 volumes,
but not / .

Any help with this would be greatly appreciated.




-- 
GrandMasterLee <masterlee@digitalroadkill.net>
