Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131348AbRDJSqE>; Tue, 10 Apr 2001 14:46:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131626AbRDJSpz>; Tue, 10 Apr 2001 14:45:55 -0400
Received: from sputnik.senv.net ([213.169.3.101]:4868 "HELO sputnik.senv.net")
	by vger.kernel.org with SMTP id <S131348AbRDJSpq>;
	Tue, 10 Apr 2001 14:45:46 -0400
Date: Tue, 10 Apr 2001 21:45:16 +0300 (EEST)
From: Jussi Hamalainen <count@theblah.org>
To: <linux-kernel@vger.kernel.org>
Subject: lockd trouble
Message-ID: <Pine.LNX.4.30.0104102137470.708-100000@mir.senv.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have two PCs running Slackware 7.1. I can't get lockd to work
properly with NFS:

Apr 10 21:03:59 sputnik kernel: nsm_mon_unmon: rpc failed, status=-93
Apr 10 21:03:59 sputnik kernel: lockd: cannot monitor xxx.xxx.xxx.xxx
Apr 10 21:03:59 sputnik kernel: lockd: failed to monitor xxx.xxx.xxx.xxx

Yet rpcinfo -p gives the following:

magellan:~$ rpcinfo -p mir
   program vers proto   port
    100000    2   tcp    111  portmapper
    100000    2   udp    111  portmapper
    100021    1   udp   1024  nlockmgr
    100021    3   udp   1024  nlockmgr
    100005    1   udp    686  mountd
    100005    2   udp    686  mountd
    100005    1   tcp    689  mountd
    100005    2   tcp    689  mountd
    100003    2   udp   2049  nfs
    100003    2   tcp   2049  nfs
magellan:~$ rpcinfo -p sputnik
   program vers proto   port
    100000    2   tcp    111  portmapper
    100000    2   udp    111  portmapper
    100021    1   udp   1024  nlockmgr
    100021    3   udp   1024  nlockmgr
    100005    1   udp    721  mountd
    100005    2   udp    721  mountd
    100005    1   tcp    724  mountd
    100005    2   tcp    724  mountd
    100003    2   udp   2049  nfs
    100003    2   tcp   2049  nfs

The NFS share in question is mounted as locking. Every time procmail
tries to get a kernel lock for a file in my home directory, I get an
error as described above. Both boxes are running exactly the same
2.2.19 kernel. Am I doing something wrong or is this a bug?

-- 
-=[ Count Zero / TBH - Jussi Hämäläinen - email count@theblah.org ]=-

