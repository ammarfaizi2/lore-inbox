Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262230AbTH3XLy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Aug 2003 19:11:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262232AbTH3XLy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Aug 2003 19:11:54 -0400
Received: from CPE-203-51-31-218.nsw.bigpond.net.au ([203.51.31.218]:59891
	"EHLO e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id S262230AbTH3XLw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Aug 2003 19:11:52 -0400
Message-ID: <3F512F33.44537860@eyal.emu.id.au>
Date: Sun, 31 Aug 2003 09:11:47 +1000
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.4.22 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo@conectiva.com.br>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.23-pre2 - airo.c compile failure
References: <Pine.LNX.4.55L.0308301220020.31588@freak.distro.conectiva>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:
> 
> Hello,
> 
> Here goes -pre2. It contains an USB update, PPC merge, m68k merge, IDE

gcc -D__KERNEL__ -I/data2/usr/local/src/linux-2.4-pre/include -Wall
-Wstrict-pro
totypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-fomit-frame-pointer
 -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4
-DMODULE -DM
ODVERSIONS -include
/data2/usr/local/src/linux-2.4-pre/include/linux/modversions
.h  -nostdinc -iwithprefix include -DKBUILD_BASENAME=airo 
-DEXPORT_SYMTAB -c ai
ro.c
airo.c: In function `airo_get_power':
airo.c:5659: parse error before `int'
airo.c:5660: `mode' undeclared (first use in this function)
airo.c:5660: (Each undeclared identifier is reported only once
airo.c:5660: for each function it appears in.)
airo.c: In function `writerids':
airo.c:6673: warning: unused variable `enabled'
make[3]: *** [airo.o] Error 1
make[3]: Leaving directory
`/data2/usr/local/src/linux-2.4-pre/drivers/net/wirel
ess'

Cannot tell if it is a bad merge ('int mode =' line should be earlier?)
or bad programming (declaration must come first).

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
