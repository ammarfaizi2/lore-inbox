Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265880AbSKBE5d>; Fri, 1 Nov 2002 23:57:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265883AbSKBE5d>; Fri, 1 Nov 2002 23:57:33 -0500
Received: from mail.michigannet.com ([208.49.116.30]:17418 "EHLO
	member.michigannet.com") by vger.kernel.org with ESMTP
	id <S265880AbSKBE5c>; Fri, 1 Nov 2002 23:57:32 -0500
Date: Sat, 2 Nov 2002 00:03:53 -0500
From: Paul <set@pobox.com>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] [PATCH] Linux-2.5.45-mcp2
Message-ID: <20021102050353.GJ7170@squish.home.loc>
Mail-Followup-To: Paul <set@pobox.com>,
	Marc-Christian Petersen <m.c.p@wolk-project.de>,
	linux-kernel@vger.kernel.org
References: <200211020255.05597.m.c.p@wolk-project.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200211020255.05597.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc-Christian Petersen <m.c.p@wolk-project.de>, on Sat Nov 02, 2002 [02:55:05 AM] said:
> Hi there,
> 
> point me to/send me the fixes/patches you want to see in here please!
> 
> here we go, -mcp2 for 2.5.45 vanilla.
> 
> 

	Hi;

  gcc -Wp,-MD,drivers/md/.dm-ioctl.o.d -D__KERNEL__
-Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2
-fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe
-mpreferred-stack-boundary=2 -march=k6 -Iarch/i386/mach-generic
-nostdinc -iwithprefix include    -DKBUILD_BASENAME=dm_ioctl   -c
-o drivers/md/dm-ioctl.o drivers/md/dm-ioctl.c
drivers/md/dm-ioctl.c: In function `create':
drivers/md/dm-ioctl.c:588: incompatible type for argument 1 of
`set_device_ro'
drivers/md/dm-ioctl.c: In function `reload':
drivers/md/dm-ioctl.c:874: incompatible type for argument 1 of
`set_device_ro'
make[2]: *** [drivers/md/dm-ioctl.o] Error 1
make[1]: *** [drivers/md] Error 2
make: *** [drivers] Error 2

	This looks similar to the error I got with 2.5.45
virgin. (was hoping device mapper fixes would make it go away)

Paul
set@pobox.com
