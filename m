Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315634AbSFEU7K>; Wed, 5 Jun 2002 16:59:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315469AbSFEU5m>; Wed, 5 Jun 2002 16:57:42 -0400
Received: from quake.mweb.co.za ([196.2.45.76]:14214 "EHLO quake.mweb.co.za")
	by vger.kernel.org with ESMTP id <S314422AbSFEU5S>;
	Wed, 5 Jun 2002 16:57:18 -0400
Subject: Re: All In Wonder Radeon and bttv module
From: Bongani <bonganilinux@mweb.co.za>
To: "Salvatore D'Angelo" <dangelo.sasaman@tiscalinet.it>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3CFE1998.8000306@tiscalinet.it>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5-1mdk 
Date: 05 Jun 2002 22:57:55 +0200
Message-Id: <1023310680.2925.11.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Try adding something like this on your
/etc/modules.conf

alias	char-major-81	bttv
options	bttv 	radio=1 card=56
options	tuner	type=1

the card, radio and tuner values are in the linux
source tree under
/usr/src/linux/Documentation/video4linux/bttv/CARDLIST

If you don't have the kernel's source, let me know I'll
send you thta file

On Wed, 2002-06-05 at 16:00, Salvatore D'Angelo wrote:
> Hi all,
> 
> I tried to use kwintv on my desktop with All in Wonder ATI Radeon AGP.
> 
> I have compiled my kernel (2.4.18)  with almost all the video drivers 
> compiled as module. The problem is that I have tried to upload the 
> module bttv.o using the command
> 
>    modprobe bttv
> 
> and the following messages have  appeared:
> 
> /lib/modules/2.4.18-6mdk/kernel/drivers/media/video/bttv.o.gz: 
> init_module: No such device
> Hint: insmod errors can be caused by incorrect module parameters, 
> including invalid IO or IRQ parameters
> modprobe: insmod 
> /lib/modules/2.4.18-6mdk/kernel/drivers/media/video/bttv.o.gz failed
> modprobe: insmod bttv failed
> 
> Can anyone of you help me to understand what is the problem. I think 
> that the default IRQ and IO ports are not correct for my video board. If 
> so, is it possible have the correct one?
> 
> I have tried to search on the Web and in the Linux archives to check if 
> these type of errors
> have already been solved by someone else, but I haven't found anything.
> 
> Thanks in advance for your help.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


