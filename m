Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131468AbRCNQ5m>; Wed, 14 Mar 2001 11:57:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131466AbRCNQ5c>; Wed, 14 Mar 2001 11:57:32 -0500
Received: from dns2.s.bonet.se ([212.181.54.3]:4360 "EHLO dns2.s.bonet.se")
	by vger.kernel.org with ESMTP id <S131468AbRCNQ5U>;
	Wed, 14 Mar 2001 11:57:20 -0500
Message-ID: <3AAFA17F.3B3C7D40@2gen.com>
Date: Wed, 14 Mar 2001 17:51:11 +0100
From: David Härdeman <david@2gen.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-pre4 i686)
X-Accept-Language: en,sv
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Problems with SCSI on 2.4.X
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm having some problems using SCSI-generic (sg loaded as module) to
access my scanner on linux 2.4 (using SANE).

I've been using 2.2.0 - 2.2.19pre17 without any problems, but when I
changed to 2.4 the problems started. 2.4.1 gave the following entries in
my kernel log file (id 7 = scsi card, id 6 = scanner, id 0 = hd):

Mar 10 20:06:15 palpatine kernel: scsi : aborting command due to timeout
: pid 0, scsi0, channel 0, id 6, 
lun 0 Read (6) 00 00 5e 8d 00 
Mar 10 20:06:17 palpatine kernel: SCSI host 0 abort (pid 0) timed out -
resetting
Mar 10 20:06:17 palpatine kernel: SCSI bus is being reset for host 0
channel 0.
Mar 10 20:06:28 palpatine kernel: (scsi0:0:0:0) Synchronous at 80.0
Mbyte/sec, offset 15

I saw that the Adaptec driver was changed in the latest prereleases so i
tried 2.4.3pre4 which gave me:

Mar 14 15:48:10 palpatine kernel: scsi0:0:6:0: Attempting to queue an
ABORT message
Mar 14 15:48:10 palpatine kernel: (scsi0:A:6:0): Queuing a recovery SCB
Mar 14 15:48:10 palpatine kernel: scsi0:0:6:0: Device is disconnected,
re-queuing SCB
Mar 14 15:48:10 palpatine kernel: Recovery code sleeping
Mar 14 15:48:10 palpatine kernel: Recovery SCB completes
Mar 14 15:48:10 palpatine kernel: Recovery code awake
Mar 14 15:48:10 palpatine kernel: aic7xxx_abort returns 8194
Mar 14 15:48:11 palpatine kernel: scsi0:0:6:0: Attempting to queue a
TARGET RESET message
Mar 14 15:48:11 palpatine kernel: scsi0:0:6:0: Command not found
Mar 14 15:48:11 palpatine kernel: aic7xxx_dev_reset returns 819

If you need more info just mail me and I'll provide it...

Thanks,
David
david@2gen.com
