Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135419AbRDMFlX>; Fri, 13 Apr 2001 01:41:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135421AbRDMFlN>; Fri, 13 Apr 2001 01:41:13 -0400
Received: from [206.46.170.140] ([206.46.170.140]:47853 "EHLO
	smtp8ve.mailsrvcs.net") by vger.kernel.org with ESMTP
	id <S135419AbRDMFlC>; Fri, 13 Apr 2001 01:41:02 -0400
Message-ID: <3AD69167.13CE6E91@neuronet.pitt.edu>
Date: Fri, 13 Apr 2001 01:40:55 -0400
From: "Rafael E. Herrera" <raffo@neuronet.pitt.edu>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: LK <linux-kernel@vger.kernel.org>
Subject: Sudden scsi timeouts on main disk.
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

While playing a dvd I was plugging a headphone and my machine froze and had to reset.
The machine was running 2.4.3 with the new aha7xxx driver.

I booted back into 2.2.18. It took a while to get pass the scsi BIOS. It finally detected
all the drives, but lilo would not find the scsi disk to boot. After several attempts it
finally booted but started to get scsi time outs from my main disk. My scsi adapter
is an adaptec 7895. The logs are:

Apr 13 01:16:17 inca kernel: scsi : aborting command due to timeout : pid 3797, scsi0, channel 0, id 0, lun 0 Read (10) 00 00 88 aa f3 00 00 08 00 
Apr 13 01:16:17 inca kernel: (scsi0:0:0:0) SCSISIGI 0x54, SEQADDR 0x156, SSTAT0 0x7, SSTAT1 0x7
Apr 13 01:16:17 inca kernel: (scsi0:0:0:0) SG_CACHEPTR 0x0, SSTAT2 0x10, STCNT 0x0
Apr 13 01:16:19 inca kernel: SCSI host 0 abort (pid 3797) timed out - resetting
Apr 13 01:16:19 inca kernel: SCSI bus is being reset for host 0 channel 0.
Apr 13 01:16:20 inca kernel: (scsi0:0:0:0) Synchronous at 40.0 Mbyte/sec, offset 8.
Apr 13 01:16:50 inca kernel: scsi : aborting command due to timeout : pid 3801, scsi0, channel 0, id 0, lun 0 Read (10) 00 00 88 ac 8b 00 00 08 00 
Apr 13 01:16:50 inca kernel: (scsi0:0:0:0) SCSISIGI 0x54, SEQADDR 0x156, SSTAT0 0x7, SSTAT1 0x7
Apr 13 01:16:50 inca kernel: (scsi0:0:0:0) SG_CACHEPTR 0x0, SSTAT2 0x10, STCNT 0x0
Apr 13 01:16:52 inca kernel: SCSI host 0 abort (pid 3801) timed out - resetting
Apr 13 01:16:52 inca kernel: SCSI bus is being reset for host 0 channel 0.
Apr 13 01:16:53 inca kernel: (scsi0:0:0:0) Synchronous at 40.0 Mbyte/sec, offset 8.
Apr 13 01:17:23 inca kernel: scsi : aborting command due to timeout : pid 3820, scsi0, channel 0, id 0, lun 0 Request Sense 00 00 00 10 00 
Apr 13 01:17:23 inca kernel: (scsi0:0:0:0) SCSISIGI 0x54, SEQADDR 0x156, SSTAT0 0x7, SSTAT1 0x17
Apr 13 01:17:23 inca kernel: (scsi0:0:0:0) SG_CACHEPTR 0x0, SSTAT2 0x10, STCNT 0x0
Apr 13 01:17:24 inca kernel: SCSI host 0 abort (pid 3820) timed out - resetting
Apr 13 01:17:24 inca kernel: SCSI bus is being reset for host 0 channel 0.
Apr 13 01:17:25 inca kernel: (scsi0:0:0:0) Synchronous at 40.0 Mbyte/sec, offset 8.

This has not happened before and the time outs are occurring intermittently. Are the logs
a signal of hardware error? What would be the steps to check the machine? Any suggestion
would be appreciated.

-- 
     Rafael
