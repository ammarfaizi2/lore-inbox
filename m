Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291393AbSBHED5>; Thu, 7 Feb 2002 23:03:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291397AbSBHEDt>; Thu, 7 Feb 2002 23:03:49 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:15877
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S291393AbSBHEDc>; Thu, 7 Feb 2002 23:03:32 -0500
Date: Thu, 7 Feb 2002 19:54:09 -0800 (PST)
From: Andre Hedrick <andre@linuxdiskcert.org>
To: John Weber <weber@nyc.rr.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: linux 2.5.4-pre3 and IDE changes
In-Reply-To: <3C634346.1010405@nyc.rr.com>
Message-ID: <Pine.LNX.4.10.10202071953330.15165-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I repeat that is a diagnostic layer and is to never be called from the
kernel, it is a user-space only and will go away.

On Thu, 7 Feb 2002, John Weber wrote:

> The address member of struct scatterlist appears to have been changed to 
> dma_address.
> 
> A simple s/\.address/\.dma_address/ should fix this compile error.
> 
> ide-dma.c: In function `ide_raw_build_sglist':
> ide-dma.c:269: structure has no member named `address'
> ide-dma.c:276: structure has no member named `address'
> make[3]: *** [ide-dma.o] Error 1
> make[3]: Leaving directory `/usr/src/linux-2.5.4/drivers/ide'
> make[2]: *** [first_rule] Error 2
> make[2]: Leaving directory `/usr/src/linux-2.5.4/drivers/ide'
> make[1]: *** [_subdir_ide] Error 2
> make[1]: Leaving directory `/usr/src/linux-2.5.4/drivers'
> make: *** [_dir_drivers] Error 2
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andre Hedrick
Linux Disk Certification Project                Linux ATA Development

