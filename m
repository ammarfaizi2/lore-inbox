Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316768AbSFVRYO>; Sat, 22 Jun 2002 13:24:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316789AbSFVRYN>; Sat, 22 Jun 2002 13:24:13 -0400
Received: from out010pub.verizon.net ([206.46.170.133]:20940 "EHLO
	out010.verizon.net") by vger.kernel.org with ESMTP
	id <S316768AbSFVRYK>; Sat, 22 Jun 2002 13:24:10 -0400
Message-ID: <3D14B311.80802@verizon.net>
Date: Sat, 22 Jun 2002 13:25:37 -0400
From: Emre Tezel <emre.tezel@verizon.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011126 Netscape6/6.2.1
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: ide-floppy problem - 2.4.19-pre10
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Kernel Hackers,

I am running kernel 2.4.19-pre10. I am experiencing a problem with my 
internal ATAPI Zip 100 Drive. Currently I am using the ide-floppy 
driver. The device is attached to my secondry slave (/dev/hdd). Whenever 
I try to do any I/O, my system eventually comes to a full stop. I 
managed to extract the following kernel log messages.

Jun 21 01:17:09 hori kernel: ide-scsi: CoD != 0 in idescsi_pc_intr
Jun 21 01:17:09 hori kernel: hdd: ATAPI reset complete
Jun 21 01:17:09 hori kernel: hdd: lost interrupt
Jun 21 01:17:09 hori kernel: ide-scsi: CoD != 0 in idescsi_pc_intr
Jun 21 01:17:09 hori kernel: hdd: ATAPI reset complete
Jun 21 01:17:11 hori kernel: hdd: lost interrupt
Jun 21 01:17:11 hori kernel: ide-scsi: CoD != 0 in idescsi_pc_intr
Jun 21 01:17:11 hori kernel: scsi : aborting command due to timeout : 
pid 4498, scsi0, channel 0, id 0, lun 0 Write (10) 00 00 00 00 df 00 00 
07 00
Jun 21 01:17:11 hori kernel: SCSI host 0 abort (pid 4498) timed out - 
resetting
Jun 21 01:17:11 hori kernel: SCSI bus is being reset for host 0 channel 0.
Jun 21 01:17:11 hori kernel: scsi : aborting command due to timeout : 
pid 4499, scsi0, channel 0, id 0, lun 0 Write (10) 00 00 00 01 04 00 00 
03 00
Jun 21 01:17:11 hori kernel: SCSI host 0 abort (pid 4499) timed out - 
resetting
Jun 21 01:17:11 hori kernel: SCSI bus is being reset for host 0 channel 0.
Jun 21 01:17:11 hori kernel: hdd: ATAPI reset complete
Jun 21 01:17:11 hori kernel: hdd: lost interrupt
Jun 21 01:17:11 hori kernel: ide-scsi: CoD != 0 in idescsi_pc_intr
Jun 21 01:17:11 hori kernel: hdd: ATAPI reset complete
Jun 21 01:17:11 hori kernel: hdd: lost interrupt
Jun 22 02:18:04 hori syslogd 1.4.1: restart.

These messages keep repeating itself until forever.

I also tried to use the ide-scsi driver instead, but I am running into 
the same problem. Is this a known bug in the latest stable kernel or am 
I having a bad hardware ?

Thank You,
Emre

