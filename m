Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261827AbUAYAv5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 19:51:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261872AbUAYAv5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 19:51:57 -0500
Received: from gizmo13bw.bigpond.com ([144.140.70.23]:5080 "HELO
	gizmo13bw.bigpond.com") by vger.kernel.org with SMTP
	id S261827AbUAYAvz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 19:51:55 -0500
Message-ID: <40131312.ADD37133@eyal.emu.id.au>
Date: Sun, 25 Jan 2004 11:51:30 +1100
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.4.25-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.25-pre7
References: <Pine.LNX.4.58L.0401231652020.19820@logos.cnet>
		<40125540.A33B8AB2@eyal.emu.id.au> <20040125014920.54a786cc.yuasa@hh.iij4u.or.jp>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yoichi Yuasa wrote:
> >
> > There are no it8181fb.* files there.
> 
> This file comes from a MIPS CVS tree.
> 
> I have this file.
> You can get following.
> 
> http://www.hh.iij4u.or.jp/~yuasa/linux-vr/v2.4/it8181fb.c

I added it and now get:

gcc -D__KERNEL__ -I/data2/usr/local/src/linux-2.4-pre/include -Wall
-Wstrict-pro
totypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-fomit-frame-pointer
 -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4
-DMODULE -DM
ODVERSIONS -include
/data2/usr/local/src/linux-2.4-pre/include/linux/modversions
.h  -nostdinc -iwithprefix include -DKBUILD_BASENAME=it8181fb  -c -o
it8181fb.o 
it8181fb.c
it8181fb.c: In function `it8181fb_init':
it8181fb.c:1200: `PCI_DEVICE_ID_ITE_IT8181' undeclared (first use in
this functi
on)
it8181fb.c:1200: (Each undeclared identifier is reported only once
it8181fb.c:1200: for each function it appears in.)
it8181fb.c: At top level:
it8181fb.c:162: warning: `fontname' defined but not used
make[2]: *** [it8181fb.o] Error 1
make[2]: Leaving directory
`/data2/usr/local/src/linux-2.4-pre/drivers/video'

So maybe it really is a MIPS only file (I am on x86)?

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
