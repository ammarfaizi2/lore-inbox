Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130359AbRAaGxh>; Wed, 31 Jan 2001 01:53:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130420AbRAaGx1>; Wed, 31 Jan 2001 01:53:27 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:25360
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S130359AbRAaGxS> convert rfc822-to-8bit; Wed, 31 Jan 2001 01:53:18 -0500
Date: Tue, 30 Jan 2001 22:52:51 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Frédéric L. W. Meunier <0@pervalidus.net>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: VIA VT82C686X
In-Reply-To: <20010131011914.D160@pervalidus>
Message-ID: <Pine.LNX.4.10.10101302250160.4244-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=X-UNKNOWN
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You system did something funny or the new VIA code did it.
But because you observed this pattern the new feature that on Linux has
kicked in and hopefull recovered the system for you.

On Wed, 31 Jan 2001, [iso-8859-1] Frédéric L. W. Meunier wrote:

> Me too. But I couldn't get UDMA 66 after changing my BIOS
> settings and booting. With 33 it's very stable (what I used
> with 2.4.0). A diff:
> 
> -hda: 30015216 sectors (15368 MB) w/2048KiB Cache, CHS=1868/255/63, UDMA(33)
> +hda: 30015216 sectors (15368 MB) w/2048KiB Cache, CHS=1868/255/63, UDMA(66)
> ...
> +hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> +hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
> VFS: Mounted root (ext2 filesystem) readonly.
> -Freeing unused kernel memory: 200k freed
> +Freeing unused kernel memory: 204k freed
> +hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> +hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
> +hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> +hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
> +hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> +hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
> +hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> +hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
> +ide0: reset: success

Because you did not see DMA_DISABLED

The auto_dma_crc downgrade feature turned down the transfer rate of the
drive/host pair until the iCRC issue stablized.

Cheers,

> I know this is a known issue, but I thought testing would be
> OK. ASUS K7V with the shipped cable.
> 
> -- 
> 0@pervalidus.{net, {dyndns.}org} Tel: 55-21-717-2399 (Niterói-RJ BR)
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 

Andre Hedrick
Linux ATA Development

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
