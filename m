Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261232AbVFASzR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261232AbVFASzR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 14:55:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261253AbVFASyb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 14:54:31 -0400
Received: from rproxy.gmail.com ([64.233.170.195]:26801 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261232AbVFASty convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 14:49:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=l4Dcs23mWNYzCpyBbpSQaAgUOl67vIQ7qiBTkgKftG93fYng5EWMJVKiZjUdrIzKbmSdCEbmeMOgh/SWLctznfSJPsYDGqFiUDX9PyW0HEtXXz5aRFLTQ08wn7rNoEBBuexI58eQuCWE/VgsIwR2lAvhZW8o7XsWV8AXR8xwDQg=
Message-ID: <a728f9f905060111492301462@mail.gmail.com>
Date: Wed, 1 Jun 2005 14:49:54 -0400
From: Alex Deucher <alexdeucher@gmail.com>
Reply-To: Alex Deucher <alexdeucher@gmail.com>
To: Linux and Kernel Video <video4linux-list@redhat.com>
Subject: Re: Problem compiling zr36120 on kernel2.6.12-r5-mm2
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <429DC137.30705@brturbo.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <429DC137.30705@brturbo.com.br>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The zoran stuff is supported by another project with their own source
tree.  It may make sense to merge their latest code into v4l cvs, but
I don't know how they feel about that.  The same can be said for the
ivtv stuff and other assorted v4l projects.

Alex

On 6/1/05, Mauro Carvalho Chehab <mchehab@brturbo.com.br> wrote:
> Andrew,
> 
>     Trying to compile all multimedia video devices on kernel
> 2.6.12-r5-mm2 gives an error on zr36120.c. It looks like it uses an old
> i2c spec (it tries to include linux/i2c-old.h). It also includes tuner.h
> from wrong directory (it uses "tuner.h", instead <media/tuner.h>).
> 
>      One interesting thing is that this board is not present on
> video4linux CVS.
> 
> ------------------
> 
> CC [M]  drivers/media/video/zr36120.o
> In file included from drivers/media/video/zr36120.c:42:
> include/media/tuner.h:148: error: field `i2c' has incomplete type
> include/media/tuner.h:154: error: syntax error before "v4l2_std_id"
> include/media/tuner.h:154: warning: no semicolon at end of struct or union
> include/media/tuner.h:173: error: syntax error before '}' token
> In file included from drivers/media/video/zr36120.c:43:
> drivers/media/video/zr36120.h:29:27: linux/i2c-old.h: No such file or
> directory
> In file included from drivers/media/video/zr36120.c:43:
> drivers/media/video/zr36120.h:101: error: field `i2c' has incomplete type
> drivers/media/video/zr36120.c: In function `zoran_muxsel':
> drivers/media/video/zr36120.c:389: warning: implicit declaration of
> function `i2c_control_device'
> drivers/media/video/zr36120.c:389: error: `I2C_DRIVERID_VIDEODECODER'
> undeclared (first use in this function)
> drivers/media/video/zr36120.c:389: error: (Each undeclared identifier is
> reported only once
> drivers/media/video/zr36120.c:389: error: for each function it appears in.)
> drivers/media/video/zr36120.c: In function `zoran_common_open':
> drivers/media/video/zr36120.c:735: error: `I2C_DRIVERID_VIDEODECODER'
> undeclared (first use in this function)
> drivers/media/video/zr36120.c: In function `zoran_ioctl':
> drivers/media/video/zr36120.c:1159: error: `I2C_DRIVERID_VIDEODECODER'
> undeclared (first use in this function)
> drivers/media/video/zr36120.c:1432: error: `I2C_DRIVERID_TUNER'
> undeclared (first use
> in this function)
> drivers/media/video/zr36120.c: At top level:
> drivers/media/video/zr36120.c:1489: error: unknown field `open'
> specified in initia
> lizer
> drivers/media/video/zr36120.c:1489: warning: initialization makes
> integer from pointer without a cast
> drivers/media/video/zr36120.c:1490: error: unknown field `close'
> specified in initiali
> zer
> drivers/media/video/zr36120.c:1490: warning: initialization from
> incompatible pointer type
> drivers/media/video/zr36120.c:1491: error: unknown field `read'
> specified in initializ
> er
> drivers/media/video/zr36120.c:1491: warning: initialization from
> incompatible pointer type
> drivers/media/video/zr36120.c:1492: error: unknown field `write'
> specified in initiali
> zer
> drivers/media/video/zr36120.c:1492: warning: initialization from
> incompatible pointer type
> drivers/media/video/zr36120.c:1493: error: unknown field `poll'
> specified in initializ
> er
> drivers/media/video/zr36120.c:1494: error: unknown field `ioctl'
> specified in initiali
> zer
> drivers/media/video/zr36120.c:1494: warning: initialization makes
> integer from pointer without a cast
> drivers/media/video/zr36120.c:1495: error: unknown field `mmap'
> specified in initializ
> er
> drivers/media/video/zr36120.c:1495: warning: missing braces around
> initializer
> drivers/media/video/zr36120.c:1495: warning: (near initialization for
> `zr36120_template.lock
> ')
> drivers/media/video/zr36120.c:1495: warning: initialization makes
> integer from pointer without a cast
> drivers/media/video/zr36120.c: In function `vbi_read':
> drivers/media/video/zr36120.c:1722: error: invalid type argument of
> `unary *'
> drivers/media/video/zr36120.c:1722: error: invalid type argument of
> `unary *'
> drivers/media/video/zr36120.c:1722: warning: type defaults to `int' in
> declaration of `
> type name'
> drivers/media/video/zr36120.c:1722: error: invalid type argument of
> `unary *'
> drivers/media/video/zr36120.c:1722: warning: type defaults to `int' in
> declaration of `
> type name'
> drivers/media/video/zr36120.c:1722: error: invalid type argument of
> `unary *'
> drivers/media/video/zr36120.c:1722: warning: type defaults to `int' in
> declaration of `type name'
> drivers/media/video/zr36120.c:1722: error: invalid type argument of
> `unary *'
> drivers/media/video/zr36120.c:1722: error: invalid type argument of
> `unary *'
> drivers/media/video/zr36120.c:1722: warning: type defaults to `int' in
> declaration of `type name'
> drivers/media/video/zr36120.c:1722: warning: type defaults to `int' in
> declaration of `type name'
> drivers/media/video/zr36120.c: At top level:
> drivers/media/video/zr36120.c:1821: error: unknown field `open'
> specified in initia
> lizer
> drivers/media/video/zr36120.c:1821: warning: initialization makes
> integer from pointer without a cast
> drivers/media/video/zr36120.c:1822: error: unknown field `close'
> specified in initializer
> drivers/media/video/zr36120.c:1822: warning: initialization from
> incompatible pointer type
> drivers/media/video/zr36120.c:1823: error: unknown field `read'
> specified in initializer
> drivers/media/video/zr36120.c:1823: warning: initialization from
> incompatible pointer type
> drivers/media/video/zr36120.c:1824: error: unknown field `write'
> specified in initializer
> drivers/media/video/zr36120.c:1824: warning: initialization from
> incompatible pointer type
> drivers/media/video/zr36120.c:1825: error: unknown field `poll'
> specified in initializer
> drivers/media/video/zr36120.c:1826: error: unknown field `ioctl'
> specified in initializer
> drivers/media/video/zr36120.c:1826: warning: initialization makes
> integer from pointer without a cast
> drivers/media/video/zr36120.c: In function `find_zoran':
> drivers/media/video/zr36120.c:1861: warning: implicit declaration of
> function `request_irq'
> drivers/media/video/zr36120.c: In function `init_zoran':
> drivers/media/video/zr36120.c:2001: warning: implicit declaration of
> function `i2c_register_bus'
> drivers/media/video/zr36120.c: In function `release_zoran':
> drivers/media/video/zr36120.c:2032: warning: implicit declaration of
> function `free_irq'
> drivers/media/video/zr36120.c:2035: warning: implicit declaration of
> function`i2c_unregister_bus'
> make[3]: ** [drivers/media/video/zr36120.o] Erro 1
> 
> --
> video4linux-list mailing list
> Unsubscribe mailto:video4linux-list-request@redhat.com?subject=unsubscribe
> https://www.redhat.com/mailman/listinfo/video4linux-list
>
