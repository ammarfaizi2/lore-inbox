Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130645AbQKRBgV>; Fri, 17 Nov 2000 20:36:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130779AbQKRBgM>; Fri, 17 Nov 2000 20:36:12 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:35599 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S130645AbQKRBgI>; Fri, 17 Nov 2000 20:36:08 -0500
Message-ID: <3A15D50A.6818516A@timpanogas.org>
Date: Fri, 17 Nov 2000 18:02:02 -0700
From: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Organization: TRG, Inc.
X-Mailer: Mozilla 4.7 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: VFS Kernel Panic in 2.4.0-10(11)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	
This is probably a configuration mismatch of some kind, but I just
finished building my 2.4.0 RPM skeletons and am installting them from
our latest CD burn, and I am seeing the following 
problem when I upgrade our 2.2.17 kernel versions with 2.4.0-test10,
then reboot them under 2.4:

request_module[block-major-3]:  Root fs not mounted
VFS cannot open root device "301" or 03:01
Please append a correct "root=" boot option 
Kernel panic: VFS: Unable to mount root fs on 03:01.

The system was running Ute-Linux under 2.2.17 then was upgraded to
2.4.0-10 (with IPVS and pre-11 patches).
The disk is a 20GB device with 

/dev/hda1        Linux     (/,/boot)                               at
3,1
/dev/hda2        Extended  (contains a swap partition /dev/hda5)   at
3,2
/dev/hda3        Linux     (/usr)                                  at
3,3
/dev/hda4        Linux     (/archive)                              at
3,4
/dev/hda5        Swap       Swap                                   at
3,5

Lilo is configured in linear mode.  The device it's complaining about is
present 
(03:01) and lilo does append a root=/dev/hda1 statement.

Any ideas?

Jeff
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
