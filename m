Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293289AbSCFHjW>; Wed, 6 Mar 2002 02:39:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293302AbSCFHjM>; Wed, 6 Mar 2002 02:39:12 -0500
Received: from ssemail007.crayfish.net ([202.83.148.3]:54213 "EHLO
	ssemail007.crayfish.net") by vger.kernel.org with ESMTP
	id <S293289AbSCFHjC>; Wed, 6 Mar 2002 02:39:02 -0500
Date: Wed, 06 Mar 2002 16:40:10 +0900
From: Michael Cheung <vividy@justware.co.jp>
To: linux-kernel@vger.kernel.org
Subject: mount -o remount,ro cause error "device is busy"
Message-Id: <20020306161900.C897.VIVIDY@justware.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.00.08
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi, all;
	I have upgraded my kernel to version 2.4.
And i have tested 2.4.16 and 2.4.18. Both of these
two version have the same problem when system reboot.
"/: device is busy";
in shutdown script:
umount -a
mount -n -o ro,remount /
these two line result error: device is busy.

I switch to init 1, and all user process go away.
except the following:
root         1  0.1  0.7  1056  484 ?        S    15:46   0:04 init [S] 
root         2  0.0  0.0     0    0 ?        SW   15:46   0:00 [keventd]
root         3  0.0  0.0     0    0 ?        SWN  15:46   0:00 [ksoftirqd_CPU0]
root         4  0.0  0.0     0    0 ?        SW   15:46   0:00 [kswapd]
root         5  0.0  0.0     0    0 ?        SW   15:46   0:00 [bdflush]
root         6  0.0  0.0     0    0 ?        SW   15:46   0:00 [kupdated]
root      1042  0.0  0.7  1056  484 tty1     S    16:33   0:00 init [S] 
root      1043  0.6  1.5  1840 1004 tty1     S    16:33   0:00 /bin/sh
root      1045  0.0  1.0  2260  680 tty1     R    16:33   0:00 ps aux

then i try 
mount -o ro,remount /
error occurs: device is busy.

and i try
mount -o ro,remount /usr
(another partition)
also error occurs: device is busy.

but when i try umount /usr,
it works.

certainly, there is error
device is busy for command umount /.

How can i resolve this problem?

Regards;
Michael

