Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262591AbTLBRH7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 12:07:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262601AbTLBRH7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 12:07:59 -0500
Received: from fw.osdl.org ([65.172.181.6]:62172 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262591AbTLBRH4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 12:07:56 -0500
Date: Tue, 2 Dec 2003 09:00:58 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.23-bk1 && RTC
Message-Id: <20031202090058.6e38dfb0.rddunlap@osdl.org>
In-Reply-To: <20031202155313.GD18468@rdlg.net>
References: <20031202155313.GD18468@rdlg.net>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Dec 2003 10:53:13 -0500 "Robert L. Harris" <Robert.L.Harris@rdlg.net> wrote:

| 
| 
| Looks like RTC is broken in 2.4.23-bk1.
| 
| gcc -D__KERNEL__ -I/exp/src1/kernels/2.4.23/Server/General/linux-2.4.23/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i586 -nostdinc -iwithprefix include -DKBUILD_BASENAME=rtc  -c -o rtc.o rtc.c
| rtc.c: In function `rtc_init':
| rtc.c:772: `RTC_IOMAPPED' undeclared (first use in this function)
| rtc.c:772: (Each undeclared identifier is reported only once
| rtc.c:772: for each function it appears in.)
| rtc.c:773: `RTC_IO_EXTENT' undeclared (first use in this function)
| rtc.c: In function `rtc_exit':
| rtc.c:873: `RTC_IOMAPPED' undeclared (first use in this function)
| rtc.c:874: `RTC_IO_EXTENT' undeclared (first use in this function)
| 
| If I disable the Enhanced Real Time Clock in menuconfig it compiles just
| fine.


Marcelo just applied the patch here:
  http://lkml.org/lkml/2003/12/1/150


--
~Randy
MOTD:  Always include version info.
