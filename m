Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263787AbTDIUad (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 16:30:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263789AbTDIUad (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 16:30:33 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:45542 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263787AbTDIUab (for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Apr 2003 16:30:31 -0400
Date: Wed, 09 Apr 2003 13:32:04 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: linux-kernel <linux-kernel@vger.kernel.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 564] New: kernel prints "mtrr: MTRR 2 not used" twice when exiting X
Message-ID: <4570000.1049920324@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


http://bugme.osdl.org/show_bug.cgi?id=564

           Summary: kernel prints "mtrr: MTRR 2 not used" twice when exiting
                    X
    Kernel Version: 2.5.67-bk1
            Status: NEW
          Severity: low
             Owner: akpm@digeo.com
         Submitter: bwindle-kbt@fint.org


Distribution: Debian Testing
Hardware Environment: Dell Optiplex GXa, P2 266mhz, Rage Pro AGP, 256mb RAM
Video mode to be used for restore is ffff
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000010000000 (usable)
 BIOS-e820: 00000000ffe00000 - 0000000100000000 (reserved)
<snip>
mtrr: v2.0 (20020519)
PCI: PCI BIOS revision 2.10 entry at 0xfcf4e, last bus=2
<snip>
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected Intel 440LX chipset
agpgart: Maximum main memory to use for agp memory: 204M
agpgart: AGP aperture is 64M @ 0xf0000000
[drm] AGP 0.100 aperture @ 0xf0000000 64MB
[drm] Initialized r128 2.3.0 20021029 on minor 0

Software Environment: X configed to load dri and drm.
CONFIG_MTRR=y
CONFIG_AGP=y
CONFIG_AGP_INTEL=y
CONFIG_DRM=y
CONFIG_DRM_R128=y

Problem Description:
When exiting X (using ctrl+alt+backspace, I don't have a mouse on this machine 
yet) the kernel prints the following message twice: "mtrr: MTRR 2 not used"


Steps to reproduce:
Exit X using ctrl+alt+bksp

