Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264932AbSJ3WoN>; Wed, 30 Oct 2002 17:44:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264941AbSJ3WoN>; Wed, 30 Oct 2002 17:44:13 -0500
Received: from web1.elbnet.com ([65.209.12.165]:9652 "EHLO web1.elbnet.com")
	by vger.kernel.org with ESMTP id <S264932AbSJ3WoM>;
	Wed, 30 Oct 2002 17:44:12 -0500
Date: Wed, 30 Oct 2002 17:38:43 -0500
From: Bob Billson <reb@bhive.dhs.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org
Subject: lkc 1.2: make xmenu error
Message-ID: <20021030223843.GF4186@etain.bhive.dhs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4i
Organization: Hopeless... my honeybees are more organized.
X-Moon: The Moon is Waning Crescent (33% of Full)
X-Uptime: 13:29:43 up 22:20,  5 users,  load average: 1.80, 1.19, 1.06
X-GPG-Key: http://bhive.dhs.org/gpgkey.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roman ...

I was trying out lkc v1.2 on 2.5.44.  make xconfig coughs up the following
error:

[reb@etain]:~/kernel/linux-2.5.44$ make xconfig
make -f scripts/Makefile 
make -f scripts/kconfig/Makefile scripts/kconfig/qconf
  gcc -Wp,-MD,scripts/kconfig/.conf.o.d -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer   -c -o scripts/kconfig/conf.o scripts/kconfig/conf.c
  gcc -Wp,-MD,scripts/kconfig/.kconfig_load.o.d -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer   -c -o scripts/kconfig/kconfig_load.o scripts/kconfig/kconfig_load.c
  gcc -Wp,-MD,scripts/kconfig/.mconf.o.d -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer   -c -o scripts/kconfig/mconf.o scripts/kconfig/mconf.c
/usr/share/qt/bin/moc -i scripts/kconfig/qconf.h -o scripts/kconfig/qconf.moc
make[1]: /usr/share/qt/bin/moc: Command not found
make[1]: *** [scripts/kconfig/qconf.moc] Error 127
make: *** [scripts/kconfig/qconf] Error 2

This is on a Debian (testing tree) box with the libqt3-dev package
installed.  moc is there, just not in /usr/share/qt/bin:

[reb@etain]:~/kernel/linux-2.5.44$ whereis moc
moc: /usr/bin/moc /usr/share/man/man1/moc.1.gz
      
I didn't see this mentioned on lkml yet.  Apologies if it was and I missed
it.
          bob
-- 
 bob billson        email: reb@bhive.dhs.org          ham: kc2wz    /)
                           reb@elbnet.com             beekeeper  -8|||}
 "Níl aon tinteán mar do thinteán féin." --Dorothy    Linux geek    \)
 [ GPG key: http://bhive.dhs.org/gpgkey.html ]
