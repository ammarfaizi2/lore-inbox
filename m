Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286207AbSBSSYL>; Tue, 19 Feb 2002 13:24:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286322AbSBSSYB>; Tue, 19 Feb 2002 13:24:01 -0500
Received: from snowstorm.mail.pipex.net ([158.43.192.97]:16836 "HELO
	snowstorm.mail.pipex.net") by vger.kernel.org with SMTP
	id <S285720AbSBSSXw>; Tue, 19 Feb 2002 13:23:52 -0500
Content-Type: text/plain; charset=US-ASCII
From: Alastair Stevens <megh14@dsl.pipex.com>
Reply-To: alastair@altruxsolutions.co.uk
Organization: Altrux Solutions
To: linux-kernel@vger.kernel.org
Subject: compilation error: 2.4.18-rc2-ac1
Date: Tue, 19 Feb 2002 18:23:48 +0000
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020219182354Z285720-889+3397@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I received the following compilation error when building 2.4.18-rc2-ac1 under 
Red Hat 7.2 on a dead ordinary i686 system (during "make modules") - hope 
this is useful!

I have previously built 2.4.18-pre9-ac3 successfully, with the same config 
(ie only doing "make oldconfig").

--------------------------

make -C scsi modules
make[2]: Entering directory `/home/alastair/linux-2.4/drivers/scsi'
gcc -D__KERNEL__ -I/home/alastair/linux-2.4/include -Wall -Wstrict-prototypes 
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common 
-pipe -mpreferred-stack-boundary=2 -march=i686 -DMODULE -DMODVERSIONS 
-include /home/alastair/linux-2.4/include/linux/modversions.h  
-DKBUILD_BASENAME=scsi  -c -o scsi.o scsi.c
In file included from 
/home/alastair/linux-2.4/include/linux/modversions.h:144,
                 from scsi.c:1:
/home/alastair/linux-2.4/include/linux/modules/journal.ver:33:22: warning: 
ISO C requires whitespace after the macro name
gcc -D__KERNEL__ -I/home/alastair/linux-2.4/include -Wall -Wstrict-prototypes 
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common 
-pipe -mpreferred-stack-boundary=2 -march=i686 -DMODULE -DMODVERSIONS 
-include /home/alastair/linux-2.4/include/linux/modversions.h  
-DKBUILD_BASENAME=hosts  -c -o hosts.o hosts.c
In file included from 
/home/alastair/linux-2.4/include/linux/modversions.h:144,
                 from hosts.c:1:
/home/alastair/linux-2.4/include/linux/modules/journal.ver:33:22: warning: 
ISO C requires whitespace after the macro name
hosts.c: In function `scsi_register_R62be6ba8':
hosts.c:267: Internal error: Segmentation fault.
Please submit a full bug report.
See <URL:http://bugzilla.redhat.com/bugzilla/> for instructions.
make[2]: *** [hosts.o] Error 1
make[2]: Leaving directory `/home/alastair/linux-2.4/drivers/scsi'
make[1]: *** [_modsubdir_scsi] Error 2
make[1]: Leaving directory `/home/alastair/linux-2.4/drivers'
make: *** [_mod_drivers] Error 2

------------------------------

Regards
Alastair
