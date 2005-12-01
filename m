Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932553AbVLAXfd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932553AbVLAXfd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 18:35:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932271AbVLAXfd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 18:35:33 -0500
Received: from relay02.mail-hub.dodo.com.au ([202.136.32.45]:24737 "EHLO
	relay02.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S932553AbVLAXfc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 18:35:32 -0500
From: Grant Coady <grant_lkml@dodo.com.au>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Eyal Lebedinsky <eyal@eyal.emu.id.au>,
       list linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.15-rc4
Date: Fri, 02 Dec 2005 10:37:20 +1100
Organization: http://bugsplatter.mine.nu/
Reply-To: gcoady@gmail.com
Message-ID: <862vo198it7molqvq5ign38qmncmjk3bo5@4ax.com>
References: <Pine.LNX.4.64.0511302234020.3099@g5.osdl.org>  <1133445903.16820.1.camel@localhost>  <Pine.LNX.4.64.0512010759571.3099@g5.osdl.org> <6f6293f10512011112m6e50fe0ejf0aa5ba9d09dca1e@mail.gmail.com> <Pine.LNX.4.64.0512011125280.3099@g5.osdl.org> <438F6DFF.2040603@eyal.emu.id.au> <Pine.LNX.4.64.0512011347290.3099@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0512011347290.3099@g5.osdl.org>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Dec 2005 13:53:28 -0800 (PST), Linus Torvalds <torvalds@osdl.org> wrote:

>(There are a couple of in-tree drivers that it would be interesting to 
>hear about too. In particular, all these files:
...
>	drivers/media/video/zr36120.c

Very broken:

  CC [M]  drivers/media/video/zr36120.o
drivers/media/video/zr36120.c:42:19: tuner.h: No such file or directory
In file included from drivers/media/video/zr36120.c:43:
drivers/media/video/zr36120.h:29:27: linux/i2c-old.h: No such file or directory
In file included from drivers/media/video/zr36120.c:43:
drivers/media/video/zr36120.h:101: error: field `i2c' has incomplete type
drivers/media/video/zr36120.c: In function `zoran_muxsel':
drivers/media/video/zr36120.c:389: warning: implicit declaration of function `i2c_control_device'
drivers/media/video/zr36120.c:389: error: `I2C_DRIVERID_VIDEODECODER' undeclared (first use in this function)
drivers/media/video/zr36120.c:389: error: (Each undeclared identifier is reported only once
drivers/media/video/zr36120.c:389: error: for each function it appears in.)
drivers/media/video/zr36120.c: In function `zoran_common_open':
drivers/media/video/zr36120.c:735: error: `I2C_DRIVERID_VIDEODECODER' undeclared (first use in this function)
drivers/media/video/zr36120.c: In function `zoran_ioctl':
drivers/media/video/zr36120.c:1157: error: `I2C_DRIVERID_VIDEODECODER' undeclared (first use in this function)
drivers/media/video/zr36120.c:1430: error: `I2C_DRIVERID_TUNER' undeclared (first use in this function)
drivers/media/video/zr36120.c:1430: error: `TUNER_SET_TVFREQ' undeclared (first use in this function)
drivers/media/video/zr36120.c: At top level:
drivers/media/video/zr36120.c:1487: error: unknown field `open' specified in initializer
drivers/media/video/zr36120.c:1487: warning: initialization makes integer from pointer without a cast
drivers/media/video/zr36120.c:1488: error: unknown field `close' specified in initializer
drivers/media/video/zr36120.c:1488: warning: initialization from incompatible pointer type
drivers/media/video/zr36120.c:1489: error: unknown field `read' specified in initializer
drivers/media/video/zr36120.c:1489: warning: initialization from incompatible pointer type
drivers/media/video/zr36120.c:1490: error: unknown field `write' specified in initializer
drivers/media/video/zr36120.c:1490: warning: initialization from incompatible pointer type
drivers/media/video/zr36120.c:1491: error: unknown field `poll' specified in initializer
drivers/media/video/zr36120.c:1492: error: unknown field `ioctl' specified in initializer
drivers/media/video/zr36120.c:1492: warning: initialization makes integer from pointer without a cast
drivers/media/video/zr36120.c:1493: error: unknown field `mmap' specified in initializer
drivers/media/video/zr36120.c:1493: warning: missing braces around initializer
drivers/media/video/zr36120.c:1493: warning: (near initialization for `zr36120_template.lock')
drivers/media/video/zr36120.c:1493: warning: initialization makes integer from pointer without a cast
drivers/media/video/zr36120.c: In function `vbi_read':
drivers/media/video/zr36120.c:1720: error: invalid type argument of `unary *'
drivers/media/video/zr36120.c:1720: error: invalid type argument of `unary *'
drivers/media/video/zr36120.c:1720: warning: type defaults to `int' in declaration of `type name'
drivers/media/video/zr36120.c:1720: error: invalid type argument of `unary *'
drivers/media/video/zr36120.c:1720: warning: type defaults to `int' in declaration of `type name'
drivers/media/video/zr36120.c:1720: error: invalid type argument of `unary *'
drivers/media/video/zr36120.c:1720: warning: type defaults to `int' in declaration of `type name'
drivers/media/video/zr36120.c:1720: error: invalid type argument of `unary *'
drivers/media/video/zr36120.c:1720: error: invalid type argument of `unary *'
drivers/media/video/zr36120.c:1720: warning: type defaults to `int' in declaration of `type name'
drivers/media/video/zr36120.c:1720: warning: type defaults to `int' in declaration of `type name'
drivers/media/video/zr36120.c: At top level:
drivers/media/video/zr36120.c:1819: error: unknown field `open' specified in initializer
drivers/media/video/zr36120.c:1819: warning: initialization makes integer from pointer without a cast
drivers/media/video/zr36120.c:1820: error: unknown field `close' specified in initializer
drivers/media/video/zr36120.c:1820: warning: initialization from incompatible pointer type
drivers/media/video/zr36120.c:1821: error: unknown field `read' specified in initializer
drivers/media/video/zr36120.c:1821: warning: initialization from incompatible pointer type
drivers/media/video/zr36120.c:1822: error: unknown field `write' specified in initializer
drivers/media/video/zr36120.c:1822: warning: initialization from incompatible pointer type
drivers/media/video/zr36120.c:1823: error: unknown field `poll' specified in initializer
drivers/media/video/zr36120.c:1824: error: unknown field `ioctl' specified in initializer
drivers/media/video/zr36120.c:1824: warning: initialization makes integer from pointer without a cast
drivers/media/video/zr36120.c: In function `find_zoran':
drivers/media/video/zr36120.c:1860: warning: passing arg 2 of `request_irq' from incompatible pointer type
drivers/media/video/zr36120.c: In function `init_zoran':
drivers/media/video/zr36120.c:1999: warning: implicit declaration of function `i2c_register_bus'
drivers/media/video/zr36120.c: In function `release_zoran':
drivers/media/video/zr36120.c:2033: warning: implicit declaration of function `i2c_unregister_bus'
make[3]: *** [drivers/media/video/zr36120.o] Error 1
make[2]: *** [drivers/media/video] Error 2
make[1]: *** [drivers/media] Error 2
make: *** [drivers] Error 2

Grant.
