Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317521AbSFEBAk>; Tue, 4 Jun 2002 21:00:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317523AbSFEBAj>; Tue, 4 Jun 2002 21:00:39 -0400
Received: from front2.mail.megapathdsl.net ([66.80.60.30]:65041 "EHLO
	front2.mail.megapathdsl.net") by vger.kernel.org with ESMTP
	id <S317521AbSFEBAj>; Tue, 4 Jun 2002 21:00:39 -0400
Subject: Re: 2.5.20-dj2 -- fdomain_stub.c:98: unknown field `abort'
	specified in initializer
From: Miles Lane <miles@megapathdsl.net>
To: Patrick Mansfield <patmans@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, davej@suse.de
In-Reply-To: <20020604114635.A26099@eng2.beaverton.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5.99 
Date: 04 Jun 2002 18:21:16 -0700
Message-Id: <1023240078.20260.307.camel@agate>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-06-04 at 11:46, Patrick Mansfield wrote:
> On Tue, Jun 04, 2002 at 11:42:18AM -0700, Miles Lane wrote:
> > gcc -D__KERNEL__ -I/usr/src/linux-2.5/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 -DMODULE   -DKBUILD_BASENAME=fdomain_stub  -c -o fdomain_stub.o fdomain_stub.c
> > fdomain_stub.c:98: unknown field `abort' specified in initializer
> > fdomain_stub.c:98: warning: initialization from incompatible pointer type
> > fdomain_stub.c:98: unknown field `reset' specified in initializer
> > fdomain_stub.c:98: warning: initialization from incompatible pointer type
> > make[3]: *** [fdomain_stub.o] Error 1
> > make[3]: Leaving directory `/usr/src/linux-2.5/drivers/scsi/pcmcia'
> 
> You should be able to compile it by setting the 
> CONFIG_BROKEN_SCSI_ERROR_HANDLING config option.

Thanks Patrick,

The compile still breaks with that option enabled,
but it looks like that driver still hasn't been 
ported to the current 2.5 api.

../fdomain.c: In function `do_fdomain_16x0_intr':
../fdomain.c:1568: structure has no member named `address'
../fdomain.c:1601: structure has no member named `address'
../fdomain.c: In function `fdomain_16x0_queue':
../fdomain.c:1687: structure has no member named `address'


