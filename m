Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264702AbUFQJkl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264702AbUFQJkl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 05:40:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266435AbUFQJkl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 05:40:41 -0400
Received: from CPE-203-51-26-230.nsw.bigpond.net.au ([203.51.26.230]:41212
	"EHLO e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id S264702AbUFQJkk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 05:40:40 -0400
Message-ID: <40D16710.9010105@eyal.emu.id.au>
Date: Thu, 17 Jun 2004 19:40:32 +1000
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
CC: linux-kernel@vger.kernel.org, martin.lubich@gmx.at
Subject: Re: Linux 2.4.27-pre6: visor.c
References: <20040616183343.GA9940@logos.cnet>
In-Reply-To: <20040616183343.GA9940@logos.cnet>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:

> <martin.lubich:gmx.at>:
>   o USB: add Clie TH55 Support in visor kernel module

A declaration at the wrong place.

gcc -D__KERNEL__ -I/data2/usr/local/src/linux-2.4-pre/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4 -DMODULE -DMODVERSIONS -include /data2/usr/local/src/linux-2.4-pre/include/linux/modversions.h  -nostdinc -iwithprefix include -DKBUILD_BASENAME=visor  -c -o visor.o visor.c
visor.c: In function `clie_5_startup':
visor.c:899: parse error before `struct'
visor.c:901: `connection_info' undeclared (first use in this function)
visor.c:901: (Each undeclared identifier is reported only once
visor.c:901: for each function it appears in.)
make[3]: *** [visor.o] Error 1
make[3]: Leaving directory `/data2/usr/local/src/linux-2.4-pre/drivers/usb/serial'
make[2]: *** [_modsubdir_serial] Error 2

--
Eyal Lebedinsky		(eyal@eyal.emu.id.au)
