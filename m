Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271505AbRHPGsb>; Thu, 16 Aug 2001 02:48:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271506AbRHPGsW>; Thu, 16 Aug 2001 02:48:22 -0400
Received: from fe090.worldonline.dk ([212.54.64.152]:26633 "HELO
	fe090.worldonline.dk") by vger.kernel.org with SMTP
	id <S271505AbRHPGsG>; Thu, 16 Aug 2001 02:48:06 -0400
Date: Thu, 16 Aug 2001 08:50:25 +0200
From: Jens Axboe <axboe@suse.de>
To: Hisaaki Shibata <shibata@luky.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 4.7GB DVD-RAM geometry wrong?
Message-ID: <20010816085025.M4352@suse.de>
In-Reply-To: <20010815111030Z271139-761+1405@vger.kernel.org> <20010815131733.I545@suse.de> <20010815233424P.shibata@luky.org> <20010816114439K.shibata@luky.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010816114439K.shibata@luky.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 16 2001, Hisaaki Shibata wrote:
> Hi again.
> 
> > > > I have a Panasonic DVD-RAM, LF-D201 (SCSI 4.7/9.4GB).  I put in a
> > > > 4.7GB type II cartridge (that's a single-sided disk), did 'mkfs 
> > > > /dev/scd0' and then mounted it, and ... I have a 2.2GB disk!
> > 
> > Almost the same problem here w/ 5.2GB HITACHI DVD-RAM Drive, GF-2050.
> 
> Sorry, My 5.2GB SCSI DVD-RAM drive's correct name is GF-1050.
> 
> > > Attached patch should fix it, Linus please apply.
> > 
> > The patch with 2.4.8-ac5 fixed my problem.
> 
> The geometry problem is sloved.

Good

> But other problem has come with 4.7GB(9.4GB) ATAPI(IDE) DVD-RAM drive
> named HITACHI GF-2000.
> 
> Here is my dmesg.
> While I did "cp -auv DIR/ /mnt/floppy/", segv has happend.
> file system on DVD-RAM is UDF.

Please run that through ksymoops, the trace is worthless without it. See
below.

> Warning only 896MB will be used.
> Use a HIGHMEM enabled kernel.

Hint :-)

> invalid operand: 0000
> CPU:    0
> EIP:    0010:[<c01440f8>]
> EFLAGS: 00010202
> eax: ffffffff   ebx: d26f53a0   ecx: d26f53a0   edx: 00000001
> esi: fad31120   edi: de1c96c0   ebp: d26f53a0   esp: de159e60
> ds: 0018   es: 0018   ss: 0018
> Process cp (pid: 930, stackpage=de159000)
> Stack: d26f53a0 de159ed4 fad272e3 d26f53a0 fffffffb f7cd6000 c0143d97 00000000 
>        f5dbe8a0 de1c96c0 de159f8c 00000000 fad2651d f5dbe8a0 f5dbe8a0 00000000 
>        c1f22700 00020101 000100a8 00349be2 000c8066 1b000001 00000800 000c82c9 
> Call Trace: [<fad272e3>] [<c0143d97>] [<fad2651d>] [<c013b585>] [<c013b41a>] 
>    [<c013b70c>] [<c0130113>] [<c0130026>] [<c0130314>] [<c0106ccb>] 
> 
> Code: 0f 0b e9 86 00 00 00 90 39 1b 74 3c f6 83 08 01 00 00 0f 75 

This part.

-- 
Jens Axboe

