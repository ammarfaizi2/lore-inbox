Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261785AbVEVLZU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261785AbVEVLZU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 May 2005 07:25:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261358AbVEVLZU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 May 2005 07:25:20 -0400
Received: from zproxy.gmail.com ([64.233.162.204]:15050 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261785AbVEVLZL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 May 2005 07:25:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=oiCLUQ1tVHpayiCG9bgxPrSwdZt3VngULvLLDNUuUaLX9Eyl3oAL+73gDPZ/e4/lsDYjY/hNFh/8lHqvXANoAce41QxNp1djni/ha/a0dcXzisBcorqqr0jX/RbFTcqloyrxH92jtQRBJcZxe/cJKL0vsqDdE28nidHKOaP2ySo=
Message-ID: <b6d0f5fb0505220425146d481a@mail.gmail.com>
Date: Sun, 22 May 2005 12:25:11 +0100
From: Cameron Harris <thecwin@gmail.com>
Reply-To: Cameron Harris <thecwin@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: ACPI buttons in 2.6.12-rc4-mm2
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just upgraded from 2.6.11.3 and now my /proc/acpi/button directory
doesn't exist...

$ gzcat /proc/config.gz | grep BUTTON
CONFIG_ACPI_BUTTON=y


And the kernel is detecting my buttons....

$ dmesg | grep LID
[4294668.236000] ACPI: Lid Switch [LID]
$ dmesg | grep PWR
[4294668.235000] ACPI: Power Button (FF) [PWRF]
[4294668.235000] ACPI: Power Button (CM) [PWRB]
$ dmesg | grep SLP
[4294668.236000] ACPI: Sleep Button (CM) [SLPB]
$ find /sys -name "*LID*"
/sys/firmware/acpi/namespace/ACPI/_SB/LID
$ find /sys -name "*PWR*"
/sys/firmware/acpi/namespace/ACPI/_SB/PWRB
/sys/firmware/acpi/namespace/ACPI/PWRF
$ find /sys -name "*SLP*"
/sys/firmware/acpi/namespace/ACPI/_SB/SLPB

All the directories found are empty.

My dsdt is a bit screwed (damn microsoft.. I'm gonna fix it and see if
it make a difference) but it did work before.

$ dmesg | grep DSDT # fyi
[4294667.296000] ACPI: DSDT (v001 Clevo     648FX 0x06040000 MSFT
0x0100000e) @ 0x00000000

Also, sleep doesn't work and has never worked, but that could be
because of the dsdt maybe.

-- 
Cameron Harris
