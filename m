Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319303AbSIKUAJ>; Wed, 11 Sep 2002 16:00:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319304AbSIKUAJ>; Wed, 11 Sep 2002 16:00:09 -0400
Received: from ulima.unil.ch ([130.223.144.143]:30087 "HELO ulima.unil.ch")
	by vger.kernel.org with SMTP id <S319303AbSIKUAI>;
	Wed, 11 Sep 2002 16:00:08 -0400
Date: Wed, 11 Sep 2002 22:04:56 +0200
From: Gregoire Favre <greg@ulima.unil.ch>
To: linux-kernel@vger.kernel.org
Subject: Can't compil i2o_block.c and i2o... in 2.5.34
Message-ID: <20020911200456.GB22435@ulima.unil.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I haden't noticed this problem being reported to this ml, but maybe I am
wrong, in that case, I am sorry ;-)

Trying to compil the 2.5.34 I got:

  gcc -Wp,-MD,./.i2o_block.o.d -D__KERNEL__ -I/usr/src/linux-2.5/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -nostdinc -iwithprefix include -DMODULE   -DKBUILD_BASENAME=i2o_block   -c -o i2o_block.o i2o_block.c
i2o_block.c:43:2: #error Please convert me to Documentation/DMA-mapping.txt
i2o_block.c: In function `i2ob_send':
i2o_block.c:325: warning: comparison between pointer and integer
i2o_block.c: In function `i2ob_install_device':
i2o_block.c:1241: structure has no member named `queue_buggy'
i2o_block.c:1244: structure has no member named `queue_buggy'
i2o_block.c:1328: incompatible type for argument 1 of `set_capacity'
i2o_block.c: In function `init_module':
i2o_block.c:1775: warning: passing arg 1 of `sprintf' discards qualifiers from pointer target type
make[3]: *** [i2o_block.o] Error 1
make[3]: Leaving directory `/usr/src/linux-2.5/drivers/message/i2o'
make[2]: *** [i2o] Error 2
make[2]: Leaving directory `/usr/src/linux-2.5/drivers/message'
make[1]: *** [message] Error 2
make[1]: Leaving directory `/usr/src/linux-2.5/drivers'
make: *** [drivers] Error 2
80.160u 6.310s 1:42.73 84.1%	0+0k 0+0io 419602pf+0w
Exit 2

Removing it, and then:
  gcc -Wp,-MD,./.i2o_lan.o.d -D__KERNEL__ -I/usr/src/linux-2.5/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -nostdinc -iwithprefix include -DMODULE   -DKBUILD_BASENAME=i2o_lan   -c -o i2o_lan.o i2o_lan.c
i2o_lan.c:28:2: #error Please convert me to Documentation/DMA-mapping.txt
make[3]: *** [i2o_lan.o] Error 1
make[3]: Leaving directory `/usr/src/linux-2.5/drivers/message/i2o'
make[2]: *** [i2o] Error 2
make[2]: Leaving directory `/usr/src/linux-2.5/drivers/message'
make[1]: *** [message] Error 2
make[1]: Leaving directory `/usr/src/linux-2.5/drivers'
make: *** [drivers] Error 2
Exit 2

  gcc -Wp,-MD,./.i2o_scsi.o.d -D__KERNEL__ -I/usr/src/linux-2.5/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -nostdinc -iwithprefix include -DMODULE   -DKBUILD_BASENAME=i2o_scsi   -c -o i2o_scsi.o i2o_scsi.c
i2o_scsi.c:34:2: #error Please convert me to Documentation/DMA-mapping.txt
i2o_scsi.c: In function `i2o_scsi_reply':
i2o_scsi.c:194: warning: assignment from incompatible pointer type
i2o_scsi.c:289: warning: assignment from incompatible pointer type
i2o_scsi.c: In function `i2o_scsi_queuecommand':
i2o_scsi.c:726: structure has no member named `address'
i2o_scsi.c:737: structure has no member named `address'
make[3]: *** [i2o_scsi.o] Error 1
make[3]: Leaving directory `/usr/src/linux-2.5/drivers/message/i2o'
make[2]: *** [i2o] Error 2
make[2]: Leaving directory `/usr/src/linux-2.5/drivers/message'
make[1]: *** [message] Error 2
make[1]: Leaving directory `/usr/src/linux-2.5/drivers'
make: *** [drivers] Error 2
Exit 2

And afterthat everything got perfectly compiled ;-)

Have a great day ;-)

	Grégoire
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch
