Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316838AbSHTKrV>; Tue, 20 Aug 2002 06:47:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316842AbSHTKrV>; Tue, 20 Aug 2002 06:47:21 -0400
Received: from daimi.au.dk ([130.225.16.1]:5604 "EHLO daimi.au.dk")
	by vger.kernel.org with ESMTP id <S316838AbSHTKrU>;
	Tue, 20 Aug 2002 06:47:20 -0400
Message-ID: <3D621F2B.73B24DE0@daimi.au.dk>
Date: Tue, 20 Aug 2002 12:51:23 +0200
From: Kasper Dupont <kasperd@daimi.au.dk>
Organization: daimi.au.dk
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.9-31smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: 2.5.31 problems
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have some problems with 2.5.31. I boot from an initial
ramdisk and my /sbin/init script is at the end of the mail.
I do get sash on both tty's, but typing any command just
locks up this shell. I tried "cd tmp", "-ls", and a few
others. Even "-cat sbin/init" locks up. Any attempt to
reboot using CTRL+ALT+DEL or ALT+SYSRQ+B results in a
solid lockup, at this point only a hard reset is possible.
Can anybody provide me a hint on where to find the problem?
Or do I have to do binary search through the patch?

#!/bin/sh
mount /proc /proc -t proc
mount /tmp /tmp -t tmpfs
ifconfig lo 127.0.0.1
ifconfig eth0 62.xx.xxx.91
route add default gw 62.xx.xxx.1
while true
do
        open -c 2 -w /bin/sash
done &
while true
do
        open -c 1 -w /bin/sash
done

-- 
Kasper Dupont -- der bruger for meget tid på usenet.
For sending spam use mailto:aaarep@daimi.au.dk
or mailto:mcxumhvenwblvtl@skrammel.yaboo.dk
