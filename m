Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267504AbTACL17>; Fri, 3 Jan 2003 06:27:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267505AbTACL17>; Fri, 3 Jan 2003 06:27:59 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:12173
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267504AbTACL16>; Fri, 3 Jan 2003 06:27:58 -0500
Subject: Re: Linux v2.5.54
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: SZALAY Attila <sasa@pheniscidae.tvnetwork.hu>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030103110418.GD7661@sasa.home>
References: <20030102103422.GB24116@sasa.home>
	<Pine.LNX.4.33L2.0301020745260.22868-100000@dragon.pdx.osdl.net>
	<20030103093250.GC7661@sasa.home>  <20030103110418.GD7661@sasa.home>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 03 Jan 2003 12:19:08 +0000
Message-Id: <1041596348.27024.16.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-01-03 at 11:04, SZALAY Attila wrote:
> Now I unset I2O completely to try compile new kernel.
> 
> But I have another problem.
> 
> make -f scripts/Makefile.build obj=drivers/scsi/pcmcia
>   gcc -Wp,-MD,drivers/scsi/pcmcia/.aha152x_stub.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -Iinclude/asm-i386/mach-default -fomit-frame-pointer -nostdinc -iwithprefix include -DMODULE   -DKBUILD_BASENAME=aha152x_stub -DKBUILD_MODNAME=aha152x_cs   -c -o drivers/scsi/pcmcia/aha152x_stub.o drivers/scsi/pcmcia/aha152x_stub.c
> make[4]: *** No rule to make target `drivers/scsi/pcmcia/aha152x.s', needed by `drivers/scsi/pcmcia/aha152x.o'.  Stop.
>
The pcmcia scsi makefiles are broken. Its been reported repeatedly to
the folks who broke the makefiles but nobody has fixed it. I have a hack
for this but its versus 2.5.49/2.5.50

Alan
