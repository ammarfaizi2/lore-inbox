Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129948AbRBYJIT>; Sun, 25 Feb 2001 04:08:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129949AbRBYJIK>; Sun, 25 Feb 2001 04:08:10 -0500
Received: from [200.222.195.191] ([200.222.195.191]:39300 "EHLO
	pervalidus.dyndns.org") by vger.kernel.org with ESMTP
	id <S129948AbRBYJIA>; Sun, 25 Feb 2001 04:08:00 -0500
Date: Sun, 25 Feb 2001 06:03:26 -0300
From: Frédéric L. W. Meunier <0@pervalidus.net>
To: jerry <jdinardo@ix.netcom.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: ide / usb problem
Message-ID: <20010225060326.K127@pervalidus>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.14i
X-Mailer: Mutt/1.3.14i - Linux 2.4.2
X-URL: http://www.pervalidus.net/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>> I was not sure if the VIA82CXXX option should be set with the
>> via kt133 chipset , but setting it results in hundreds of
>> hda: dma_intr:status=0x51 { DriveReady SeekComplete Error }
>> hda: dma_intr:error=0x84 { DriveStatusError BadCRC }
>> mesages along with the uhci: errors mentioned above. Again ,
>> the directory was copied correctly.
	 
> That indicates cable problems. The CRC will avoid bad transfers
> as it will do retries

Oh my god. Are you sure it's a cable problem? I'm using the
cable shipped by ASUS with my K7V and have the same problem:

devfs: v0.102 (20000622) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x2
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
ide0: reset: success

Again, if it's really a cable problem, then ASUS is selling
cables that don't work with UDMA66 (but they sell it as
UDMA66).

I urge ASUS to explain this problem. If you do a search for
BadCRC at any lkml archive, you should notice most complaints
are from... VIA (and most seem to have an ASUS motherboard).

-- 
0@pervalidus.{net, {dyndns.}org} Tel: 55-21-717-2399 (Niterói-RJ BR)
