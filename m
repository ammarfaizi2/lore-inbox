Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263398AbTEISwI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 14:52:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263409AbTEISwI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 14:52:08 -0400
Received: from air-2.osdl.org ([65.172.181.6]:59097 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263398AbTEISwF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 14:52:05 -0400
Subject: [KEXEC][2.5.69] kexec for 2.5.69 available
From: Andy Pfiffer <andyp@osdl.org>
To: Eric Biederman <ebiederm@xmission.com>
Cc: fastboot@osdl.org,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Suparna Bhattacharya <suparna@in.ibm.com>
Content-Type: text/plain
Organization: 
Message-Id: <1052507057.15923.31.camel@andyp.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 09 May 2003 12:04:18 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric,

I have a patch set available for kexec for 2.5.69.  I had an unrelated
delay in posting this due to some strange behavior of late with LILO and
my ext3-mounted /boot partition (/sbin/lilo would say that it updated,
but a subsequent reboot would not include my new kernel)

The patches are available for download from OSDL's patch lifecycle
manager ( http://www.osdl.org/cgi-bin/plm/ ).

Patch stack for kexec for 2.5.69:

        kexec base for 2.5.69:
        http://www.osdl.org/cgi-bin/plm?module=patch_info&patch_id=1828

        kexec hwfixes for 2.5.69:
        http://www.osdl.org/cgi-bin/plm?module=patch_info&patch_id=1829

        kexec usemm change (allowed 2-way to work for me):
        http://www.osdl.org/cgi-bin/plm?module=patch_info&patch_id=1830

        optional change to defconfig (sets CONFIG_KEXEC=y):
        http://www.osdl.org/cgi-bin/plm?module=patch_info&patch_id=1831

The patches are also available (with matching kexec-tools-1.8) from this
link pending a crontab update:
http://www.osdl.org/archive/andyp/kexec/2.5.69/

Andrew Morton's tree now also contains kexec, and you can pick up his
patch here:
http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.69/

I'll put together another release area for a matching kexec-tools for
-mm trees (different kexec syscall number between 2.5.* and 2.5.*-mm*)
as soon as I get -mm trees built and booted on my kexec test machines.


Regards,
Andy

To All: if you try kexec, a quick reply of success or failure to
fastboot@osdl.org would be appreciated.  If it doesn't work for you,
please include the output of lspci in your email.

Kexec has worked for me on these systems:

    single P3-800MHz, 640MB:
        00:00.0 Host bridge: ServerWorks CNB20LE Host Bridge (rev 06)
        00:00.1 Host bridge: ServerWorks CNB20LE Host Bridge (rev 06)
        00:01.0 VGA compatible controller: S3 Inc. Savage 4 (rev 04)
        00:09.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro
        100] (rev 08)
        00:0f.0 ISA bridge: ServerWorks OSB4 South Bridge (rev 50)
        00:0f.1 IDE interface: ServerWorks OSB4 IDE Controller
        00:0f.2 USB Controller: ServerWorks OSB4/CSB5 OHCI USB
        Controller (rev 04)
        01:03.0 SCSI storage controller: Adaptec AIC-7892P U160/m (rev
        02)
        
    dual P3-866MHz, 256MB:
        00:00.0 Host bridge: ServerWorks CNB20LE Host Bridge (rev 05)
        00:00.1 Host bridge: ServerWorks CNB20LE Host Bridge (rev 05)
        00:02.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro
        100] (rev 08)
        00:04.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro
        100] (rev 08)
        00:07.0 VGA compatible controller: ATI Technologies Inc Rage XL
        (rev 65)
        00:0f.0 ISA bridge: ServerWorks OSB4 South Bridge (rev 4f)
        00:0f.1 IDE interface: ServerWorks OSB4 IDE Controller
        00:0f.2 USB Controller: ServerWorks OSB4/CSB5 USB Controller
        (rev 04)
        01:05.0 SCSI storage controller: LSI Logic / Symbios Logic
        53c896 (rev 07)
        01:05.1 SCSI storage controller: LSI Logic / Symbios Logic
        53c896 (rev 07)

    dual P4-1.7GHz Xeon, 512MB:
        00:00.0 Host bridge: Intel Corp. 82850 860 (Wombat) Chipset Host
        Bridge (MCH) (rev 04)
        00:01.0 PCI bridge: Intel Corp. 82850/82860 850/860
        (Tehama/Wombat) Chipset AGP Bridge (rev 04)
        00:02.0 PCI bridge: Intel Corp. 82860 860 (Wombat) Chipset PCI
        Bridge (rev 04)
        00:1e.0 PCI bridge: Intel Corp. 82801BA/CA PCI Bridge (rev 04)
        00:1f.0 ISA bridge: Intel Corp. 82801BA ISA Bridge (LPC) (rev
        04)
        00:1f.1 IDE interface: Intel Corp. 82801BA IDE U100 (rev 04)
        00:1f.2 USB Controller: Intel Corp. 82801BA/BAM USB (Hub  (rev
        04)
        00:1f.3 SMBus: Intel Corp. 82801BA/BAM SMBus (rev 04)
        00:1f.5 Multimedia audio controller: Intel Corp. 82801BA/BAM
        AC'97 Audio (rev 04)
        01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA
        G400 AGP (rev 85)
        02:1f.0 PCI bridge: Intel Corp. 82806AA PCI64 Hub PCI Bridge
        (rev 03)
        03:00.0 PIC: Intel Corp. 82806AA PCI64 Hub Advanced Programmable
        Interrupt Controller (rev 01)
        04:04.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro
        100] (rev 0c)





