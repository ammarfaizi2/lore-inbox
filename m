Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314082AbSE2Uif>; Wed, 29 May 2002 16:38:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315468AbSE2Uie>; Wed, 29 May 2002 16:38:34 -0400
Received: from zeke.inet.com ([199.171.211.198]:19630 "EHLO zeke.inet.com")
	by vger.kernel.org with ESMTP id <S314082AbSE2Uib>;
	Wed, 29 May 2002 16:38:31 -0400
Message-ID: <3CF53C45.3000606@inet.com>
Date: Wed, 29 May 2002 15:38:29 -0500
From: Eli Carter <eli.carter@inet.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc2) Gecko/20020510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk@arm.linux.org.uk>
CC: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.19
In-Reply-To: <Pine.LNX.4.33.0205291146510.1344-100000@penguin.transmeta.com> <20020529211702.E30585@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> The following change appeared in 2.5.19:
> 
> xx- a/drivers/video/cyber2000fb.c       Wed May 29 11:43:02 2002
> xx+ b/drivers/video/cyber2000fb.c       Wed May 29 11:43:02 2002
> @@ -1729,9 +1729,8 @@
>  }
> 
>  static struct pci_device_id cyberpro_pci_table[] __devinitdata = {
> -// Not yet
> -//     { PCI_VENDOR_ID_INTERG, PCI_DEVICE_ID_INTERG_1682,
> -//             PCI_ANY_ID, PCI_ANY_ID, 0, 0, ID_IGA_1682 },
> +       { PCI_VENDOR_ID_INTERG, PCI_DEVICE_ID_INTERG_1682,
> +               PCI_ANY_ID, PCI_ANY_ID, 0, 0, ID_IGA_1682 },
>         { PCI_VENDOR_ID_INTERG, PCI_DEVICE_ID_INTERG_2000,
>                 PCI_ANY_ID, PCI_ANY_ID, 0, 0, ID_CYBERPRO_2000 },
>         { PCI_VENDOR_ID_INTERG, PCI_DEVICE_ID_INTERG_2010,
> 
> This is completely wrong - the driver has been tested NOT to work on
> the Integraphics 1682.  As such, please do uncomment these lines.
> 
> In addition, I'm disappointed that no one forwarded the patch for
> maintainer approval PRIOR to submitting it to Linus.
> 
> Linus, I request that you apply the following patch.  Thanks.
> 
> --- orig/drivers/video/cyber2000fb.c	Mon May  6 16:54:10 2002
> +++ linux/drivers/video/cyber2000fb.c	Mon May 13 10:48:13 2002
> @@ -1729,8 +1729,9 @@
>  }
>  
>  static struct pci_device_id cyberpro_pci_table[] __devinitdata = {
> -	{ PCI_VENDOR_ID_INTERG, PCI_DEVICE_ID_INTERG_1682,
> -		PCI_ANY_ID, PCI_ANY_ID, 0, 0, ID_IGA_1682 },
> +// Not yet
> +//	{ PCI_VENDOR_ID_INTERG, PCI_DEVICE_ID_INTERG_1682,
> +//		PCI_ANY_ID, PCI_ANY_ID, 0, 0, ID_IGA_1682 },
>  	{ PCI_VENDOR_ID_INTERG, PCI_DEVICE_ID_INTERG_2000,
>  		PCI_ANY_ID, PCI_ANY_ID, 0, 0, ID_CYBERPRO_2000 },
>  	{ PCI_VENDOR_ID_INTERG, PCI_DEVICE_ID_INTERG_2010,
> 
> 

How about s/Not yet/This driver has been tested NOT to work on the 
Integraphics 1682.  Do not enable with out contacting the maintainer./
instead?  That might avoid the problem recurring...

Just a thought, ignore if you wish.

Eli
--------------------. "If it ain't broke now,
Eli Carter           \                  it will be soon." -- crypto-gram
eli.carter(a)inet.com `-------------------------------------------------

