Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261467AbUCJESI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 23:18:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261939AbUCJESI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 23:18:08 -0500
Received: from fmr11.intel.com ([192.55.52.31]:19365 "EHLO
	fmsfmr004.fm.intel.com") by vger.kernel.org with ESMTP
	id S261467AbUCJESB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 23:18:01 -0500
Subject: Re: fsb of older cpu
From: Len Brown <len.brown@intel.com>
To: Bjoern Schmidt <lucky21@uni-paderborn.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <404DA7A8.4090109@uni-paderborn.de>
References: <A6974D8E5F98D511BB910002A50A6647615F47CB@hdsmsx402.hd.intel.com>
	 <1078815523.2342.535.camel@dhcppc4>  <404DA7A8.4090109@uni-paderborn.de>
Content-Type: text/plain
Organization: 
Message-Id: <1078892273.2347.551.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 09 Mar 2004 23:17:53 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> root@kilobyte:/proc/acpi/processor/C097# cat power
> active state:        C2
> default state:       C1
> bus master activity: 00000000
> states:
>      C1:              promotion[C2] demotion[--] latency[000] usage[00000240]
>     *C2:              promotion[--] demotion[C1] latency[100] usage[169083068]
>      C3:              <not supported>

latency is in microseconds.  100 is the highest latency C2 can have w/o
being disabled entirely.  (eg. my laptop has C2 latency of 1, and C3
latency of 85)  Though it is not uncommon for desktop chips to not
support C2 at all...


> Do you know a little program to visualize the fadt flags in a human
> readable way?

# cat /proc/acpi/fadt | ~lenb/bin/acpitbl
where acpitbl is a script in pmtools:

http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/utils/


will print something like this, which depending on the human, is
readable;-)

Signature:        FACP
Length:           132
Revision:         0x02
Checksum:         0x58
OEMID:            TOSHIB
OEM Table ID:     750
OEM Revision:     0x20030101
Creator ID:       TASM
Creator Revision: 0x04010000
FIRMWARE_CTRL:    0x000eee00
DSDT:             0x1ffd0114
INT_MODEL:        0x00
SCI_INT:          9
SMI_CMD:          0x000000b2
ACPI_ENABLE:      0x71
ACPI_DISABLE:     0x70
S4BIOS_REQ:       0x72
PM1a_EVT_BLK:     0x0000d800
PM1b_EVT_BLK:     0x00000000
PM1a_CNT_BLK:     0x0000d804
PM1b_CNT_BLK:     0x00000000
PM2_CNT_BLK:      0x0000d820
PM_TMR_BLK:       0x0000d808
GPE0_BLK:         0x0000d828
GPE1_BLK:         0x00000000
PM1_EVT_LEN:      4
PM1_CNT_LEN:      2
PM2_CNT_LEN:      1
PM_TM_LEN:        4
GPE0_BLK_LEN:     8
GPE1_BLK_LEN:     0
GPE1_BASE:        0
P_LVL2_LAT:       1
P_LVL3_LAT:       85
FLUSH_SIZE:       0
FLUSH_STRIDE:     0
DUTY_OFFSET:      1
DUTY_WIDTH:       0
DAY_ALRM:         0x0d
MON_ALRM:         0x7e
CENTURY:          0x00
Flags:            0x000004a5




