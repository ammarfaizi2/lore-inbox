Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130940AbRCFFXM>; Tue, 6 Mar 2001 00:23:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130941AbRCFFXD>; Tue, 6 Mar 2001 00:23:03 -0500
Received: from [200.222.192.170] ([200.222.192.170]:40064 "EHLO
	pervalidus.dyndns.org") by vger.kernel.org with ESMTP
	id <S130940AbRCFFW4>; Tue, 6 Mar 2001 00:22:56 -0500
Date: Mon, 5 Mar 2001 02:21:17 -0300
From: Frédéric L. W. Meunier <0@pervalidus.net>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: 2.4.2 ext2 filesystem corruption ? (was 2.4.2: What happened ? (No such file or directory))
Message-ID: <20010305022117.C103@pervalidus>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.16i
X-Mailer: Mutt/1.3.16i - Linux 2.4.2
X-URL: http://www.pervalidus.net/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi. After a reboot I had to manually run fsck (sulogin from
sysinit script) since there were failures.

In my second (and problematic) boot with 2.4.2 I used the
option mount --bind in my sysinit script to mount the old /dev
in /dev-old before devfs was mounted, so I could get rid of all
entries that were still there (I removed most before building a
Kernel with devfs support).

For some reason I couldn't remove /dev-old/hdd2. It reported
can't state file. Note that I never used /dev/hdd*, since I
only use hda and hdc, but am sure it was OK with 2.4.0 (mc
reported an error when I accessed /dev-old, what never happened
before), the last time I used a Kernel without devfs support.

If you read my old thread, you should notice various
applications couldn't access (or rename ?) files. It happened
after ~8h of idle time. It was OK at 5:58, when I last ran cvs
and killed pppd, but failed at ~14:30, when multilog (from
daemontools) had to do something to a full dnscache log file (I
was online).

I'm not sure 2.4.2 is the culprit. I just hope it's the last
time. There were no errors when I first booted with this Kernel
(I was using 2.4.1), and my first uptime was ~6 days (~23 with
2.4.1). Also there were no errors when I booted 2.4.2 for the
second time.

BTW, /lost+found contains hdd2:

brw-r-----    1 root     disk      22,  66 May  8  1995 #518878

The other partitions (/home/ftp/pub and /usr/local/src) have no
problems.

-- 
0@pervalidus.{net, {dyndns.}org} Tel: 55-21-717-2399 (Niterói-RJ BR)
