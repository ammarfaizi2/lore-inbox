Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S132032AbQKWAKI>; Wed, 22 Nov 2000 19:10:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132095AbQKWAJ5>; Wed, 22 Nov 2000 19:09:57 -0500
Received: from Mail.Mankato.MSUS.EDU ([134.29.1.12]:57867 "EHLO mail.mnsu.edu")
        by vger.kernel.org with ESMTP id <S132032AbQKWAJl>;
        Wed, 22 Nov 2000 19:09:41 -0500
Message-ID: <3A1C593A.253A2707@mnsu.edu>
Date: Wed, 22 Nov 2000 17:39:38 -0600
From: Jeffrey Hundstad <jeffrey.hundstad@mnsu.edu>
Organization: Minnesota State University, Mankato
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        debian-devel@lists.debian.org, submit@bugs.debian.org, dhd@debian.org
Subject: netatalk refuses to start with ethernet aliasing
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm using Debian Potato with linux-2.2.18pre22.  This version of Potato
uses netatalk (1.4b2+asun2.1.3).

Everything works just fine if I have the two interfaces:

lo
eth0

As soon as I alias eth0 and have the interfaces:

lo
eth0
eth0:0
eth0:1
eth0:2

netatalk refuses to start and I receive this in syslog:

Nov 22 17:01:23 files atalkd[177]: restart (1.4b2+asun2.1.3)
Nov 22 17:01:24 files atalkd[177]: zip_getnetinfo for eth0
Nov 22 17:01:25 files atalkd[177]: zip gnireply from 275.241 (eth0 12)
Nov 22 17:01:26 files atalkd[177]: zip_packet configured eth0 from
275.241
Nov 22 17:01:26 files atalkd[177]: setifaddr: eth0:0: No such device
Nov 22 17:01:26 files atalkd[177]: difaddr(65280.0): No such device
Nov 22 17:01:26 files atalkd[177]: difaddr(0.0): No such device
Nov 22 17:01:26 files atalkd[177]: difaddr(0.0): No such device
Nov 22 17:01:26 files atalkd: difaddr(0.0): No such device
Nov 22 17:01:26 files last message repeated 2 times
Nov 22 17:01:27 files afpd[180]: main: atp_open: Cannot assign requested
address


My current work around is:

1. start the interfaces:
lo
eth0

2. start netatalk

3. create my eth0 aliases.

This works fine... but is a little strange.

Thanks for your help,

Jeffrey Hundstad
jeffrey.hundstad@mnsu.edu
Minnesota State University, Mankato
http://www.mnsu.edu/jeffrey/



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
