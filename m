Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268230AbRGWNeO>; Mon, 23 Jul 2001 09:34:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268229AbRGWNeE>; Mon, 23 Jul 2001 09:34:04 -0400
Received: from ogma.cisco.com ([144.254.74.39]:47577 "HELO ogma.cisco.com")
	by vger.kernel.org with SMTP id <S268227AbRGWNdt>;
	Mon, 23 Jul 2001 09:33:49 -0400
Message-ID: <3B5C27BD.A81DF676@cisco.com>
Date: Mon, 23 Jul 2001 15:33:49 +0200
From: Jan Just Keijser <janjust@cisco.com>
Organization: Cisco Systems Inc
X-Mailer: Mozilla 4.08 [en] (X11; I; Linux 2.2.19-6.2.1 i686)
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: linux 2.4.7: DAC960.c no longer builds
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hi all,

just grabbed the linux 2.4.7 sources and started compiling; it barfs on
the DAC960.c module (which I need, actually):

gcc -D__KERNEL__ -I/local/janjust/src/linux-2.4.7/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2
-fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe  -march=i686
-DMODULE -DMODVERSIONS -include
/local/janjust/src/linux-2.4.7/include/linux/modversions.h
-DEXPORT_SYMTAB -c DAC960.c
DAC960.c: In function `DAC960_ProcessRequest':
DAC960.c:2771: structure has no member named `sem'
make[2]: *** [DAC960.o] Error 1


This member has indeed been removed from
$TOPDIR/include/linux/blkdev.h...

JJK / Jan Just Keijser
Cisco Systems Inc


