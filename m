Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314223AbSDZVpn>; Fri, 26 Apr 2002 17:45:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314229AbSDZVpm>; Fri, 26 Apr 2002 17:45:42 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:1040 "EHLO
	master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S314223AbSDZVpm>; Fri, 26 Apr 2002 17:45:42 -0400
Date: Fri, 26 Apr 2002 14:43:12 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Wakko Warner <wakko@animx.eu.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: 160gb disk showing up as 137gb
In-Reply-To: <20020426171836.A3160@animx.eu.org>
Message-ID: <Pine.LNX.4.10.10204261442300.10216-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ERM,

Why is it showing up under SCSI ?

On Fri, 26 Apr 2002, Wakko Warner wrote:

> Just bought a maxtor 160gb disk and it shows upt as a 137gb disk.  I thought
> this might be the system board's ide chipset limitation so I put a scsi->ide
> adapter on the drive.  Same situation occurs.  I'm looking at what the kernel
> reports when it finds the drive.  /proc/partitions shows this drive as:
>    8     0  134217727 sda
> /proc/scsi/scsi shows:
> Attached devices:
> Host: scsi0 Channel: 00 Id: 00 Lun: 00
>   Vendor: Maxtor 4 Model: G160J8           Rev: GAK8
>   Type:   Direct-Access                    ANSI SCSI revision: 02
>      
> I tried kernel 2.4.14 and 2.4.18.  Any ideas?
> 
> lspci -v:
> 00:00.0 Host bridge: Intel Corporation 440FX - 82441FX PMC [Natoma] (rev 02)
>         Flags: bus master, medium devsel, latency 32
> 
> 00:07.0 ISA bridge: Intel Corporation 82371SB PIIX3 ISA [Natoma/Triton II] (rev
> 01)
>         Flags: bus master, medium devsel, latency 0
> 
> 00:07.1 IDE interface: Intel Corporation 82371SB PIIX3 IDE [Natoma/Triton II] (prog-if 80 [Master])
>         Flags: bus master, medium devsel, latency 32
>         I/O ports at ffa0 [size=16]
> 
> 00:10.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev 05)        Subsystem: Intel Corporation EtherExpress PRO/100+ Management Adapter
>         Flags: bus master, medium devsel, latency 64, IRQ 16
>         Memory at ffaff000 (32-bit, prefetchable) [size=4K]
>         I/O ports at ef80 [size=32]
>         Memory at fea00000 (32-bit, non-prefetchable) [size=1M]
>         Expansion ROM at fe900000 [disabled] [size=1M]
>         Capabilities: [dc] Power Management version 1
> 
> 00:11.0 SCSI storage controller: Adaptec AIC-7881U
>         Flags: bus master, medium devsel, latency 64, IRQ 16
>         I/O ports at ec00 [disabled] [size=256]
>         Memory at febef000 (32-bit, non-prefetchable) [size=4K]
>         Expansion ROM at febd0000 [disabled] [size=64K]
> 
> 00:12.0 VGA compatible controller: S3 Inc. 86c325 [ViRGE] (rev 06) (prog-if 00 [VGA])
>         Flags: bus master, medium devsel, latency 64, IRQ 17
>         Memory at f8000000 (32-bit, non-prefetchable) [size=64M]
>         Expansion ROM at febf0000 [disabled] [size=64K]
> 
> 00:13.0 Multimedia audio controller: Ensoniq ES1371 [AudioPCI-97] (rev 08)
>         Subsystem: Ensoniq: Unknown device 1371
>         Flags: bus master, slow devsel, latency 64, IRQ 18
>         I/O ports at ef00 [size=64]
>         Capabilities: [dc] Power Management version 1
> 
> -- 
>  Lab tests show that use of micro$oft causes cancer in lab animals
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andre Hedrick
LAD Storage Consulting Group

