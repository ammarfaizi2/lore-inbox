Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261411AbTJJLpc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 07:45:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261239AbTJJLpc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 07:45:32 -0400
Received: from CPE-203-51-31-61.nsw.bigpond.net.au ([203.51.31.61]:58616 "EHLO
	e4.eyal.emu.id.au") by vger.kernel.org with ESMTP id S261411AbTJJLpa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 07:45:30 -0400
Message-ID: <3F869BD4.ADB4D648@eyal.emu.id.au>
Date: Fri, 10 Oct 2003 21:45:24 +1000
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.4.23-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "list, linux-kernel" <linux-kernel@vger.kernel.org>,
       "Tosatti, Marcelo" <marcelo@conectiva.com.br>
Subject: 2.4.23-pre7 build problems
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I dropped off the list for a few days so am not sure what was already
reported, neither did I find anything in the archives about -pre7.

already reported:

gcc -D__KERNEL__ -I/data2/usr/local/src/linux-2.4-pre/include -Wall
-Wstrict-pro
totypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-fomit-frame-pointer
 -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4
-DMODULE -DM
ODVERSIONS -include
/data2/usr/local/src/linux-2.4-pre/include/linux/modversions
.h  -nostdinc -iwithprefix include -DKBUILD_BASENAME=megaraid2  -c -o
megaraid2.
o megaraid2.c
megaraid2.c: In function `mega_find_card':
megaraid2.c:403: structure has no member named `lock'
make[2]: *** [megaraid2.o] Error 1
make[2]: Leaving directory
`/data2/usr/local/src/linux-2.4-pre/drivers/scsi'

no report found:

gcc -D__KERNEL__ -I/data2/usr/local/src/linux-2.4-pre/include -Wall
-Wstrict-pro
totypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-fomit-frame-pointer
 -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4
-DMODULE -DM
ODVERSIONS -include
/data2/usr/local/src/linux-2.4-pre/include/linux/modversions
.h  -nostdinc -iwithprefix include -DKBUILD_BASENAME=nsp32  -c -o
nsp32.o nsp32.
c
In file included from nsp32.c:56:
nsp32.h:645: redefinition of `irqreturn_t'
/data2/usr/local/src/linux-2.4-pre/include/linux/interrupt.h:16:
`irqreturn_t' previously declared here
make[2]: *** [nsp32.o] Error 1
make[2]: Leaving directory
`/data2/usr/local/src/linux-2.4-pre/drivers/scsi'

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
