Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263542AbTGTILO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 04:11:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263462AbTGTILN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 04:11:13 -0400
Received: from CPE-203-51-35-8.nsw.bigpond.net.au ([203.51.35.8]:42992 "EHLO
	e4.eyal.emu.id.au") by vger.kernel.org with ESMTP id S263542AbTGTILB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 04:11:01 -0400
Message-ID: <3F1A5214.CEF2913A@eyal.emu.id.au>
Date: Sun, 20 Jul 2003 18:25:56 +1000
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.4.22-pre7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.22pre7aa1: net/bluetooth/cmtp/core.c failure
References: <20030719013223.GA31330@dualathlon.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> 
> URL:
> 
>         http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.22pre7aa1.bz2
>         http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.22pre7aa1/

gcc -D__KERNEL__ -I/data2/usr/local/src/linux-2.4-pre-aa/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
-fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686
-malign-functions=4 -DMODULE -DMODVERSIONS -include
/data2/usr/local/src/linux-2.4-pre-aa/include/linux/modversions.h 
-nostdinc -iwithprefix include -DKBUILD_BASENAME=core  -c -o core.o
core.c
core.c: In function `cmtp_session':
core.c:301: structure has no member named `nice'
make[3]: *** [core.o] Error 1
make[3]: Leaving directory
`/data2/usr/local/src/linux-2.4-pre-aa/net/bluetooth/cmtp'

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
