Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262139AbTIMMoL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 08:44:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262140AbTIMMoL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 08:44:11 -0400
Received: from CPE-203-51-31-218.nsw.bigpond.net.au ([203.51.31.218]:31479
	"EHLO e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id S262139AbTIMMoJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 08:44:09 -0400
Message-ID: <3F631113.4C6368D3@eyal.emu.id.au>
Date: Sat, 13 Sep 2003 22:44:03 +1000
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.4.22-aa1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.23-pre4: failed at atyfb_base.c
References: <Pine.LNX.4.44.0309121528290.3893-100000@logos.cnet>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:
> 
> Hello,
> 
> Here goes -pre4, which contains networking update, IA64 update, PPC
> update, USB update, bunch of knfsd fixes, amongst others.
gcc -D__KERNEL__ -I/data2/usr/local/src/linux-2.4-pre/include -Wall
-Wstrict-pro
totypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-fomit-frame-pointer
 -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4
-DMODULE -DM
ODVERSIONS -include
/data2/usr/local/src/linux-2.4-pre/include/linux/modversions
.h  -nostdinc -iwithprefix include -DKBUILD_BASENAME=atyfb_base 
-DEXPORT_SYMTAB
 -c atyfb_base.c
atyfb_base.c: In function `aty_set_crtc':
atyfb_base.c:501: warning: passing arg 2 of `aty_st_lcd' makes integer
from pointer without a cast
atyfb_base.c:501: too few arguments to function `aty_st_lcd'
atyfb_base.c:504: warning: passing arg 2 of `aty_st_lcd' makes integer
from pointer without a cast
atyfb_base.c:504: too few arguments to function `aty_st_lcd'
make[3]: *** [atyfb_base.o] Error 1
make[3]: Leaving directory
`/data2/usr/local/src/linux-2.4-pre/drivers/video/aty'

I now disabled CONFIG_FB_ATY_GENERIC_LCD and it builds.

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
