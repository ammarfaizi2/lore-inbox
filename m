Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268665AbUHYUic@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268665AbUHYUic (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 16:38:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268592AbUHYU2a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 16:28:30 -0400
Received: from sasami.anime.net ([207.109.251.120]:50058 "EHLO
	sasami.anime.net") by vger.kernel.org with ESMTP id S268594AbUHYUZN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 16:25:13 -0400
X-Antispam-Origin-Id: c4dc35da7d5d290438c6d6bdb17308d1
Date: Wed, 25 Aug 2004 13:25:12 -0700 (PDT)
From: Dan Hollis <goemon@anime.net>
To: linux-kernel@vger.kernel.org
Subject: bizarre 2.6.8.1 /sys permissions
Message-ID: <Pine.LNX.4.44.0408251319070.4007-100000@sasami.anime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Greylist: Message not sent from an IPv4 address, not delayed by milter-greylist-1.3.8 (sasami.anime.net [0.0.0.0]); Wed, 25 Aug 2004 13:25:12 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

replies cc: in email, i'm not subscribed to the list.

Do these file permissions make sense to anyone?

$ uname -r
2.6.8.1
$ cat /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_cur_freq
cat: /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_cur_freq: Permission denied
$ cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Celeron(R) CPU 2.60GHz
stepping        : 9
cpu MHz         : 324.528
[...]

$ ls -al /proc/cpuinfo 
-r--r--r--  1 root root 0 Aug 25 13:18 /proc/cpuinfo
$ ls -la /sys/devices/system/cpu/cpu0/cpufreq/
total 0
drwxr-xr-x  2 root root    0 Aug 23 13:06 .
drwxr-xr-x  3 root root    0 Aug 23 13:06 ..
-r--------  1 root root 4096 Aug 23 13:06 cpuinfo_cur_freq
-r--r--r--  1 root root 4096 Aug 23 13:06 cpuinfo_max_freq
-r--r--r--  1 root root 4096 Aug 23 13:06 cpuinfo_min_freq
-r--r--r--  1 root root 4096 Aug 23 13:06 scaling_available_frequencies
-r--r--r--  1 root root 4096 Aug 23 13:06 scaling_available_governors
-r--r--r--  1 root root 4096 Aug 23 13:06 scaling_cur_freq
-r--r--r--  1 root root 4096 Aug 23 13:06 scaling_driver
-rw-r--r--  1 root root    0 Aug 25 13:19 scaling_governor
-rw-r--r--  1 root root 4096 Aug 23 13:06 scaling_max_freq
-rw-r--r--  1 root root 4096 Aug 23 13:06 scaling_min_freq
-rw-r--r--  1 root root    0 Aug 25 13:19 scaling_setspeed

