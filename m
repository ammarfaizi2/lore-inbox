Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286692AbSAUOQM>; Mon, 21 Jan 2002 09:16:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286712AbSAUOPx>; Mon, 21 Jan 2002 09:15:53 -0500
Received: from mail2.infineon.com ([192.35.17.230]:7330 "EHLO
	mail2.infineon.com") by vger.kernel.org with ESMTP
	id <S286692AbSAUOPp> convert rfc822-to-8bit; Mon, 21 Jan 2002 09:15:45 -0500
X-Envelope-Sender-Is: Erez.Doron@savan.com (at relayer mail2.infineon.com)
Subject: Re: non volatile ram disk
From: Erez Doron <erez@savan.com>
To: Erez Doron <erez@savan.com>
Cc: Peter =?ISO-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>,
        linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1011620576.2978.0.camel@hal.savan.com>
In-Reply-To: <1011618928.2825.5.camel@hal.savan.com> 
	<3C4C1A96.3504174D@loewe-komp.de>  <1011620576.2978.0.camel@hal.savan.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution/1.0 (Preview Release)
Date: 21 Jan 2002 16:10:06 +0200
Message-Id: <1011622206.2978.3.camel@hal.savan.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

the exact log i get:

Creating 3 MTD partitions on "SA1100 flash":      
0x00000000-0x00040000 : "bootldr"
mtd: Giving out device 0 to bootldr 
0x00040000-0x02000000 : "root" 
mtd: Giving out device 1 to root 
0xc2000000-0xc4000000 : "rd" 
mtd: partition "rd" is out of reach -- disabled


notes:
1. the flash is at physical adress 0-0x1ffffff (32mb)
2. the ram is at physical adress 0xc0000000-0xc3ffffff
i tried to map an mtd device to the second part of the ram, but got
"partition is out of reach"

any idea ?

On Mon, 2002-01-21 at 15:42, Erez Doron wrote:
> hi
> 
> thanks for replying,
> 
> I already tried to map an MTD to physical memory, but got an error and
> an mtd with size 0
> 
> dou you know why ?
> 
> regards
> erez
> 
> On Mon, 2002-01-21 at 15:41, Peter Wächtler wrote:
> > Erez Doron schrieb:
> > > 
> > > hi
> > > 
> > > I'm looking for a way to make a ramdisk which is not erased on reboot
> > > this is for use with ipaq/linux.
> > > 
> > > i tought of booting with mem=32m and map a block device to the rest of
> > > the 32M ram i have.
> > > 
> > > the probelm is that giving mem=32m to the kernel will cause the kernel
> > > to map only the first 32m of physical memory to virtual one, so using
> > > __pa(ptr) on the top 32m causes a kernel oops.
> > > 
> > > any idea ?
> > > 
> > 
> > a MTD is the way to go, which uses the "reserved" mem area. 
> > I assume that the RAM is battery backed
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

