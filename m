Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316912AbSFQSJe>; Mon, 17 Jun 2002 14:09:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316915AbSFQSJd>; Mon, 17 Jun 2002 14:09:33 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:46801 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S316912AbSFQSJc>; Mon, 17 Jun 2002 14:09:32 -0400
Date: Mon, 17 Jun 2002 13:09:30 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Toby Inkster <tobyink@goddamn.co.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: .i2c-old.ver.d: No such file or directory
In-Reply-To: <20020617190026.0c0f60b2.tobyink@goddamn.co.uk>
Message-ID: <Pine.LNX.4.44.0206171307100.22308-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jun 2002, Toby Inkster wrote:

> Below are the last few lines of output before the errors start. I can send my .config if anyone thinks it might help.
> 
>   	mkdir -p /usr/src/linux-2.5.22/include/linux/modules/drivers/media/video/; gcc -E -Wp,-MD,/usr/src/linux-2.5.22/include/linux/modules/drivers/media/video/.i2c-old.ver.d -D__KERNEL__ -I/usr/src/linux-2.5.22/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -nostdinc -iwithprefix include    -DKBUILD_BASENAME=i2c_old   i2c-old.c | /sbin/genksyms  -k 2.5.22 > /usr/src/linux-2.5.22/include/linux/modules/drivers/media/video/i2c-old.ver.tmp; if [ ! -r /usr/src/linux-2.5.22/include/linux/modules/drivers/media/video/i2c-old.ver ] || cmp -s /usr/src/linux-2.5.22/include/linux/modules/drivers/media/video/i2c-old.ver /usr/src/linux-2.5.22/include/linux/modules/drivers/media/video/i2c-old.ver.tmp; then touch /usr/src/linux-2.5.22/include/linux/modversions.h; fi; mv -f /usr/src/linux-2.5.22/include/linux/modules/drivers/media/video/i2c-old.ver.tmp /usr/src/linux-2.5.22/include/linu!
x/m
>  odules/drivers/media/video/i2c-old.ver
> i2c-old.c:17:27: linux/i2c-old.h: No such file or directory

The problem is that the i2c code is currently broken, it includes 
linux/i2c-old.h which doesn't exist. You'll see the error much more 
clearly if you run "make KBUILD_VERBOSE= dep" ;)

For now, you should disable I2C in your .config.

--Kai



