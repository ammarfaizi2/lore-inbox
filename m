Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313569AbSDQLye>; Wed, 17 Apr 2002 07:54:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313571AbSDQLyd>; Wed, 17 Apr 2002 07:54:33 -0400
Received: from mfep2.odn.ne.jp ([143.90.131.180]:13612 "EHLO t-mta2.odn.ne.jp")
	by vger.kernel.org with ESMTP id <S313569AbSDQLyc>;
	Wed, 17 Apr 2002 07:54:32 -0400
Message-ID: <000701c1e604$a1ff3800$370383d3@kanda>
From: "=?iso-2022-jp?B?GyRCP0BFRDRwR24bKEI=?=" <mokanda@ams.odn.ne.jp>
To: <linux-kernel@vger.kernel.org>
Cc: <mokanda@itg.hitachi.co.jp>
Subject: ls SYS1.PARMLIB or Mainframe FS from Hitachi
Date: Wed, 17 Apr 2002 20:40:08 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Hitachi Ltd. Japan has developed a Mainframe OS compatible
file system on Linux, and will make the source code available in GPL.

The file system is named "mainframe file system" or mffs for short
and can access disks formatted by Hitachi's VOS3 operating system
and its compatibles : )

Reading and writing a plain sequential file
(DSORG=PS RECFM=F,FB,V,VB in mainframe jargon) is possible.
Partitioned dataset members
(Do not care if it dose not make sense to you.)
can be read.
Ebcdic to ascii character code translation can be performed.
So, for example, you can cat SYS1.PARMLIB/IAASYS00.
File metadata update is still under development, so you cannot create
nor extend a file.

Mainframe file system is designed in hope to replace lengthy
file transfer batch jobs. Existing mainframe volumes can be
mounted and accessed directly from Linux running on mainframes.

Let me say again. NO FILE TRANSFERS from/to mainframes.

Hitachi has modified the disk driver code under drivers/s390/block
so that mffs can issue arbitrary disk commands such as READ TRACK.

All the source code will be available in GPL in May 2002
under http://www.hitachi.co.jp/Prod/comp/soft1/linux_m/download.html

References
[1] Hitachi's press release in Japanese language
http://www.hitachi.co.jp/New/cnews/2001/1002/index.html
[2] Nikkei Linux article in Japanese, Dec. 2001, Nikkei Business
Publications, Inc.
[3] Mainframe file system on Windows NT and AIX - Towards heterogeneous
cluster file share?, Motohiro Kanda, CMG (Computer Measurement Group) 1999
Annual Conference, in English

Hope you like it.
--
mokanda@itg.hitachi.co.jp
Motohiro Kanda   Hitachi Ltd. Japan


