Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313419AbSD3NEF>; Tue, 30 Apr 2002 09:04:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313472AbSD3NEE>; Tue, 30 Apr 2002 09:04:04 -0400
Received: from CPE-203-51-25-114.nsw.bigpond.net.au ([203.51.25.114]:6129 "EHLO
	e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id <S313421AbSD3NEC>; Tue, 30 Apr 2002 09:04:02 -0400
Message-ID: <3CCE9640.489FC05D@eyal.emu.id.au>
Date: Tue, 30 Apr 2002 23:04:00 +1000
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: list linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.4.19-pre7-ac3: opl3sa2 compile error
Content-Type: multipart/mixed;
 boundary="------------E43E6376BAF2E063E1D5B219"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------E43E6376BAF2E063E1D5B219
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

gcc -D__KERNEL__ -I/data2/usr/local/src/linux-2.4-pre-ac/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686
-malign-functions=4  -DMODULE -DMODVERSIONS -include
/data2/usr/local/src/linux-2.4-pre-ac/include/linux/modversions.h 
-nostdinc -I /usr/lib/gcc-lib/i386-linux/2.95.4/include
-DKBUILD_BASENAME=opl3sa2  -c -o opl3sa2.o opl3sa2.c
opl3sa2.c: In function `probe_opl3sa2':
opl3sa2.c:721: structure has no member named `iobase'
opl3sa2.c: In function `opl3sa2_pm_callback':
opl3sa2.c:982: warning: cast from pointer to integer of different size
make[2]: *** [opl3sa2.o] Error 1
make[2]: Leaving directory
`/data2/usr/local/src/linux-2.4-pre-ac/drivers/sound'

I think it should say 'io_base'.

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
--------------E43E6376BAF2E063E1D5B219
Content-Type: text/plain; charset=us-ascii;
 name="2.4.19-pre7-ac3-opl3sa2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.4.19-pre7-ac3-opl3sa2.patch"

*** linux/drivers/sound/opl3sa2.c.orig	Tue Apr 30 23:01:10 2002
--- linux/drivers/sound/opl3sa2.c	Tue Apr 30 23:01:22 2002
***************
*** 718,724 ****
  	}
  
  out_region:
! 	release_region(hw_config->iobase, 2);
  out_nodev:
  	return -ENODEV;
  }
--- 718,724 ----
  	}
  
  out_region:
! 	release_region(hw_config->io_base, 2);
  out_nodev:
  	return -ENODEV;
  }

--------------E43E6376BAF2E063E1D5B219--

