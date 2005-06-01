Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261383AbVFAOIO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261383AbVFAOIO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 10:08:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261385AbVFAOIO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 10:08:14 -0400
Received: from smtp3.brturbo.com.br ([200.199.201.164]:6617 "EHLO
	smtp3.brturbo.com.br") by vger.kernel.org with ESMTP
	id S261383AbVFAOHx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 10:07:53 -0400
Message-ID: <429DC137.30705@brturbo.com.br>
Date: Wed, 01 Jun 2005 11:07:51 -0300
From: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
User-Agent: Mozilla Thunderbird 1.0.2-3mdk (X11/20050322)
X-Accept-Language: pt-br, pt, es, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>,
       Linux and Kernel Video <video4linux-list@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Problem compiling zr36120 on kernel2.6.12-r5-mm2
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

    Trying to compile all multimedia video devices on kernel
2.6.12-r5-mm2 gives an error on zr36120.c. It looks like it uses an old
i2c spec (it tries to include linux/i2c-old.h). It also includes tuner.h
from wrong directory (it uses "tuner.h", instead <media/tuner.h>).

     One interesting thing is that this board is not present on
video4linux CVS.

------------------

CC [M]  drivers/media/video/zr36120.o
In file included from drivers/media/video/zr36120.c:42:
include/media/tuner.h:148: error: field `i2c' has incomplete type
include/media/tuner.h:154: error: syntax error before "v4l2_std_id"
include/media/tuner.h:154: warning: no semicolon at end of struct or union
include/media/tuner.h:173: error: syntax error before '}' token
In file included from drivers/media/video/zr36120.c:43:
drivers/media/video/zr36120.h:29:27: linux/i2c-old.h: No such file or
directory
In file included from drivers/media/video/zr36120.c:43:
drivers/media/video/zr36120.h:101: error: field `i2c' has incomplete type
drivers/media/video/zr36120.c: In function `zoran_muxsel':
drivers/media/video/zr36120.c:389: warning: implicit declaration of
function `i2c_control_device'
drivers/media/video/zr36120.c:389: error: `I2C_DRIVERID_VIDEODECODER'
undeclared (first use in this function)
drivers/media/video/zr36120.c:389: error: (Each undeclared identifier is
reported only once
drivers/media/video/zr36120.c:389: error: for each function it appears in.)
drivers/media/video/zr36120.c: In function `zoran_common_open':
drivers/media/video/zr36120.c:735: error: `I2C_DRIVERID_VIDEODECODER'
undeclared (first use in this function)
drivers/media/video/zr36120.c: In function `zoran_ioctl':
drivers/media/video/zr36120.c:1159: error: `I2C_DRIVERID_VIDEODECODER'
undeclared (first use in this function)
drivers/media/video/zr36120.c:1432: error: `I2C_DRIVERID_TUNER'
undeclared (first use
in this function)
drivers/media/video/zr36120.c: At top level:
drivers/media/video/zr36120.c:1489: error: unknown field `open'
specified in initia
lizer
drivers/media/video/zr36120.c:1489: warning: initialization makes
integer from pointer without a cast
drivers/media/video/zr36120.c:1490: error: unknown field `close'
specified in initiali
zer
drivers/media/video/zr36120.c:1490: warning: initialization from
incompatible pointer type
drivers/media/video/zr36120.c:1491: error: unknown field `read'
specified in initializ
er
drivers/media/video/zr36120.c:1491: warning: initialization from
incompatible pointer type
drivers/media/video/zr36120.c:1492: error: unknown field `write'
specified in initiali
zer
drivers/media/video/zr36120.c:1492: warning: initialization from
incompatible pointer type
drivers/media/video/zr36120.c:1493: error: unknown field `poll'
specified in initializ
er
drivers/media/video/zr36120.c:1494: error: unknown field `ioctl'
specified in initiali
zer
drivers/media/video/zr36120.c:1494: warning: initialization makes
integer from pointer without a cast
drivers/media/video/zr36120.c:1495: error: unknown field `mmap'
specified in initializ
er
drivers/media/video/zr36120.c:1495: warning: missing braces around
initializer
drivers/media/video/zr36120.c:1495: warning: (near initialization for
`zr36120_template.lock
')
drivers/media/video/zr36120.c:1495: warning: initialization makes
integer from pointer without a cast
drivers/media/video/zr36120.c: In function `vbi_read':
drivers/media/video/zr36120.c:1722: error: invalid type argument of
`unary *'
drivers/media/video/zr36120.c:1722: error: invalid type argument of
`unary *'
drivers/media/video/zr36120.c:1722: warning: type defaults to `int' in
declaration of `
type name'
drivers/media/video/zr36120.c:1722: error: invalid type argument of
`unary *'
drivers/media/video/zr36120.c:1722: warning: type defaults to `int' in
declaration of `
type name'
drivers/media/video/zr36120.c:1722: error: invalid type argument of
`unary *'
drivers/media/video/zr36120.c:1722: warning: type defaults to `int' in
declaration of `type name'
drivers/media/video/zr36120.c:1722: error: invalid type argument of
`unary *'
drivers/media/video/zr36120.c:1722: error: invalid type argument of
`unary *'
drivers/media/video/zr36120.c:1722: warning: type defaults to `int' in
declaration of `type name'
drivers/media/video/zr36120.c:1722: warning: type defaults to `int' in
declaration of `type name'
drivers/media/video/zr36120.c: At top level:
drivers/media/video/zr36120.c:1821: error: unknown field `open'
specified in initia
lizer
drivers/media/video/zr36120.c:1821: warning: initialization makes
integer from pointer without a cast
drivers/media/video/zr36120.c:1822: error: unknown field `close'
specified in initializer
drivers/media/video/zr36120.c:1822: warning: initialization from
incompatible pointer type
drivers/media/video/zr36120.c:1823: error: unknown field `read'
specified in initializer
drivers/media/video/zr36120.c:1823: warning: initialization from
incompatible pointer type
drivers/media/video/zr36120.c:1824: error: unknown field `write'
specified in initializer
drivers/media/video/zr36120.c:1824: warning: initialization from
incompatible pointer type
drivers/media/video/zr36120.c:1825: error: unknown field `poll'
specified in initializer
drivers/media/video/zr36120.c:1826: error: unknown field `ioctl'
specified in initializer
drivers/media/video/zr36120.c:1826: warning: initialization makes
integer from pointer without a cast
drivers/media/video/zr36120.c: In function `find_zoran':
drivers/media/video/zr36120.c:1861: warning: implicit declaration of
function `request_irq'
drivers/media/video/zr36120.c: In function `init_zoran':
drivers/media/video/zr36120.c:2001: warning: implicit declaration of
function `i2c_register_bus'
drivers/media/video/zr36120.c: In function `release_zoran':
drivers/media/video/zr36120.c:2032: warning: implicit declaration of
function `free_irq'
drivers/media/video/zr36120.c:2035: warning: implicit declaration of
function`i2c_unregister_bus'
make[3]: ** [drivers/media/video/zr36120.o] Erro 1

