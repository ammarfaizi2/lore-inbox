Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264543AbUDUMJI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264543AbUDUMJI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 08:09:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264552AbUDUMJI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 08:09:08 -0400
Received: from ss12.shared.server-system.net ([64.207.150.2]:35476 "EHLO
	ss12.shared.server-system.net") by vger.kernel.org with ESMTP
	id S264543AbUDUMJD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 08:09:03 -0400
Message-Id: <5.1.0.14.2.20040421141000.02798b80@mail.fluxtopia.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 21 Apr 2004 14:11:19 +0200
To: linux-kernel@vger.kernel.org
From: Xavier Wielemans <willy@alterface.com>
Subject: abort() and exit(1) make RHEL freeze when core size limit is
  higher than 2 MB
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ I hope this is a relevant linux-kernel bug - I think so, all apologies if 
not... ]
[ Please CC me personally if replying, I'm not subscribed to the list - 
thank you ! ]

Hi all,

I encountered the following problem - when my C++ application executes the 
abort() or exit(1) system instructions, if the core size limit was 
previously set to more than ~2MB (ulimit -c 2000), my PC freezes totally 
and must be power-cycled...

If the core limit is left untouched to 0 (default), the abort or exit 
instructions are executed without problems, but of course no core file is 
dumped !

If core limit is set to 2000 or less, a core file is dumped but it is 
unreadable (certainly because it is trimmed to less than its actual size).

If core limit is set to 4000 or higher (including 'ulimit -c unlimited') 
the machine freezes as soon as abort() or exit() are executed.

Here are my configuration details :

[wielemans@electro:wielemans] cat /etc/redhat-release
Red Hat Enterprise Linux WS release 3 (Taroon Update 1)

[wielemans@electro:wielemans] uname -a
Linux electro 2.4.21-9.0.1.EL #2 Fri Apr 16 13:51:32 CEST 2004 i686 i686 
i386 GNU/Linux

[wielemans@electro:wielemans] gcc -v
Reading specs from /usr/lib/gcc-lib/i386-redhat-linux/3.2.3/specs
Configured with: ../configure --prefix=/usr --mandir=/usr/share/man 
--infodir=/usr/share/info --enable-shared --enable-threads=posix 
--disable-checking --with-system-zlib --enable-__cxa_atexit 
--host=i386-redhat-linux
Thread model: posix
gcc version 3.2.3 20030502 (Red Hat Linux 3.2.3-24)

If you need more details, please ask !  Any help or idea welcome, thanks in 
advance...

Have a nice day !

Willy.

Xavier Wielemans

Alterface
Avenue Alexander Fleming 10
B-1348 Louvain-la-Neuve
Belgium
http://www.alterface.com

phone: +32 10 48 00 63
fax: +32 10 48 00 69


