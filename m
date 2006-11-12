Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932873AbWKLKdy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932873AbWKLKdy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Nov 2006 05:33:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932874AbWKLKdy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Nov 2006 05:33:54 -0500
Received: from frigate.technologeek.org ([62.4.21.148]:20451 "EHLO
	frigate.technologeek.org") by vger.kernel.org with ESMTP
	id S932873AbWKLKdx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Nov 2006 05:33:53 -0500
From: Julien BLACHE <jb@jblache.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: jgarzik@pobox.com
Subject: Intel RNG: firmware hub changes in 2.6.19 break 82802 detection on Core2 Duo MacBook Pro
Date: Sun, 12 Nov 2006 11:33:52 +0100
Message-ID: <87u015osxb.fsf@frigate.technologeek.org>
User-Agent: Gnus/5.110006 (No Gnus v0.6) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On a new Core2 Duo MacBook Pro, 2.6.19-rc5 fails to detect the 82802
RNG with this message:

 intel_rng: FWH not detected

Though it worked in 2.6.18:

 Intel 82802 RNG detected


This is an x86_64 kernel booted via good old lilo, so using the
BootCamp BIOS emulation provided by Apple.

Tell me what kind of info you need to address this issue, here's the
lspci output for a start:

00:00.0 Host bridge [0600]: Intel Corporation Mobile 945GM/PM/GMS/940GML and 945GT Express Memory Controller Hub [8086:27a0] (rev 03)
00:01.0 PCI bridge [0604]: Intel Corporation Mobile 945GM/PM/GMS/940GML and 945GT Express PCI Express Root Port [8086:27a1] (rev 03)
00:07.0 Performance counters [1101]: Intel Corporation Unknown device [8086:27a3] (rev 03)
00:1b.0 Audio device [0403]: Intel Corporation 82801G (ICH7 Family) High Definition Audio Controller [8086:27d8] (rev 02)
00:1c.0 PCI bridge [0604]: Intel Corporation 82801G (ICH7 Family) PCI Express Port 1 [8086:27d0] (rev 02)
00:1c.1 PCI bridge [0604]: Intel Corporation 82801G (ICH7 Family) PCI Express Port 2 [8086:27d2] (rev 02)
00:1c.2 PCI bridge [0604]: Intel Corporation 82801G (ICH7 Family) PCI Express Port 3 [8086:27d4] (rev 02)
00:1d.0 USB Controller [0c03]: Intel Corporation 82801G (ICH7 Family) USB UHCI #1 [8086:27c8] (rev 02)
00:1d.1 USB Controller [0c03]: Intel Corporation 82801G (ICH7 Family) USB UHCI #2 [8086:27c9] (rev 02)
00:1d.2 USB Controller [0c03]: Intel Corporation 82801G (ICH7 Family) USB UHCI #3 [8086:27ca] (rev 02)
00:1d.3 USB Controller [0c03]: Intel Corporation 82801G (ICH7 Family) USB UHCI #4 [8086:27cb] (rev 02)
00:1d.7 USB Controller [0c03]: Intel Corporation 82801G (ICH7 Family) USB2 EHCI Controller [8086:27cc] (rev 02)
00:1e.0 PCI bridge [0604]: Intel Corporation 82801 Mobile PCI Bridge [8086:2448] (rev e2)
00:1f.0 ISA bridge [0601]: Intel Corporation 82801GBM (ICH7-M) LPC Interface Bridge [8086:27b9] (rev 02)
00:1f.1 IDE interface [0101]: Intel Corporation 82801G (ICH7 Family) IDE Controller [8086:27df] (rev 02)
00:1f.2 IDE interface [0101]: Intel Corporation 82801GBM/GHM (ICH7 Family) Serial ATA Storage Controller IDE [8086:27c4] (rev 02)
00:1f.3 SMBus [0c05]: Intel Corporation 82801G (ICH7 Family) SMBus Controller [8086:27da] (rev 02)
01:00.0 VGA compatible controller [0300]: ATI Technologies Inc M56P [Radeon Mobility X1600] [1002:71c5]
02:00.0 Ethernet controller [0200]: Marvell Technology Group Ltd. 88E8053 PCI-E Gigabit Ethernet Controller [11ab:4362] (rev 22)
03:00.0 Network controller [0280]: Atheros Communications, Inc. Unknown device [168c:0024] (rev 01)
0c:03.0 FireWire (IEEE 1394) [0c00]: Texas Instruments TSB82AA2 IEEE-1394b Link Layer Controller [104c:8025] (rev 01)

Thanks,

JB.

-- 
Julien BLACHE                                   <http://www.jblache.org> 
<jb@jblache.org>                                  GPG KeyID 0xF5D65169
