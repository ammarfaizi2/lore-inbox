Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314829AbSGUVlR>; Sun, 21 Jul 2002 17:41:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315119AbSGUVlR>; Sun, 21 Jul 2002 17:41:17 -0400
Received: from ip68-102-192-193.ks.ok.cox.net ([68.102.192.193]:21405 "EHLO
	jakob") by vger.kernel.org with ESMTP id <S314829AbSGUVlQ>;
	Sun, 21 Jul 2002 17:41:16 -0400
Date: Sun, 21 Jul 2002 16:45:37 -0500
To: linux-kernel@vger.kernel.org
Subject: 2.5.27 build errors - linux/i2c-old.h
Message-ID: <20020721214537.GA24886@ksu.edu>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-School: Kansas State University
X-vi-or-emacs: vi
X-MSMail-Priority: High
X-Priority: 1 (Highest)
X-MS-TNEF-Correlator: <AFJAUFHRUOGRESULWAOIHFEAUIOFBVHSHNRAIU.monkey@spamcentral.invalid>
X-MimeOLE: Not Produced By Microsoft MimeOLE V5.50.4522.1200
From: "Johnny Q. Hacker" <trelane@jakob.neurotek.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

We're moving, or I'd track thisone down meself.  I'd guess that it'll
  be fairly easy to rectify.

  gcc -E -Wp,-MD,/usr/local/src/kernel/linux-2.5.27/include/linux/modules/drivers/media/video/.i2c-old.ver.d -D__KERNEL__ -I/usr/local/src/kernel/linux-2.5.27/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -nostdinc -iwithprefix include -DMODULE   -DKBUILD_BASENAME=i2c_old -D__GENKSYMS__  i2c-old.c | /sbin/genksyms  -k 2.5.27 > /usr/local/src/kernel/linux-2.5.27/include/linux/modules/drivers/media/video/i2c-old.ver.tmp
i2c-old.c:17: linux/i2c-old.h: No such file or directory
make[5]: *** [/usr/local/src/kernel/linux-2.5.27/include/linux/modules/drivers/media/video/i2c-old.ver] Error 1
make[5]: Leaving directory `/usr/local/src/kernel/linux-2.5.27/drivers/media/video'
make[4]: *** [video] Error 2
make[4]: Leaving directory `/usr/local/src/kernel/linux-2.5.27/drivers/media'
make[3]: *** [media] Error 2
make[3]: Leaving directory `/usr/local/src/kernel/linux-2.5.27/drivers'
make[2]: *** [_sfdep_drivers] Error 2
make[2]: Leaving directory `/usr/local/src/kernel/linux-2.5.27'
make[1]: *** [include/linux/modversions.h] Error 2
make[1]: Leaving directory `/usr/local/src/kernel/linux-2.5.27'
make: *** [.hdepend] Error 2

-- 
"We're moving toward a world where all the capabilities of the Internet
 are reprocessed through a single filter, with Microsoft's business plan
 behind it."  Mozilla's Mitchell Baker, 
http://news.com.com/2100-1023-941926.html
