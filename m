Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129050AbQKMM5t>; Mon, 13 Nov 2000 07:57:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129698AbQKMM5a>; Mon, 13 Nov 2000 07:57:30 -0500
Received: from ipk.ipk.fhg.de ([153.96.56.2]:58805 "EHLO ipk.ipk.fhg.de")
	by vger.kernel.org with ESMTP id <S129050AbQKMM5S>;
	Mon, 13 Nov 2000 07:57:18 -0500
Date: Mon, 13 Nov 2000 13:56:55 +0100
From: Stefan Sassenberg <Stefan.Sassenberg@ipk.fhg.de>
To: linux-kernel@vger.kernel.org
Subject: Bug-report: menuconfig
Message-ID: <20001113135655.C639912@kuerbis.ipk.fhg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I think I detected a bug in Makefile's target "menuconfig".

When I set CONFIG_MD_BOOT to 'y' and then set neither
CONFIG_MD_LINEAR nor CONFIG_MD_STRIPED to 'y' then although
CONFIG_MD_BOOT is not changeable anymore it is always set. This leads
to an error when linking the kernel because of an unresolved symbol
"md_device_setup" (or similar).

The menu items are:
CONFIG_MD_BOOT      Boot support (linear, striped)
CONFIG_MD_LINEAR    Linear (append) mode
CONFIG_MD_STRIPED   RAID-0 (striping) mode

Kernel version is 2.2.16 on an i386.

Regards

Stefan
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
