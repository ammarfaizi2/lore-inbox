Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316430AbSFDSrO>; Tue, 4 Jun 2002 14:47:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316538AbSFDSrN>; Tue, 4 Jun 2002 14:47:13 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:41171 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S316430AbSFDSqz>;
	Tue, 4 Jun 2002 14:46:55 -0400
Date: Tue, 4 Jun 2002 11:46:35 -0700
From: Patrick Mansfield <patmans@us.ibm.com>
To: Miles Lane <miles@megapathdsl.net>
Cc: linux-kernel@vger.kernel.org, davej@suse.de
Subject: Re: 2.5.20-dj2 -- fdomain_stub.c:98: unknown field `abort' specified in initializer
Message-ID: <20020604114635.A26099@eng2.beaverton.ibm.com>
In-Reply-To: <1023216140.20264.29.camel@agate>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 04, 2002 at 11:42:18AM -0700, Miles Lane wrote:
> gcc -D__KERNEL__ -I/usr/src/linux-2.5/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 -DMODULE   -DKBUILD_BASENAME=fdomain_stub  -c -o fdomain_stub.o fdomain_stub.c
> fdomain_stub.c:98: unknown field `abort' specified in initializer
> fdomain_stub.c:98: warning: initialization from incompatible pointer type
> fdomain_stub.c:98: unknown field `reset' specified in initializer
> fdomain_stub.c:98: warning: initialization from incompatible pointer type
> make[3]: *** [fdomain_stub.o] Error 1
> make[3]: Leaving directory `/usr/src/linux-2.5/drivers/scsi/pcmcia'

You should be able to compile it by setting the 
CONFIG_BROKEN_SCSI_ERROR_HANDLING config option.

-- Patrick Mansfield
