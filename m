Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265473AbUAPNtD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 08:49:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265477AbUAPNtD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 08:49:03 -0500
Received: from lindsey.linux-systeme.com ([62.241.33.80]:40452 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S265473AbUAPNsZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 08:48:25 -0500
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
Subject: [2.6.1 vanilla] Accessing CD-ROM drive causes 94% "hi" load
Date: Fri, 16 Jan 2004 14:48:16 +0100
User-Agent: KMail/1.5.4
To: lkml <linux-kernel@vger.kernel.org>
X-Operating-System: Linux 2.4.20-wolk4.10s i686 GNU/Linux
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200401161443.55918@WOLK>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello there,

accessing my CD-ROM drive causes my system to generate 94% "hi" in
top. I reproduced it using the following steps:

1. mount /dev/hda /cdrom
2. cat /cdrom/* > /dev/null

During this timeperiod, the system does almost stop to do any other
I/O, i.e. accessing my SATA drives on an LVM2 stripeset and doing "cat
largefile > /dev/null" does not read the usual 60 MB/s but only like 2
or 3. I am using the anticipatory scheduler, but tried out the
deadline elevator which doesn't change anything.

System configuration:
=====================
/proc/interrupts is at http://home.in.tum.de/foerstes/lkml/interrupts
/proc/slabinfo is at http://home.in.tum.de/foerstes/lkml/slabinfo
/proc/cpuinfo is at http://home.in.tum.de/foerstes/lkml/cpuinfo
lspci -vvv is at http://home.in.tum.de/foerstes/lkml/lspci
dmesg is at http://home.in.tum.de/foerstes/lkml/dmesg
.config is at http://home.in.tum.de/foerstes/lkml/config

I am using a patch for LIRC from:
http://flameeyes.web.ctonet.it/lirc/patch-lirc-2.6.1-rc1-20040106.diff.bz2
Nothing else is patched in.

Is this the expected behaviour of the 2.6 series kernel?

If you need any more informations, let me know.

ciao, Marc

