Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129518AbQLFKkQ>; Wed, 6 Dec 2000 05:40:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130397AbQLFKkG>; Wed, 6 Dec 2000 05:40:06 -0500
Received: from ajax1.sovam.com ([194.67.1.172]:46745 "EHLO ajax1.sovam.com")
	by vger.kernel.org with ESMTP id <S129518AbQLFKjv>;
	Wed, 6 Dec 2000 05:39:51 -0500
Date: Wed, 6 Dec 2000 14:51:58 +0500
From: Dilshod Mukhtarov <dilshodm@bigfoot.com>
X-Mailer: The Bat! (v1.47 Halloween Edition) Personal
Organization: Institute of Cybernetics
X-Priority: 3 (Normal)
Message-ID: <86577603.20001206145158@bigfoot.com>
To: linux-kernel@vger.kernel.org
Subject: Won't compile linux-2.4.0-test12-pre5: UDF and DUMMY
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello linux-kernel,

I tried to compile linux-2.4.0-test12-pre5, but it gives two errors:

make[3]: Entering directory `/usr/src/linux-2.4.0-test12-pre5/fs/udf'
gcc -D__KERNEL__ -I/usr/src/linux-2.4.0-test12-pre5/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe  -march=i686    -c -o
inode.o inode.c
inode.c: In function `udf_expand_file_adinicb':
inode.c:205: too many arguments to function
make[3]: *** [inode.o] Error 1


gcc -D__KERNEL__ -I/usr/src/linux-2.4.0-test12-pre5/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe  -march=i686 -DMODULE
-DMODVERSIONS -include /usr/src/linux-2.4.0-test12-pre5/include/linux/modversions.h   -c -o dummy.o dummy.c
dummy.c: In function `dummy_init_module':
dummy.c:103: invalid type argument of `->'
make[2]: *** [dummy.o] Error 1

In my configuration file:

CONFIG_BLK_DEV_IDESCSI=y
CONFIG_SCSI=y
CONFIG_BLK_DEV_SD=y
CONFIG_SD_EXTRA_DEVS=40

CONFIG_DUMMY=m
CONFIG_UDF_FS=y
CONFIG_UDF_RW=y


If somebody answer, please, send carbon-copy to my e-mail. Thanks.

Best regards,
 Dilshod                          mailto:dilshodm@bigfoot.com
ICQ UIN: 17915089


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
