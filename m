Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312919AbSDBUig>; Tue, 2 Apr 2002 15:38:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312892AbSDBUi0>; Tue, 2 Apr 2002 15:38:26 -0500
Received: from cs666839-153.austin.rr.com ([66.68.39.153]:43145 "EHLO
	kinison.puremagic.com") by vger.kernel.org with ESMTP
	id <S312919AbSDBUiO>; Tue, 2 Apr 2002 15:38:14 -0500
Date: Tue, 2 Apr 2002 14:38:13 -0600 (CST)
From: Evan Harris <eharris@puremagic.com>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Problem with scsi tape drives (2.4.18) and soft error count (BusLogic,
 AIC7xxx)
Message-ID: <Pine.LNX.4.33.0204021416450.1454-100000@kinison.puremagic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've had a long time problem with trying to get the total soft error count
from tape devices when using the kernel provided tape interface.
Hopefully, someone here can shed some light on the problem.  Using several
different DAT and DLT tape drives, the behavior seems the same.

I'm trying to figure out how to retrieve the soft error count from a tape
drive after having performed a backup.  It helps me to gauge when a tape
needs to be retired, and I'm used to being able to get the total soft error
count from other backup software packages for dos/windows.

mt apparently queries the soft error count, but it always seems to be zero.
I've dug into the problem a bit, and it seems that mt reports zero because
the tape drive has had it checked and cleared by the kernel at every drive
operation.  Is there any place in the kernel that this information is stored
so that it may be retrieved?

I've also tried with different scsi adapters, and it may rollover to an
adapter/driver issue.  For instance, the BusLogic driver keeps alot more
statistics information in /proc/scsi/BusLogic/1 than the Adaptec driver, but
doesn't happen to have the soft error count in there.

Any help or pointers would be appreciated.  Web search hasn't turned up much
useful information.

Evan

-- 
| Evan Harris - Consultant, Harris Enterprises - eharris@puremagic.com
|
| Custom Solutions for your Software, Networking, and Telephony Needs

