Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261216AbULWMFb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261216AbULWMFb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Dec 2004 07:05:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261218AbULWMFb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Dec 2004 07:05:31 -0500
Received: from fmr17.intel.com ([134.134.136.16]:1978 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S261216AbULWMFG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Dec 2004 07:05:06 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 8BIT
Subject: RE: the patch of restore-pci-config-space-on-resume break S1 on ASUS2400 NE
Date: Thu, 23 Dec 2004 20:04:49 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F84069D52F2@pdsmsx403>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: the patch of restore-pci-config-space-on-resume break S1 on ASUS2400 NE
Thread-Index: AcTozpo5QSsspRqOTriFCdWtPI6rbgADhzfA
From: "Yu, Luming" <luming.yu@intel.com>
To: "Arjan van de Ven" <arjanv@redhat.com>
Cc: "Brown, Len" <len.brown@intel.com>, "Li, Shaohua" <shaohua.li@intel.com>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       <linux-kernel@vger.kernel.org>, <acpi-devel@lists.sourceforge.net>
X-OriginalArrivalTime: 23 Dec 2004 12:04:51.0501 (UTC) FILETIME=[9B5F25D0:01C4E8E7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The following is S1 suspend and resume log for one working case. 

With 2.6.7, after several times of S1 suspend and resume cycle, the box eventually hang on resume.
With 2.6.10-rc3, after One time of successful S1 suspend and resume cycle, the box hang on resume.
With your patch, I always saw S1 resume hang so far.

After applying patch filed at bugzilla
http://bugzilla.kernel.org/show_bug.cgi?id=1588
to 2.6.7 kernel, the second time of S1 resume by hitting power button cause power off . :-(

>From these experience, I'm thinking S1 is totally broken on this box. :-(

Thanks,
Luming 

 PM: Preparing system for suspend
Stopping tasks: =============================|
 device name = Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+
---> ignored
 device name = Ricoh Co Ltd R5C552 IEEE 1394 Controller
---> ignored
 device name = Ricoh Co Ltd RL5c476 II (#2)
---> ignored
 device name = Ricoh Co Ltd RL5c476 II
---> ignored
 device name = Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) AC'97 Modem Controller
---> ignored
 device name = Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) AC'97 Audio Controller
---> ignored
 device name = Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) SMBus Controller
---> ignored
 device name = Intel Corp. 82801DBM (ICH4) Ultra ATA Storage Controller
---> ignored
 device name = Intel Corp. 82801DBM LPC Interface Controller
 device name = Intel Corp. 82801 PCI Bridge
 device name = Intel Corp. 82801DB/DBM (ICH4/ICH4-M) USB 2.0 EHCI Controller
---> ignored
 device name = Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #3
---> ignored
 device name = Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #2
---> ignored
 device name = Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #1
---> ignored
 device name = Intel Corp. 82852/855GM Integrated Graphics Device (#2)
 device name = Intel Corp. 82852/855GM Integrated Graphics Device
 device name = Intel Corp. 855GM/GME GMCH Configuration Process Registers
 device name = Intel Corp. 855GM/GME GMCH Memory I/O Control Registers
 device name = Intel Corp. 82852/855GM Host Bridge
---> ignored
PM: Entering state.
 hwsleep-0315 [04] acpi_enter_sleep_state: Entering sleep state [S1]
Back to C!
PM: Finishing up.
 device name = Intel Corp. 82852/855GM Host Bridge
---> ignored
 device name = Intel Corp. 855GM/GME GMCH Memory I/O Control Registers
 device name = Intel Corp. 855GM/GME GMCH Configuration Process Registers
 device name = Intel Corp. 82852/855GM Integrated Graphics Device
 device name = Intel Corp. 82852/855GM Integrated Graphics Device (#2)
 device name = Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #1
---> ignored
 device name = Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #2
---> ignored
 device name = Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #3
---> ignored
 device name = Intel Corp. 82801DB/DBM (ICH4/ICH4-M) USB 2.0 EHCI Controller
---> ignored
 device name = Intel Corp. 82801 PCI Bridge
 device name = Intel Corp. 82801DBM LPC Interface Controller
 device name = Intel Corp. 82801DBM (ICH4) Ultra ATA Storage Controller
---> ignored
 device name = Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) SMBus Controller
---> ignored
 device name = Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) AC'97 Audio Controller
---> ignored
 device name = Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) AC'97 Modem Controller
---> ignored
 device name = Ricoh Co Ltd RL5c476 II
---> ignored
 device name = Ricoh Co Ltd RL5c476 II (#2)
---> ignored
 device name = Ricoh Co Ltd R5C552 IEEE 1394 Controller
---> ignored
 device name = Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+
---> ignored
Restarting tasks... done


#lspci
0000:00:00.0 Host bridge: Intel Corp. 82852/855GM Host Bridge (rev 02)
0000:00:00.1 System peripheral: Intel Corp.: Unknown device 3584 (rev 02)
0000:00:00.3 System peripheral: Intel Corp.: Unknown device 3585 (rev 02)
0000:00:02.0 VGA compatible controller: Intel Corp. 82852/855GM Integrated Graphics Device (rev 02)
0000:00:02.1 Display controller: Intel Corp. 82852/855GM Integrated Graphics Device (rev 02)
0000:00:1d.0 USB Controller: Intel Corp. 82801DB USB (Hub #1) (rev 03)
0000:00:1d.1 USB Controller: Intel Corp. 82801DB USB (Hub #2) (rev 03)
0000:00:1d.2 USB Controller: Intel Corp. 82801DB USB (Hub #3) (rev 03)
0000:00:1d.7 USB Controller: Intel Corp. 82801DB USB2 (rev 03)
0000:00:1e.0 PCI bridge: Intel Corp. 82801BAM/CAM PCI Bridge (rev 83)
0000:00:1f.0 ISA bridge: Intel Corp. 82801DBM LPC Interface Controller (rev 03)
0000:00:1f.1 IDE interface: Intel Corp. 82801DBM Ultra ATA Storage Controller (rev 03)
0000:00:1f.3 SMBus: Intel Corp. 82801DB/DBM SMBus Controller (rev 03)
0000:00:1f.5 Multimedia audio controller: Intel Corp. 82801DB AC'97 Audio Controller (rev 03)
0000:00:1f.6 Modem: Intel Corp. 82801DB AC'97 Modem Controller (rev 03)
0000:01:03.0 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev a9)
0000:01:03.1 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev a9)
0000:01:03.2 FireWire (IEEE 1394): Ricoh Co Ltd R5C552 IEEE 1394 Controller (rev 01)
0000:01:04.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)


-----Original Message-----
From: Arjan van de Ven [mailto:arjanv@redhat.com] 
Sent: 2004Äê12ÔÂ23ÈÕ 17:05
To: Yu, Luming
Cc: Brown, Len; Li, Shaohua; Pallipadi, Venkatesh; linux-kernel@vger.kernel.org
Subject: Re: the patch of restore-pci-config-space-on-resume break S1 on ASUS2400 NE

On Thu, Dec 23, 2004 at 04:51:09PM +0800, Yu, Luming wrote:
>  Hi,
> 
> Since 2.6.7, the Changes for drivers/pci/pci-driver.c@1.37 make my
> ASUS 2400NE hang on S1 resume. 

we need to figure out which device can't take the pci config space
restore...

