Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310440AbSCBU14>; Sat, 2 Mar 2002 15:27:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310441AbSCBU1v>; Sat, 2 Mar 2002 15:27:51 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:28420 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S310440AbSCBU1e>; Sat, 2 Mar 2002 15:27:34 -0500
Subject: Re: 2.4.19-pre2 compile bug
To: greearb@candelatech.com (Ben Greear)
Date: Sat, 2 Mar 2002 20:42:03 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (linux-kernel)
In-Reply-To: <3C813400.8080001@candelatech.com> from "Ben Greear" at Mar 02, 2002 01:20:16 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16hGKS-0008N2-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> gcc -D__KERNEL__ -I/home/greear/kernel/2.4/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -DMODULE -DMODVERSIONS -include /home/greear/kernel/2.4/linux/include/linux/modversions.h  -DKBUILD_BASENAME=cciss  -c -o cciss.o cciss.c
> cciss.c: In function `cciss_remove_one':
> cciss.c:2129: too few arguments to function `sendcmd'

Fixed in -ac2 - there is a NULL) missing off the end of that one it seems
