Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136009AbREJCg2>; Wed, 9 May 2001 22:36:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136024AbREJCgS>; Wed, 9 May 2001 22:36:18 -0400
Received: from cvsftp.cotw.com ([208.242.241.39]:23312 "EHLO cvsftp.cotw.com")
	by vger.kernel.org with ESMTP id <S136009AbREJCgI>;
	Wed, 9 May 2001 22:36:08 -0400
Message-ID: <3AFA01C1.5BBC8E87@cotw.com>
Date: Wed, 09 May 2001 21:49:37 -0500
From: "Steven J. Hill" <sjhill@cotw.com>
Reply-To: sjhill@cotw.com
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.19pre17-idepci i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: Bad aic7xxx driver or bad harddisk?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings.

I recently bought an IBM Ultrastar 18GB Model DDYS-T18350N
which is an UltraSCSI 10000 RPM drive. Here are the system
specifications:

DELL Precision 420
  - Pentium III at 800MHz
  - 256MB worth of RambusDIMMs
  - (2) on-board Adaptec aic7899 Ultra160 SCSI adapters
  - (1) 9.1GB - Fujitsu Model MAJ3091MP SCSI harddrive

I simply wanted to add the IBM drive for more disk space. I
am using linux-2.4.4-ac6. I made a single partition taking
up the entire disk and issued the following:

   mke2fs -c -m1 /dev/sdb1

It starts out fine but then eventually it gets enough r/w
errors and locks the machine up. Below is the log output.
I can supply a kernel configuration file, but it probably
is not necessary. I have been following some of the threads
on the list concerning the aic7xxx driver, but may have
missed some. I apologize if this is old information. It
looks like a may have gotten a bad drive. Comments? Thanks.

-Steve

****************
   LOG OUTPUT
****************
May  9 21:08:57 ptecdev1 kernel: SCSI disk error : host 0 channel 0 id 6 lun 0 r
eturn code = 8000002 
May  9 21:08:57 ptecdev1 kernel: [valid=0] Info fld=0x0, Current sd08:11: sense 
key None 
May  9 21:08:57 ptecdev1 kernel:  I/O error: dev 08:11, sector 725376 
May  9 21:09:27 ptecdev1 kernel: scsi0:0:6:0: Attempting to queue an ABORT messa
ge 
May  9 21:09:27 ptecdev1 kernel: (scsi0:A:6:0): Queuing a recovery SCB 
May  9 21:09:27 ptecdev1 kernel: scsi0:0:6:0: Device is disconnected, re-queuing
 SCB 
May  9 21:09:27 ptecdev1 kernel: Recovery code sleeping 
May  9 21:09:27 ptecdev1 kernel: (scsi0:A:6:0): Abort Tag Message Sent 
May  9 21:09:27 ptecdev1 kernel: (scsi0:A:6:0): SCB 7 - Abort Tag Completed. 
May  9 21:09:27 ptecdev1 kernel: Recovery SCB completes 
May  9 21:09:27 ptecdev1 kernel: Recovery code awake 
May  9 21:09:27 ptecdev1 kernel: aic7xxx_abort returns 8194 
May  9 21:09:38 ptecdev1 kernel: SCSI disk error : host 0 channel 0 id 6 lun 0 r
eturn code = 8000002 
May  9 21:09:38 ptecdev1 kernel: [valid=0] Info fld=0x0, Current sd08:11: sense 
key None 
May  9 21:09:38 ptecdev1 kernel:  I/O error: dev 08:11, sector 1451920 
May  9 21:10:08 ptecdev1 kernel: scsi0:0:6:0: Attempting to queue an ABORT messa
May  9 21:10:08 ptecdev1 kernel: (scsi0:A:6:0): Queuing a recovery SCB 
May  9 21:10:08 ptecdev1 kernel: scsi0:0:6:0: Device is disconnected, re-queuing
 SCB 
May  9 21:10:08 ptecdev1 kernel: Recovery code sleeping 
May  9 21:10:08 ptecdev1 kernel: (scsi0:A:6:0): Abort Tag Message Sent 
May  9 21:10:08 ptecdev1 kernel: (scsi0:A:6:0): SCB 5 - Abort Tag Completed. 
May  9 21:10:08 ptecdev1 kernel: Recovery SCB completes 
May  9 21:10:08 ptecdev1 kernel: Recovery code awake 
May  9 21:10:08 ptecdev1 kernel: aic7xxx_abort returns 8194 
May  9 21:10:40 ptecdev1 kernel: scsi0:0:6:0: Attempting to queue an ABORT messa
ge 
May  9 21:10:40 ptecdev1 kernel: (scsi0:A:6:0): Queuing a recovery SCB 
May  9 21:10:40 ptecdev1 kernel: scsi0:0:6:0: Device is disconnected, re-queuing
 SCB 
May  9 21:10:40 ptecdev1 kernel: Recovery code sleeping 
May  9 21:10:45 ptecdev1 kernel: Recovery code awake 
May  9 21:10:45 ptecdev1 kernel: Timer Expired 
May  9 21:10:45 ptecdev1 kernel: aic7xxx_abort returns 8195 
May  9 21:10:45 ptecdev1 kernel: scsi0:0:6:0: Attempting to queue a TARGET RESET
 message 
May  9 21:10:45 ptecdev1 kernel: aic7xxx_dev_reset returns 8195 
May  9 21:10:45 ptecdev1 kernel: Recovery SCB completes 
May  9 21:10:52 ptecdev1 kernel: SCSI disk error : host 0 channel 0 id 6 lun 0 r
eturn code = 8000002 
May  9 21:10:52 ptecdev1 kernel: [valid=0] Info fld=0x0, Current sd08:11: sense 
key None 
May  9 21:10:52 ptecdev1 kernel:  I/O error: dev 08:11, sector 1687072 
May  9 21:11:22 ptecdev1 kernel: scsi0:0:6:0: Attempting to queue an ABORT messa
ge 
May  9 21:11:22 ptecdev1 kernel: (scsi0:A:6:0): Queuing a recovery SCB 
May  9 21:11:22 ptecdev1 kernel: scsi0:0:6:0: Device is disconnected, re-queuing
 SCB 
May  9 21:11:22 ptecdev1 kernel: Recovery code sleeping 
May  9 21:11:22 ptecdev1 kernel: (scsi0:A:6:0): Abort Tag Message Sent 
May  9 21:11:22 ptecdev1 kernel: (scsi0:A:6:0): SCB 5 - Abort Tag Completed. 
May  9 21:11:22 ptecdev1 kernel: Recovery SCB completes 
May  9 21:11:22 ptecdev1 kernel: Recovery code awake 
May  9 21:11:22 ptecdev1 kernel: aic7xxx_abort returns 8194 
May  9 21:11:23 ptecdev1 kernel: SCSI disk error : host 0 channel 0 id 6 lun 0 r
eturn code = 8000002 
May  9 21:11:23 ptecdev1 kernel: [valid=0] Info fld=0x0, Current sd08:11: sense 
key None 
May  9 21:11:23 ptecdev1 kernel:  I/O error: dev 08:11, sector 1763376 
May  9 21:11:53 ptecdev1 kernel: scsi0:0:6:0: Attempting to queue an ABORT messa
ge 
May  9 21:11:53 ptecdev1 kernel: (scsi0:A:6:0): Queuing a recovery SCB 
May  9 21:11:53 ptecdev1 kernel: scsi0:0:6:0: Device is disconnected, re-queuing
 SCB 
May  9 21:11:53 ptecdev1 kernel: Recovery code sleeping 
May  9 21:11:53 ptecdev1 kernel: (scsi0:A:6:0): Abort Tag Message Sent 
May  9 21:11:53 ptecdev1 kernel: (scsi0:A:6:0): SCB 19 - Abort Tag Completed. 
May  9 21:11:53 ptecdev1 kernel: Recovery SCB completes 
May  9 21:11:53 ptecdev1 kernel: Recovery code awake 
May  9 21:11:53 ptecdev1 kernel: aic7xxx_abort returns 8194 
May  9 21:12:26 ptecdev1 kernel: scsi0:0:6:0: Attempting to queue an ABORT messa
ge 
May  9 21:12:26 ptecdev1 kernel: (scsi0:A:6:0): Queuing a recovery SCB 
May  9 21:12:26 ptecdev1 kernel: scsi0:0:6:0: Device is disconnected, re-queuing
 SCB 
May  9 21:12:26 ptecdev1 kernel: Recovery code sleeping 
May  9 21:12:26 ptecdev1 kernel: (scsi0:A:6:0): Abort Tag Message Sent 
May  9 21:12:26 ptecdev1 kernel: (scsi0:A:6:0): SCB 5 - Abort Tag Completed. 
May  9 21:12:26 ptecdev1 kernel: Recovery SCB completes 
May  9 21:12:26 ptecdev1 kernel: Recovery code awake 
May  9 21:12:26 ptecdev1 kernel: aic7xxx_abort returns 8194 
May  9 21:12:27 ptecdev1 kernel: SCSI disk error : host 0 channel 0 id 6 lun 0 r
eturn code = 8000002 
May  9 21:12:27 ptecdev1 kernel: [valid=0] Info fld=0x0, Current sd08:11: sense 
key None 
May  9 21:12:27 ptecdev1 kernel:  I/O error: dev 08:11, sector 2034752 
May  9 21:12:57 ptecdev1 kernel: scsi0:0:6:0: Attempting to queue an ABORT messa
ge 
May  9 21:12:57 ptecdev1 kernel: (scsi0:A:6:0): Queuing a recovery SCB 
May  9 21:12:57 ptecdev1 kernel: scsi0:0:6:0: Device is disconnected, re-queuing
 SCB 
May  9 21:12:57 ptecdev1 kernel: Recovery code sleeping 
May  9 21:12:57 ptecdev1 kernel: (scsi0:A:6:0): Abort Tag Message Sent 
May  9 21:12:57 ptecdev1 kernel: (scsi0:A:6:0): SCB 5 - Abort Tag Completed. 
May  9 21:12:57 ptecdev1 kernel: Recovery SCB completes 
May  9 21:12:57 ptecdev1 kernel: Recovery code awake 
May  9 21:12:57 ptecdev1 kernel: aic7xxx_abort returns 8194 

-- 
 Steven J. Hill - Embedded SW Engineer
 Public Key: 'http://www.cotw.com/pubkey.txt'
 FPR1: E124 6E1C AF8E 7802 A815
 FPR2: 7D72 829C 3386 4C4A E17D
