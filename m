Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261285AbVDNFSM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261285AbVDNFSM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 01:18:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261268AbVDNFSM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 01:18:12 -0400
Received: from fmr18.intel.com ([134.134.136.17]:50919 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S261438AbVDNFR1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 01:17:27 -0400
From: "Yu, Luming" <luming.yu@intel.com>
Reply-To: luming.yu@intel.com
To: Ben Greear <greearb@candelatech.com>
Subject: Re: hard lockup on nx5000 laptop with 2.6.11+hack and FC2's 2.6.10-1.770_FC2
Date: Thu, 14 Apr 2005 13:17:28 +0800
User-Agent: KMail/1.6.1
Cc: linux-kernel <linux-kernel@vger.kernel.org>
References: <42548FFC.7000004@candelatech.com>
In-Reply-To: <42548FFC.7000004@candelatech.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200504141317.28478.luming.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Do you have acpi enabled?  
If the problem just happend with acpi enabled, please
try latest acpi patch through testing latest mm tree, If it still doesn't 
work, please file a bug on www.kernel.org

Thanks,
Luming

On Thursday 07 April 2005 09:42, Ben Greear wrote:
> Several wierd things with my laptop since I upgraded from 2.6.9+hack,
> which works beautifully.
>
> 1)  With 2.6.11+hack, compiled for the Pentium-M, the system
>    freezes at or soon after I close the LCD screen.  Out of curiosity,
>    I tried the FN - [F4] combination, which I believe should try to flip
>    the video output to the external monitor port (I have nothing plugged in
> there). This immediately made the machine starting counting memory, and it
> turns out it had completely erased the BIOS settings to defaults and set
> the date back to Jan 4 of this year!
>
> 2) With 2.6.10-1.770_FC2 I totally froze the system when I tried to
>    'ifup eth0'.  eth0 is BCM5705M (b44 driver)
>
> 3) When it freezes, the machine gets really hot, and the fan does not
> increase in speed like it normally does.  I am not sure if this means
> anything, but I thought I'd share it.
>
> For now, I'm back at 2.6.9+hack, but I'm willing to try the newer kernels
> if someone has a suggestion or needs more debugging.
>
> Install is:  FC2, mostly up-to-date when I was having these problems, fully
>               up-to-date now.
>
> cpu:
> processor       : 0
> vendor_id       : GenuineIntel
> cpu family      : 6
> model           : 13
> model name      : Intel(R) Pentium(R) M processor 1.50GHz
> stepping        : 6
> cpu MHz         : 1495.769
> cache size      : 2048 KB
> fdiv_bug        : no
> hlt_bug         : no
> f00f_bug        : no
> coma_bug        : no
> fpu             : yes
> fpu_exception   : yes
> cpuid level     : 2
> wp              : yes
> flags           : fpu vme de pse tsc msr mce cx8 apic sep mtrr pge mca cmov
> pat clflush dts acpi mmx fxsr sse sse2 ss tm pbe est tm2 bogomips        :
> 2965.50
>
>
> lspci of this system:
> 00:00.0 Host bridge: Intel Corp. 82852/855GM Host Bridge (rev 02)
> 00:00.1 System peripheral: Intel Corp. 855GM/GME GMCH Memory I/O Control
> Registers (rev 02) 00:00.3 System peripheral: Intel Corp. 855GM/GME GMCH
> Configuration Process Registers (rev 02) 00:02.0 VGA compatible controller:
> Intel Corp. 82852/855GM Integrated Graphics Device (rev 02) 00:02.1 Display
> controller: Intel Corp. 82852/855GM Integrated Graphics Device (rev 02)
> 00:1d.0 USB Controller: Intel Corp. 82801DB (ICH4) USB UHCI #1 (rev 01)
> 00:1d.1 USB Controller: Intel Corp. 82801DB (ICH4) USB UHCI #2 (rev 01)
> 00:1d.2 USB Controller: Intel Corp. 82801DB (ICH4) USB UHCI #3 (rev 01)
> 00:1d.7 USB Controller: Intel Corp. 82801DB (ICH4) USB2 EHCI Controller
> (rev 01) 00:1e.0 PCI bridge: Intel Corp. 82801BAM/CAM PCI Bridge (rev 81)
> 00:1f.0 ISA bridge: Intel Corp. 82801DBM LPC Interface Controller (rev 01)
> 00:1f.1 IDE interface: Intel Corp. 82801DBM (ICH4) Ultra ATA Storage
> Controller (rev 01) 00:1f.5 Multimedia audio controller: Intel Corp.
> 82801DB (ICH4) AC'97 Audio Controller (rev 01) 00:1f.6 Modem: Intel Corp.
> 82801DB (ICH4) AC'97 Modem Controller (rev 01) 01:04.0 Ethernet controller:
> Atheros Communications, Inc. AR5212 802.11abg NIC (rev 01) 01:06.0 CardBus
> bridge: Texas Instruments PCI7420 CardBus Controller 01:06.1 CardBus
> bridge: Texas Instruments PCI7420 CardBus Controller 01:06.3 Unknown mass
> storage controller: Texas Instruments PCI7420 Flash Media Controller
> 01:0d.0 FireWire (IEEE 1394): Texas Instruments TSB43AB22/A IEEE-1394a-2000
> Controller (PHY/Link) 01:0e.0 Ethernet controller: Broadcom Corporation
> BCM5705M 10/100/1000Base T (rev 02)
