Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314225AbSEFHA5>; Mon, 6 May 2002 03:00:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314231AbSEFHA5>; Mon, 6 May 2002 03:00:57 -0400
Received: from smtp-out-4.wanadoo.fr ([193.252.19.23]:33453 "EHLO
	mel-rto4.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S314225AbSEFHA4> convert rfc822-to-8bit; Mon, 6 May 2002 03:00:56 -0400
Subject: 2.5.14 error: ini9100u.c
From: angus <angus@mcm.net>
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
X-Mailer: Ximian Evolution 1.0.3-1mdk 
Date: 06 May 2002 11:00:48 +0200
Message-Id: <1020675649.20692.6.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just a bug report of compilation which perdure since several 2.5 release
concerning the driver of initio scsi card and which prevents me from
testing any 2.5.x :(

Please CC: back to me, as I'm not subscribed.
Any help welcome, even bearers of bad news :)


gcc -D__KERNEL__ -I/usr/src/linux-2.5.14/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=k6 -DMODULE -DMODVERSIONS -include
/usr/src/linux-2.5.14/include/linux/modversions.h 
-DKBUILD_BASENAME=ini9100u  -c -o ini9100u.o ini9100u.c
ini9100u.c:111:2: #error Please convert me to
Documentation/DMA-mapping.txt
ini9100u.c: In function `i91uBuildSCB':
ini9100u.c:494: structure has no member named `address'
ini9100u.c:503: structure has no member named `address'
make[2]: *** [ini9100u.o] Erreur 1
make[2]: Quitte le répertoire `/usr/src/linux-2.5.14/drivers/scsi'
make[1]: *** [_modsubdir_scsi] Erreur 2
make[1]: Quitte le répertoire `/usr/src/linux-2.5.14/drivers'
make: *** [_mod_drivers] Erreur 2

