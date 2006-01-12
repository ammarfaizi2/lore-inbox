Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161462AbWALXVH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161462AbWALXVH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 18:21:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161464AbWALXVH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 18:21:07 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:56836 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1161462AbWALXVF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 18:21:05 -0500
Date: Fri, 13 Jan 2006 00:21:04 +0100
From: Adrian Bunk <bunk@stusta.de>
To: =?iso-8859-1?Q?Jos=E9_Luis_S=E1nchez?= 
	<jsanchez@todounix.homeip.net>
Cc: linux-kernel@vger.kernel.org, axboe@suse.de, linux-scsi@vger.kernel.org,
       matthew@wil.cx
Subject: Re: Problem with 2.6.14 and up...
Message-ID: <20060112232104.GD29663@stusta.de>
References: <200511211724.47826.jsanchez@todounix.homeip.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200511211724.47826.jsanchez@todounix.homeip.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2005 at 05:24:47PM +0100, José Luis Sánchez wrote:

> Hi,

Hi José,

> >From 2.6.14 I have a nasty problem with my SCSI devices. First, see my HW:
> 
> ----------------------------------
> 00:00.0 Host bridge: Intel Corporation 440BX/ZX/DX - 82443BX/ZX/DX Host bridge 
> (rev 03)
> 00:01.0 PCI bridge: Intel Corporation 440BX/ZX/DX - 82443BX/ZX/DX AGP bridge 
> (rev 03)
> 00:04.0 ISA bridge: Intel Corporation 82371AB/EB/MB PIIX4 ISA (rev 02)
> 00:04.1 IDE interface: Intel Corporation 82371AB/EB/MB PIIX4 IDE (rev 01)
> 00:04.2 USB Controller: Intel Corporation 82371AB/EB/MB PIIX4 USB (rev 01)
> 00:04.3 Bridge: Intel Corporation 82371AB/EB/MB PIIX4 ACPI (rev 02)
> 00:0a.0 SCSI storage controller: LSI Logic / Symbios Logic 53c875 (rev 26)
> 00:0b.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone] (rev 
> 64)
> 00:0d.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 06)
> 00:0d.1 Input device controller: Creative Labs SB Live! MIDI/Game Port (rev 
> 06)
> 01:00.0 VGA compatible controller: nVidia Corporation NV28 [GeForce4 Ti 4200 
> AGP 8x] (rev a1)
> ------------------------
> 
> I'm using the ncr53c8xx SCSI driver. When I run K3b, the program stalls a few 
> minutes and this appears in the messages file:
> 
> sr0: scsi3-mmc drive: 40x/40x cd/rw xa/form2 cdda tray
> Uniform CD-ROM driver Revision: 3.20
> sr 0:0:1:0: Attached scsi CD-ROM sr0
> sr1: scsi3-mmc drive: 24x/16x writer cd/rw xa/form2 cdda tray
> sr 0:0:2:0: Attached scsi CD-ROM sr1
> sd 0:0:0:0: Attached scsi generic sg0 type 0
> sr 0:0:1:0: Attached scsi generic sg1 type 5
> sr 0:0:2:0: Attached scsi generic sg2 type 5
>  0:0:5:0: Attached scsi generic sg3 type 1
> sr 0:0:2:0: phase change 2-1 12@01bbcf60 resid=6.
> sr 0:0:2:0: ABORT operation started.
> sr 0:0:2:0: ABORT operation timed-out.
> sr 0:0:2:0: DEVICE RESET operation started.
> sr 0:0:2:0: DEVICE RESET operation timed-out.
> sr 0:0:2:0: BUS RESET operation started.
> sym0: SCSI BUS reset detected.
> sym0: SCSI BUS has been reset.
> sr 0:0:2:0: BUS RESET operation complete.
> sr 0:0:2:0: phase change 2-1 12@01bbcf60 resid=6.
> Device not ready. Make sure there is a disc in the drive.
> Device not ready. Make sure there is a disc in the drive.
> sr 0:0:2:0: phase change 2-1 12@01bbcf60 resid=6.
> sr 0:0:2:0: phase change 2-3 12@01bbcf60 resid=2.
> sr 0:0:2:0: phase change 2-3 12@01bbcf60 resid=2.
> sr 0:0:2:0: phase change 2-3 12@01bbcf60 resid=2.
> ....
> 
> I'm very sure what the SCSI card, the cabling and the devices are OK, why 
> don't have any problem with 2.4.32 kernel.
> 
> Ideas?


is this problem still present in kernel 2.6.15?


> José Luis


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

