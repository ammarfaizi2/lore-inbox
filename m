Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262289AbTB0Ja2>; Thu, 27 Feb 2003 04:30:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262420AbTB0Ja2>; Thu, 27 Feb 2003 04:30:28 -0500
Received: from [202.181.238.133] ([202.181.238.133]:18832 "EHLO debian.org.hk")
	by vger.kernel.org with ESMTP id <S262289AbTB0Ja2>;
	Thu, 27 Feb 2003 04:30:28 -0500
Message-ID: <3E5DDCE7.2040100@linux.org.hk>
Date: Thu, 27 Feb 2003 17:39:51 +0800
From: Ben Lau <benlau@linux.org.hk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021226 Debian/1.2.1-9
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.21-pre5
References: <Pine.LNX.4.53L.0302270314050.1433@freak.distro.conectiva>
In-Reply-To: <Pine.LNX.4.53L.0302270314050.1433@freak.distro.conectiva>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

   I have tried to compile the -pre5 with IEEE1394
support and i got the following error:

 gcc -D__KERNEL__ -I/usr/src/2.4.21pre5/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i386
-DMODULE  -nostdinc -iwithprefix include -DKBUILD_BASENAME=raw1394  -c
-o raw1394.o raw1394.c
 In file included from raw1394.c:50:
 raw1394.h:167: field `tq' has incomplete type
 raw1394.c: In function `__alloc_pending_request':
 raw1394.c:110: warning: implicit declaration of function `HPSB_INIT_WORK'
 raw1394.c:118: confused by earlier errors, bailing out
 make[2]: *** [raw1394.o] Error 1
 make[2]: Leaving directory `/usr/src/2.4.21pre5/drivers/ieee1394'
 make[1]: *** [_modsubdir_ieee1394] Error 2
 make[1]: Leaving directory `/usr/src/2.4.21pre5/drivers'
 make: *** [_mod_drivers] Error 2

The definition of hpsb_queue_struct was missing
in the -pre5. I found that it did exist on -pre4

/usr/src/2.4.21pre4/drivers/ieee1394/ieee1394_types.h:45:#define
hpsb_queue_struct tq_struct



