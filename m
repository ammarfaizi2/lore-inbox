Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265740AbUBBRPA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 12:15:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265745AbUBBRPA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 12:15:00 -0500
Received: from fw.osdl.org ([65.172.181.6]:39568 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265740AbUBBROx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 12:14:53 -0500
Date: Mon, 2 Feb 2004 09:08:55 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-dvb-maintainer@linuxtv.org, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] DVB compile fix
Message-Id: <20040202090855.0b90b2ae.rddunlap@osdl.org>
In-Reply-To: <Pine.GSO.4.58.0402021709560.19699@waterleaf.sonytel.be>
References: <Pine.GSO.4.58.0402021709560.19699@waterleaf.sonytel.be>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Feb 2004 17:10:40 +0100 (MET) Geert Uytterhoeven <geert@linux-m68k.org> wrote:

| 
| Never include <asm/delay.h> directly
| 
| --- linux-2.6.2-rc3/drivers/media/dvb/frontends/dst.c	2004-01-06 15:29:13.000000000 +0100
| +++ linux-m68k-2.6.2-rc3/drivers/media/dvb/frontends/dst.c	2004-01-10 17:10:35.000000000 +0100
| @@ -28,8 +28,8 @@
|  #include <linux/string.h>
|  #include <linux/slab.h>
|  #include <linux/vmalloc.h>
| +#include <linux/delay.h>
|  #include <asm/div64.h>
| -#include <asm/delay.h>


You could modify <asm/delay.h> the way that
include/asm-i386/rwsem.h is done so that this won't continue
to happen:

#ifndef _LINUX_RWSEM_H
#error "please don't include asm/rwsem.h directly, use linux/rwsem.h instead"
#endif

--
~Randy
kernel-janitors project:  http://janitor.kernelnewbies.org/
