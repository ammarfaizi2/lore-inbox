Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288850AbSA0WX5>; Sun, 27 Jan 2002 17:23:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288882AbSA0WXs>; Sun, 27 Jan 2002 17:23:48 -0500
Received: from zarjazz.demon.co.uk ([194.222.135.25]:37760 "EHLO
	zarjazz.demon.co.uk") by vger.kernel.org with ESMTP
	id <S288850AbSA0WXc>; Sun, 27 Jan 2002 17:23:32 -0500
Message-ID: <004701c1a781$387d2570$0201010a@frodo>
From: "Vincent Sweeney" <v.sweeney@barrysworld.com>
To: <linux-kernel@vger.kernel.org>
Subject: PROBLEM: high system usage / poor SMP network performance
Date: Sun, 27 Jan 2002 22:23:17 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am the server admin for several very busy IRC servers with an ever
increasing user load but I've hit a severe bottle neck which after numerous
system tweaks and driver configuration changes I can only assume is related
to a performance problem with the Linux Kernel.

The server configurations are all identical:
    Compaq Proliant 330R's with Dual Pentium III -800 MHz's & 384MB RAM
    Intel NIC's using the Intel e100 driver
    2.4.17 kernel
    2 ircd processes per box

Here is a snapshot from 'top' :
      9:51pm  up 11 days, 10:13,  1 user,  load average: 0.95, 1.24, 1.21
    44 processes: 40 sleeping, 4 running, 0 zombie, 0 stopped
    CPU0 states: 27.2% user, 62.4% system,  0.0% nice,  9.2% idle
    CPU1 states: 28.4% user, 62.3% system,  0.0% nice,  8.1% idle
    Mem:   385096K av,  376896K used,    8200K free,       0K shrd,    3588K
buff
    Swap:  379416K av,   12744K used,  366672K free                   58980K
cached

      PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME COMMAND
     7825 ircd      18   0 84504  82M  5604 R    89.5 21.9  6929m ircd
    31010 ircd      20   0 86352  84M  5676 R    85.0 22.3  7218m ircd

When this snapshot was taken each ircd had 2000 users connect each. As you
can see I am using more than a single cpu's worth of processer power just on
system cpu and the ircd processes are using just over 50% of a single cpu!
Now in comparison, another server admin who runs a ircd on a single P3-500
Linux 2.4.x system with 3000 users reaches about 60% *total* cpu usage.
Likewise admins who run *BSD or Solaris can run with similar user
connections and barely break a sweat. I have tried setting all the network
performance tweaks mentioned on numerous sites and also using the cpu saver
option on the e100 driver but at best I have only seen a 1-2% cpu saving.

Naturally I would really like to know where / what is using up all this
system cpu so I would like to try profiling the kernel as I'm sure this is a
pure kernel network layer performance issue but I have no idea where to
start so does anyone have some advice / tips on where I should start?

Vince.


