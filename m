Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264933AbUAHON7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 09:13:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265063AbUAHON7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 09:13:59 -0500
Received: from [220.110.13.64] ([220.110.13.64]:9856 "EHLO smtp.sscnet.co.jp")
	by vger.kernel.org with ESMTP id S264933AbUAHONw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 09:13:52 -0500
Message-ID: <3FFD662D.C86C958E@ezinc.com>
Date: Thu, 08 Jan 2004 23:16:13 +0900
From: nickey <kernel@ezinc.com>
X-Mailer: Mozilla 4.78 [ja] (Windows NT 5.0; U)
X-Accept-Language: ja
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: IDE Hotswaping problem
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm running RedHat9.0 with kernel 2.4.23.
Using hdparm-5.4(idectl 1 on/off), I can attach or de-attach /dev/hdc.
It works very fine. But /proc/ide/ide1 is increasing.
Like this.

# ls /proc/ide
amd74xx drivers hda hdc ide0 ide1

# idectl 1 off
# idectl 1 on
hdc: MAXTOR XXXXX, ATA DISK drive
ide1 at 0x170-0x177,0x376 on irq 15
hdc: attached ide-disk driver.
hdc: host protected area => 1

# ls /proc/ide
amd74xx drivers hda hdc ide0 ide1 ide1

# idectl 1 off
# idectl 1 on
hdc: MAXTOR XXXXX, ATA DISK drive
ide1 at 0x170-0x177,0x376 on irq 15
hdc: attached ide-disk driver.
hdc: host protected area => 1

# ls /proc/ide
amd74xx drivers hda hdc ide0 ide1 ide1 ide1

How do I stop increasing ide1?
It looks ide1 can not be erase.

nickey
