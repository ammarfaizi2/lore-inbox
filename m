Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263117AbUDYO3m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263117AbUDYO3m (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Apr 2004 10:29:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263124AbUDYO3m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Apr 2004 10:29:42 -0400
Received: from benzin.geggus.net ([82.139.198.100]:62735 "EHLO
	benzin.geggus.net") by vger.kernel.org with ESMTP id S263117AbUDYO3h
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Apr 2004 10:29:37 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Sven Geggus <sven-im-usenet@gegg.us>
Subject: 2.6.6-rc2-mm1 pdflush eats my CPU
Date: Sun, 25 Apr 2004 14:29:35 +0000 (UTC)
Organization: Geggus clan, virtual section
Message-ID: <c6gi0f$g6i$1@benzin.geggus.net>
NNTP-Posting-Host: diesel.geggus.net
X-Trace: benzin.geggus.net 1082903375 16594 2001:8d8:81:672:220:edff:fe19:8d4b (25 Apr 2004 14:29:35 GMT)
X-Complaints-To: usenet@geggus.net
NNTP-Posting-Date: Sun, 25 Apr 2004 14:29:35 +0000 (UTC)
Cancel-Lock: sha1:azc+mwMAUBRwSJ1uI2UWIBJiPHE=
X-TERMINAL: rxvt
X-OS: Debian GNU/Linux (Kernel 2.6.6-rc2-mm1)
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.6.6-rc2-mm1 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

my Desktop machine 2.6.6-rc2-mm1 got almost unusable starting with Kernel
2.6.6-rc2-mm1. The machine starts up with pdflush eating up all CPU.
2.6.6-rc2 without mm1 has teh same behavour.

--top output--
top - 16:27:07 up 21 min,  6 users,  load average: 1.07, 1.14, 0.87
Tasks:  94 total,   2 running,  91 sleeping,   0 stopped,   1 zombie
Cpu(s):   6.7% user,  90.4% system,   0.0% nice,   1.8% idle,   1.1% IO-wait
Mem:    510596k total,   281644k used,   228952k free,        0k buffers
Swap:        0k total,        0k used,        0k free,   114684k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
    8 root      25   0     0    0    0 R 93.2  0.0  18:15.08 pdflush          
--cut--
   
Its not happening when I use something like init=/bin/bash, but it does
happen on Normal startup (KDM login).
   
The only thing which is somewhat exotic with this machine, is the fact, that
there are no filesystems mounted besides NFS (root-NFS).

It did not happen with 2.6.5-rc3 which I have been using before.

I will be able to provide further debugging Information, when somebody tells
me what will be of interest (output of readprofile etc.)

Regards

Sven

-- 
"The term "any key" does not refer to a particular key on the keyboard. It
simply means to strike any one of the keys on your keyboard or handheld
screen." (Compaq FAQ Entry 2859)
/me is giggls@ircnet, http://sven.gegg.us/ on the Web
