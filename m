Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316867AbSE1RzN>; Tue, 28 May 2002 13:55:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316868AbSE1RzM>; Tue, 28 May 2002 13:55:12 -0400
Received: from 12-224-36-73.client.attbi.com ([12.224.36.73]:3346 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S316867AbSE1RzL>;
	Tue, 28 May 2002 13:55:11 -0400
Date: Tue, 28 May 2002 10:53:58 -0700
From: Greg KH <greg@kroah.com>
To: "Jonathan B. Horen" <horen@mail.iucc.ac.il>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.18 Compile-time Error for Philips USB Video
Message-ID: <20020528175358.GF11993@kroah.com>
In-Reply-To: <3CF2700A.2090405@mail.iucc.ac.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Tue, 30 Apr 2002 16:43:25 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 27, 2002 at 08:42:34PM +0300, Jonathan B. Horen wrote:
> make[3]: Entering directory `/usr/src/linux-2.5.18/drivers/usb/media'
> gcc -D__KERNEL__ -I/usr/src/linux-2.5.18/include -Wall 
> -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer 
> -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 
> -march=i686    -DKBUILD_BASENAME=pwc_if  -c -o pwc-if.o pwc-if.c
> pwc-if.c: In function `pwc_isoc_init':
> pwc-if.c:818: structure has no member named `next'
> pwc-if.c: In function `pwc_isoc_cleanup':
> pwc-if.c:861: structure has no member named `next'

Known problem.  That field was removed from the struct urb in the USB
core.  The driver (and some other USB video drivers) needs to be fixed.
Patches are welcome :)

thanks,

greg k-h
