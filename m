Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314681AbSE0JEd>; Mon, 27 May 2002 05:04:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314707AbSE0JEc>; Mon, 27 May 2002 05:04:32 -0400
Received: from [195.63.194.11] ([195.63.194.11]:62993 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S314681AbSE0JEc>; Mon, 27 May 2002 05:04:32 -0400
Message-ID: <3CF1E7C0.9090909@evision-ventures.com>
Date: Mon, 27 May 2002 10:01:04 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
CC: linux-kernel@vger.kernel.org
Subject: Re: [patch] Trivial: move PCI ID definitions from ide-pci.c to pci_ids.h
In-Reply-To: <20020526152204.A18812@ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Vojtech Pavlik napisa?:
> ChangeSet@1.585, 2002-05-26 15:19:41+02:00, vojtech@twilight.ucw.cz
>   This cset moves a PCI ID definition from ide-pci.c to
>   pci_ids.h where it belongs.
> 
> 
>  drivers/ide/ide-pci.c   |    6 +-----
>  include/linux/pci_ids.h |    4 ++++
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> 
> diff -Nru a/drivers/ide/ide-pci.c b/drivers/ide/ide-pci.c
> --- a/drivers/ide/ide-pci.c	Sun May 26 15:20:16 2002
> +++ b/drivers/ide/ide-pci.c	Sun May 26 15:20:16 2002
> @@ -27,10 +27,6 @@
>  
>  #include "pcihost.h"
>  
> -/* Missing PCI device IDs: */
> -#define PCI_VENDOR_ID_HINT 0x3388
> -#define PCI_DEVICE_ID_HINT 0x8013
> -
>  /*
>   * This is the list of registered PCI chipset driver data structures.
>   */
> @@ -756,7 +752,7 @@
>  	},
>  	{
>  		vendor: PCI_VENDOR_ID_HINT,
> -		device: PCI_DEVICE_ID_HINT,
> +		device: PCI_DEVICE_ID_HINT_VXPROII_IDE,
>  		bootable: ON_BOARD
>  	},
>  	{
> diff -Nru a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> --- a/include/linux/pci_ids.h	Sun May 26 15:20:16 2002
> +++ b/include/linux/pci_ids.h	Sun May 26 15:20:16 2002
> @@ -1787,3 +1787,7 @@
>  #define PCI_DEVICE_ID_MICROGATE_USC	0x0010
>  #define PCI_DEVICE_ID_MICROGATE_SCC	0x0020
>  #define PCI_DEVICE_ID_MICROGATE_SCA	0x0030
> +
> +#define PCI_VENDOR_ID_HINT		0x3388
> +#define PCI_DEVICE_ID_HINT_VXPROII_IDE	0x8013
> +

Please note that pci_ids.h. is a generated file. The ids have to be
moved to the ancestor of it as well.


