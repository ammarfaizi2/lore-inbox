Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273724AbRI0R1L>; Thu, 27 Sep 2001 13:27:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273721AbRI0R0u>; Thu, 27 Sep 2001 13:26:50 -0400
Received: from pblx.net ([64.167.128.182]:47371 "HELO dobie.pblx.net")
	by vger.kernel.org with SMTP id <S273719AbRI0R0n>;
	Thu, 27 Sep 2001 13:26:43 -0400
X-Mailer: XFMail 1.5.0 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <01092712025100.01050@dpd16>
Date: Thu, 27 Sep 2001 10:27:09 -0700 (PDT)
From: shewp <shewp@pblx.net>
To: Andre Margis <andre@sam.com.br>
Subject: RE: Kernel 2.4.10 /proc/partitions
Cc: linux-kernel@vger.kernel.org
Message-Id: <20010927172650Z273719-760+17695@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I also have this problem as mentioned before.

The problem cropped up between 2.4.10-pre5 and 2.4.10-pre6, 
I did some checking. pre5 is fine, pre6 is broken.

>From what I saw, my guess is that
genhd.c and the gendisk rewrites might be related.

Unfortunately have no time to look at it until mid-October-
any help appreciated. 

cheers


On 27-Sep-2001 Andre Margis wrote:
> 
> 
> 
> I'm testing Linux Kernel 2.4.10. I have a Dell 8450 with 8xP-III 700Mhz, 
> 10GBytes RAM, with megaraid PERC 3/DC. I have one logic disk (sda) with 4 
> partitions (sd1, sd2, sd3, sd4). After boot, my /proc/partitions has this 
> values:
> 
> 
> 
>  major minor  #blocks  name
> 
>    8     0   17692672 sda
>    8     1      32098 sda1
>    8     2      32130 sda2
>    8     3    4096575 sda3
>    8     4   13526730 sda4
>    8     0   17692672 sda
>    8     1      32098 sda1
>    8     2      32130 sda2
>    8     3    4096575 sda3
>    8     4   13526730 sda4
>    8     0   17692672 sda
>    8     1      32098 sda1
>    8     2      32130 sda2
>    8     3    4096575 sda3
>    8     4   13526730 sda4
>    8     0   17692672 sda
>    8     1      32098 sda1
>    8     2      32130 sda2
>    8     3    4096575 sda3
>    8     4   13526730 sda4
> 
> the cat command never stop to list.
> 
> 
> 
> What's happen?
> 
> 
> 
> 
> Thank's
> 
> 
> Andre
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

