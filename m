Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261615AbREURYJ>; Mon, 21 May 2001 13:24:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261627AbREURX7>; Mon, 21 May 2001 13:23:59 -0400
Received: from 24.68.61.66.on.wave.home.com ([24.68.61.66]:25363 "HELO
	sh0n.net") by vger.kernel.org with SMTP id <S261615AbREURXq>;
	Mon, 21 May 2001 13:23:46 -0400
Date: Mon, 21 May 2001 13:24:10 -0400 (EDT)
From: Shawn Starr <spstarr@sh0n.net>
To: Allan Duncan <b372050@vus068.trl.telstra.com.au>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: compile failure in 2.4.5-pre4
In-Reply-To: <200105210638.QAA19887@vus068.trl.telstra.com.au>
Message-ID: <Pine.LNX.4.30.0105211321530.15779-100000@coredump.sh0n.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2
-fomit-frame-pointer -fno-strict-aliasing -pipe
-mpreferred-stack-boundary=2 -march=i586    -c -o ide-pci.o ide-pci.c
ide-pci.c: In function `ide_setup_pci_device':
ide-pci.c:712: parse error before `hwif'
make[3]: *** [ide-pci.o] Error 1

Yeah, same compile bug.

On Mon, 21 May 101, Allan Duncan wrote:

> This addition for 2.4.5-pre4 has caused a compile failure with a parsing error:
>
> drivers/ide/ide-pci.c:711
>     		if (!IDE_PCI_DEVID_EQ(d->devid, DEVID_CS5530)
>
> In my case CONFIG_BLK_DEV_CS5530 is not defined.
>
> --
> Allan Duncan  b372050@vus068.trl.telstra.com.au  (+613) 9253 6708, Fax 9253 6775
>      (We are just a number)
>  Next Generation Infrastructure Program - Transport Architecture Project
> Telstra Research Labs, Box 249 Rosebank MDC, Clayton, Victoria, 3169, Australia
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>

