Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132142AbRDJUWe>; Tue, 10 Apr 2001 16:22:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132140AbRDJUWY>; Tue, 10 Apr 2001 16:22:24 -0400
Received: from goliath.siemens.de ([194.138.37.131]:60879 "EHLO
	goliath.siemens.de") by vger.kernel.org with ESMTP
	id <S132137AbRDJUWP>; Tue, 10 Apr 2001 16:22:15 -0400
X-Envelope-Sender-Is: ulrich.lauther@mchp.siemens.de (at relayer goliath.siemens.de)
From: Ulrich Lauther <ulrich.lauther@mchp.siemens.de>
Message-Id: <200104102022.f3AKM8Q03806@emma.mchp.siemens.de>
Subject: 2.4.2 bug in handling vfat?
To: linux-kernel@vger.kernel.org
Date: Tue, 10 Apr 2001 22:22:08 +0200 (MET DST)
Reply-To: Ulrich.Lauther@mchp.siemens.de
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

when I unmount and remount a vfat file system, the time stamp of a recently
created file changes by one hour.
This does not happen on the same system when running 2.2.17.

Script started on Mon Apr  9 13:59:26 2001
sh-2.03# uname -a
Linux tahiti 2.4.2 #7 Mon Mar 26 23:50:57 CEST 2001 i686 unknown
sh-2.03# touch /dos/fudge
sh-2.03# ls -l /dos/fudge
-rwxrwxrwx   1 root     root            0 Apr  9 13:59 /dos/fudge
sh-2.03# umount /dos
sh-2.03# mount /dos
sh-2.03# ls -l /dos/fudge
-rwxrwxrwx   1 root     root            0 Apr  9 14:59 /dos/fudge
                                                 ^^^^^^
The relevant fstab entry is:
/dev/hda1      /dos        vfat     noauto,umask=0,defaults  1    0

the clock was set after booting using clock -s -u

Is the descibed behaviour a known problem?
-- 
	-lauther

----------------------------------------------------------------------------
Ulrich Lauther          ph: +49 89 636 48834 fx: ... 636 42284
Siemens CT SE 6         Internet: Ulrich.Lauther@mchp.siemens.de
