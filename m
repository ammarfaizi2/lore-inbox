Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262746AbTLJHEM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 02:04:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262794AbTLJHEM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 02:04:12 -0500
Received: from snet-95-39.adsl.bestweb.net ([216.179.95.39]:45323 "EHLO
	mail.srealm.net.au") by vger.kernel.org with ESMTP id S262746AbTLJHEC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 02:04:02 -0500
Subject: cryproloop + highmem (2.6.0-test11)
From: "Preston A. Elder" <prez@goth.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: GOTH.NET
Message-Id: <1071039770.8975.7.camel@temple.srealm.net.au>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 10 Dec 2003 02:02:50 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'd like to draw everyone's attention back to an issue last discussed
back on the 16th November regarding cryptoloop + highmem causing a crash
of the system.  I am using 2.6.0-test11 on a Dual Athlon 1800+/1gb ram
(more system specs available on request).

>From my searches of the LKML, this was not resolved.  I too have this
issue, where using cryptoloop on my system with highmem compiled in
causes the system to crash.  I have also noticed other side-effects
aswell (for example processes like grep core-dumping for no reason,
which does not happen normally) that only a reboot of the system fixes.

I have not tried compiling OUT highmem, as I have 1gb ram, and unless
something has changed, I need to have highmem compiled in or I will
sacrifice about 128mb ram (if this is not the case, and I can get the
full 1gb ram, I will disable highmem in a heartbeat).  

I noticed in the last thread, Linus asked for gcc -v output, so here is
mine in advance:
Reading specs from /usr/lib/gcc-lib/i686-pc-linux-gnu/3.3.2/specs
Configured with: /var/tmp/portage/gcc-3.3.2-r3/work/gcc-3.3.2/configure
--prefix=/usr --bindir=/usr/i686-pc-linux-gnu/gcc-bin/3.3
--includedir=/usr/lib/gcc-lib/i686-pc-linux-gnu/3.3.2/include
--datadir=/usr/share/gcc-data/i686-pc-linux-gnu/3.3
--mandir=/usr/share/gcc-data/i686-pc-linux-gnu/3.3/man
--infodir=/usr/share/gcc-data/i686-pc-linux-gnu/3.3/info --enable-shared
--host=i686-pc-linux-gnu --target=i686-pc-linux-gnu --with-system-zlib
--enable-languages=c,c++,f77,objc,java --enable-threads=posix
--enable-long-long --disable-checking --enable-cstdio=stdio
--enable-clocale=generic --enable-__cxa_atexit
--enable-version-specific-runtime-libs
--with-gxx-include-dir=/usr/lib/gcc-lib/i686-pc-linux-gnu/3.3.2/include/g++-v3 --with-local-prefix=/usr/local --enable-shared --enable-nls --without-included-gettext --disable-multilib
Thread model: posix
gcc version 3.3.2 20031022 (Gentoo Linux 3.3.2-r3, propolice)

This is causing me great problems, since I need the usage of my crypto
loopback filesystems.  If you require any further information, or wish
me to perform some tests, etc - I'd be more than happy to help.

Thanks,

-- 
PreZ
Systems Administrator
GOTH.NET

Goth Code '98:   tSKeba5qaSabsaaaGbaa75KAASWGuajmsvbieqcL4BaaLb3F4
                 nId5mefqmDjmmgm#haxthgzpj4GiysNkycSRGHabiabOkauNSW

GOTH.NET - http://www.goth.net
Free online resource for the gothic community.


