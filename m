Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135461AbRDMKQx>; Fri, 13 Apr 2001 06:16:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135462AbRDMKQo>; Fri, 13 Apr 2001 06:16:44 -0400
Received: from slimnet.xs4all.nl ([194.109.194.192]:4871 "EHLO gatekeeper.slim")
	by vger.kernel.org with ESMTP id <S135461AbRDMKQe>;
	Fri, 13 Apr 2001 06:16:34 -0400
Message-ID: <3AD6D31C.E00CE2DD@inter.nl.net>
Date: Fri, 13 Apr 2001 12:21:16 +0200
From: Jurgen Kramer <GTM.Kramer@inter.nl.net>
X-Mailer: Mozilla 4.76 [en] (Win95; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Yokota Hiroshi <yokota@netlab.is.tsukuba.ac.jp>
CC: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Can't mount 2048 hardware sectors SCSI disk
In-Reply-To: <20010413185816C.yokota@netlab.is.tsukuba.ac.jp>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I reported the same problem a while ago. The suggestion was to stick to 2.2.19 for
the time being. 2048 byte/sector support is broken in 2.4.

Yokota Hiroshi wrote:

> [1.] One line summary of the problem: Can't mount 2048 hardware sectors SCSI disk on 2.4 kernel.
>
> [2.] Full description of the problem/report:
>  I have SCSI optical disk drive. It's supports 512 and 2048 bytes hardware
> sectors media.
>
>  In 2.2.19 kernel, I can use both 512/2048 hardware sectors media.
>
>  In 2.4.3 kernel, I can mount 512 bytes hardware sector media correctly,
> but I can't mount MSDOS/VFAT/UMSDOS/HFS filesystem in 2048 bytes hardware
> sectors media (reports "wrong fs type"). But I can use dd/mtools/hfstools
> correctory .
>
>  I tested "Workbit NinjaSCSI-3" and "Adaptec APA-1480" SCSI host adapter.
> Both of them reports same error.
>
>  I turns on "CONFIG_SCSI_LOGGING" option to debug.
>
>  Log reports SCSI disk driver (linux/drivers/scsi/sd.c) wants to read
> non-existant sector. (set very big sector number to SCSI packet)
>
>  I think something wrong in SCSI driver or filesystem driver in 2.4 kernel.
>
> [3.] Keywords (i.e., modules, networking, kernel): SCSI disk
>
> [4.] Kernel version (from /proc/version): 2.4.3
>
> ---
> YOKOTA Hiroshi
> E-mail: yokota@netlab.is.tsukuba.ac.jp
> WWW:    http://www.netlab.is.tsukuba.ac.jp/~yokota/
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

