Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315214AbSHMMNi>; Tue, 13 Aug 2002 08:13:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315257AbSHMMNi>; Tue, 13 Aug 2002 08:13:38 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:48132 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S315214AbSHMMNi>; Tue, 13 Aug 2002 08:13:38 -0400
Message-ID: <3D58F932.4D87A904@aitel.hist.no>
Date: Tue, 13 Aug 2002 14:18:58 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.30 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: neilb@cse.unsw.edu.au, trond.myklebust@fys.uio.no, vojtech@suse.cz
CC: linux-kernel@vger.kernel.org
Subject: Various trouble in 2.5.31
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some problems and oddities I have seen:

UP, no preempt
* nfs gets stuck sometimes.  klogd and rpciod shares the cpu,
  umounting is impossible.  cat'ing a nfs file shows the
  contents but the cat process won't die.  Stuck on close?
  This also happens with 2.5.30

* ide-cd is broken as module

SMP, with and without preempt.
* During boot I get atkbd not present(ed), and the keyboard 
  is disabled.  It wakes up later in the boot process, so
  no big trouble here.

* raid has trouble, even with 4k maximum bio's.
  The bootup e2fsck complains that it can't find a valid
  superblock on my raid-1 and raid-0 devices, although
  mount has no trouble.  I get logged complaints about
  e2fsck using outdated ioctl's for md.  Strange that
  fsck should needs to know about raid devices.
  Possibly a problem with e2fsck 1.27?

Helge Hafting
