Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130485AbRCWK0U>; Fri, 23 Mar 2001 05:26:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130470AbRCWK0L>; Fri, 23 Mar 2001 05:26:11 -0500
Received: from smtp015.mail.yahoo.com ([216.136.173.59]:55823 "HELO
	smtp015.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S130485AbRCWKZy>; Fri, 23 Mar 2001 05:25:54 -0500
X-Apparently-From: <quintaq@yahoo.co.uk>
Date: Fri, 23 Mar 2001 10:27:29 +0000
From: quintaq@yahoo.co.uk
To: <linux-kernel@vger.kernel.org>
Subject: Re: UDMA 100 / PIIX4 question
In-Reply-To: <3AB8FDAD.BF71A5F@bigfoot.com>
In-Reply-To: <Pine.LNX.4.10.10103201628390.8689-100000@coffee.psychology.mcmaster.ca>
	<3AB8FDAD.BF71A5F@bigfoot.com>
Reply-To: <linux-kernel@vger.kernel.org>
X-Mailer: Sylpheed version 0.4.62 (GTK+ 1.2.8; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20010323102603Z130485-407+2891@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Mar 2001 11:14:53 -0800
Tim Moore <timothymoore@bigfoot.com> wrote:

> Change partition type to 'c' (fat32+LBA); check that BIOS is set for
> (AUTO or USER) and LBA.
> 
Hi Tim,

I am afraid that I do not know how to change my partition type.  I can confirm. however, that the BIOS is set to Auto / LBA and that BIOS confirms UDMA 5 is set (and cannot be set unless the correct cabling is detected).

> 
> Regarding the PIIX4, I reran basic throughput read tests on a more
> recent UDMA5, 5400RPM Maxtor on the PIIX4 and HPT366 (Abit BP6 +
> 2.2.19p17 + ide.2.2.18.1221.patch) chipsets.

<snip>

But is my controller, though detected as a PIIX4 (and described as such in the Asus manual), really a PIIX4?  lspci :

00:00.0 Host bridge: Intel Corporation: Unknown device 1130 (rev 02)
00:01.0 PCI bridge: Intel Corporation: Unknown device 1131 (rev 02)
00:1e.0 PCI bridge: Intel Corporation: Unknown device 244e (rev 01)
00:1f.0 ISA bridge: Intel Corporation: Unknown device 2440 (rev 01)
00:1f.1 IDE interface: Intel Corporation: Unknown device 244b (rev 01)
00:1f.2 USB Controller: Intel Corporation: Unknown device 2442 (rev 01)
00:1f.3 SMBus: Intel Corporation: Unknown device 2443 (rev 01)
00:1f.4 USB Controller: Intel Corporation: Unknown device 2444 (rev 01)
01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev 04)
02:0a.0 Ethernet controller: Winbond Electronics Corp W89C940
02:0c.0 Multimedia audio controller: Creative Labs SB Live! EMU10000 (rev 04)
02:0c.1 Input device controller: Creative Labs SB Live! (rev 01)
02:0d.0 Multimedia video controller: Brooktree Corporation Bt848 TV with DMA push (rev 12)
02:0e.0 SCSI storage controller: Adaptec AHA-7850 (rev 03)

On the other hand, cat /proc/ide/piix :

                               Intel PIIX4 Ultra 100 Chipset.
--------------- Primary Channel ---------------- Secondary Channel -------------
                 enabled                          enabled
--------------- drive0 --------- drive1 -------- drive0 ---------- drive1 ------
DMA enabled:    yes              no              yes               no 
UDMA enabled:   yes              no              yes               no 
UDMA enabled:   5                X               2                 X
UDMA
DMA
PI

Regards,

Geoff

_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

