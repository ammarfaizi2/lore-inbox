Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264010AbTBAAgj>; Fri, 31 Jan 2003 19:36:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264614AbTBAAgj>; Fri, 31 Jan 2003 19:36:39 -0500
Received: from smtp06.iddeo.es ([62.81.186.16]:59331 "EHLO smtp06.retemail.es")
	by vger.kernel.org with ESMTP id <S264010AbTBAAgh>;
	Fri, 31 Jan 2003 19:36:37 -0500
Date: Sat, 1 Feb 2003 01:46:00 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: nfsd and exporting /lib
Message-ID: <20030201004600.GC4200@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 2.0.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi...

I have a cluster mounting /lib exported from master node, and if
I try to run, for example, a ping to master:

annwn:/etc# bpsh 0 ping master.net0.cluster
ping: error while loading shared libraries: /lib/libresolv.so.2: cannot read file data: Error 116

/var/log/messages:

Feb  1 01:43:12 annwn kernel: nfsd Security: lib/libresolv-2.3.1.so bad export.

???

annwn:/etc# bpsh 0 ls -l /lib/libresolv*
ls: /lib/libresolv-2.3.1.so: Stale NFS file handle
lrwxrwxrwx    1 0        0              18 Jan 22 16:28 /lib/libresolv.so.2 -> libresolv-2.3.1.so

Libraries can not be exported ??? Libs in other places look good:

annwn:/etc# bpsh 0 ls -l /usr/lib/libz.*
-rwxr-xr-x    1 0        0           72302 Jun  7  2002 /usr/lib/libz.a
lrwxr-xr-x    1 0        0              13 Nov 13 12:10 /usr/lib/libz.so -> libz.so.1.1.4
lrwxr-xr-x    1 0        0              23 Nov 13 12:01 /usr/lib/libz.so.1.1.4 -> ../../lib/libz.so.1.1.4

Any ideas ?

TIA

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.1 (Cooker) for i586
Linux 2.4.21-pre4-jam1 (gcc 3.2.1 (Mandrake Linux 9.1 3.2.1-5mdk))
