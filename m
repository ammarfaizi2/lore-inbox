Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317326AbSFLVUI>; Wed, 12 Jun 2002 17:20:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317332AbSFLVUH>; Wed, 12 Jun 2002 17:20:07 -0400
Received: from host.greatconnect.com ([209.239.40.135]:48652 "EHLO
	host.greatconnect.com") by vger.kernel.org with ESMTP
	id <S317326AbSFLVUH>; Wed, 12 Jun 2002 17:20:07 -0400
Subject: Re: PROBLEM: Kernel 2.4.18 Promise driver (IDE) hangs @ boot with
	Promise 20267
From: Samuel Flory <sflory@rackable.com>
To: Braden McGrath <bwm3@po.cwru.edu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <006901c2124a$9cb2ab30$ceaa1681@z>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 12 Jun 2002 07:19:38 -0700
Message-Id: <1023891585.8847.181.camel@flory.corp.rackablelabs.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  You might try Alan Cox's ac kernel.  2.4.19pre10ac2 seems to work bit
better on the Promise controllers for me.  You will need to patch in
2.4.19pre10, and then 2.4.19pre10ac2.

http://www.us.kernel.org/pub/linux/kernel/v2.4/testing/
http://www.us.kernel.org/pub/linux/kernel/people/alan/linux-2.4/2.4.19/


PS- What of the PDC options are you using?  I generally enable the
following:
CONFIG_BLK_DEV_PDC202XX=y
CONFIG_PDC202XX_BURST=y
CONFIG_PDC202XX_FORCE=y

  If CONFIG_PDC202XX_BURST is on try turning it off.  Or in the case of
the the reverse turn it on.

On Wed, 2002-06-12 at 12:51, Braden McGrath wrote:
> Uniform Multi-Platform E-IDE driver Revision: 6.31
> ...<snip>...

FYI-  The part right here is fairly important as it tells us what
chipset you are using, and bios settings.

> hda: Maxtor 91024U4, ATA DISK drive
> hdc: TOSHIBA DVD-ROM SD-M1212, ATAPI CD/DVD-ROM drive
> hde: Maxtor 91366U4, ATA DISK drive
> hdf: Maxtor 52049U4, ATA DISK drive
> hdg: Maxtor 93073U6, ATA DISK drive
> hdh: MAXTOR 4K080H4, ATA DISK drive
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> ide1 at 0x170-0x177,0x376 on irq 15
> ide2 at 0x9400-0x9407,0x9802 on irq 7
> ide3 at 0x9c00-0x9c07,0xa002 on irq 7
> hda: 19999728 sectors (10240 MB) w/2048KiB Cache, CHS=1244/255/63,
> UDMA(33)
> ***[HANG]***
> 


