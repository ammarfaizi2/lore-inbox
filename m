Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272330AbRIKJJP>; Tue, 11 Sep 2001 05:09:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272334AbRIKJJF>; Tue, 11 Sep 2001 05:09:05 -0400
Received: from [195.66.192.167] ([195.66.192.167]:38412 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S272330AbRIKJIr>; Tue, 11 Sep 2001 05:08:47 -0400
Date: Tue, 11 Sep 2001 12:08:12 +0300
From: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
X-Mailer: The Bat! (v1.44)
Reply-To: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
Organization: IMTP
X-Priority: 3 (Normal)
Message-ID: <1325451578.20010911120812@port.imtp.ilyichevsk.odessa.ua>
To: linux-kernel@vger.kernel.org
Subject: Killing NFS daemons
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After being distracted by other toys I am trying again to
make my system shutdown cleanly. I have NFS running.
I discovered that I can "killall -9 nfsd" and nfsd,lockd and rpciod
are all terminating ok, but when I attempt to "killall5 -9",
it does not work as expected.

My NFS is not loaded at all. No NFS clients on the net yet.
kernel: 2.4.5

pegasus:/root# killall5 -9
pegasus:/root# ps -AH e
  PID TTY      STAT   TIME COMMAND
    1 ?        S      0:03 init HOME=/ TERM=linux BOOT_IMAGE=bzimage
    2 ?        SW     0:00   [keventd]
    3 ?        SW     0:01   [kswapd]
    4 ?        SW     0:00   [kreclaimd]
    5 ?        SW     0:00   [bdflush]
    6 ?        SW     0:00   [kupdated]
    7 ?        SW     0:00   [scsi_eh_0]
  165 ?        DW     0:00   [nfsd]            <-- ?
  167 ?        DW     0:00     [lockd]         <-- ?
  168 ?        SW     0:00       [rpciod]
  187 vc/2     S      0:00   -bash TERM=linux HZ=100 HOME=/root ...
  229 vc/2     R      0:00     ps -AH e PWD=/root HZ=100 HOSTNAME=....
  219 vc/9     S      0:00   /sbin/agetty 38400 tty9 linux HOME=/ ...
  220 vc/8     S      0:00   /sbin/agetty 38400 tty8 linux HOME=/ ...
  ...
pegasus:/root#    <-- here I wait ~ 2 mins
rpciod: active tasks at shutdown?!  <-- rpciod talks to me
ps -AH e
  PID TTY      STAT   TIME COMMAND
    1 ?        S      0:03 init HOME=/ TERM=linux BOOT_IMAGE=bzimage
    2 ?        SW     0:00   [keventd]
    3 ?        SW     0:01   [kswapd]
    4 ?        SW     0:00   [kreclaimd]
    5 ?        SW     0:00   [bdflush]
    6 ?        SW     0:00   [kupdated]
    7 ?        SW     0:00   [scsi_eh_0]
  187 vc/2     S      0:00   -bash TERM=linux HZ=100 HOME=/root ...
  230 vc/2     R      0:00     ps -AH e PWD=/root HZ=100 HOSTNAME=....
  223 vc/9     S      0:00   /sbin/agetty 38400 tty9 linux HOME=/ ...
  224 vc/8     S      0:00   /sbin/agetty 38400 tty8 linux HOME=/ ...
  
-- 
Best regards,
VDA
mailto:VDA@port.imtp.ilyichevsk.odessa.ua
http://port.imtp.ilyichevsk.odessa.ua/vda/


