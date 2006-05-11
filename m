Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965190AbWEKHWN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965190AbWEKHWN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 03:22:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965189AbWEKHWN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 03:22:13 -0400
Received: from smtp-104-thursday.nerim.net ([62.4.16.104]:58641 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S965188AbWEKHWM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 03:22:12 -0400
Date: Thu, 11 May 2006 09:23:04 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Karel Kulhavy <clock@twibright.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: i2c-related 1-minute hang during bootup
Message-Id: <20060511092304.33dfdbcd.khali@linux-fr.org>
In-Reply-To: <20060430141829.GA9546@kestrel>
References: <20060430141829.GA9546@kestrel>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Karel,

> I upgraded my kernel from 2.6.12 to 2.6.16.11 using make oldconfig.
> My machine is DELL Inspiron 510m laptop. Before everything was OK.
> Now the kernel hangs for a minute during bootup between the messages
> "input: AlpsPS/2 ALPS GlidePoint as /class/input/input2"
> and "Advanced Linux Sound Architecture Driver Version 1.0.11rc2 (Wed Jan
> 04 08:57:20 2006 UTC)."

I'd suggest that you read the following thread, which relates a very
similar story:
http://marc.theaimsgroup.com/?t=114224591800003&r=1&w=2
http://marc.theaimsgroup.com/?t=114360452300050&r=1&w=2

> During the bootup nothing is printed during the hang, but dmesg contains
> this at that point:
> i2c_adapter i2c-0: bus is not idle. status is 0xff
> i2c_adapter i2c-0: found normal entry for adapter 0, addr 0x51
> i2c_adapter i2c-0: master_xfer[0] W, addr=0x51, len=0
> i2c_adapter i2c-0: bus is not idle. status is 0xff
> i2c_adapter i2c-0: found normal entry for adapter 0, addr 0x52
> i2c_adapter i2c-0: master_xfer[0] W, addr=0x52, len=0
> i2c_adapter i2c-0: bus is not idle. status is 0xff
> i2c_adapter i2c-0: found normal entry for adapter 0, addr 0x53
> i2c_adapter i2c-0: master_xfer[0] W, addr=0x53, len=0
> i2c_adapter i2c-0: bus is not idle. status is 0xff
> i2c_adapter i2c-0: found normal entry for adapter 0, addr 0x54
> i2c_adapter i2c-0: master_xfer[0] W, addr=0x54, len=0
> i2c_adapter i2c-0: bus is not idle. status is 0xff
> i2c_adapter i2c-0: found normal entry for adapter 0, addr 0x55
> i2c_adapter i2c-0: master_xfer[0] W, addr=0x55, len=0
> i2c_adapter i2c-0: bus is not idle. status is 0xff
> i2c_adapter i2c-0: found normal entry for adapter 0, addr 0x56
> i2c_adapter i2c-0: master_xfer[0] W, addr=0x56, len=0
> i2c_adapter i2c-0: bus is not idle. status is 0xff
> i2c_adapter i2c-0: found normal entry for adapter 0, addr 0x57
> i2c_adapter i2c-0: master_xfer[0] W, addr=0x57, len=0
> i2c_adapter i2c-0: bus is not idle. status is 0xff
> i2c-core: driver [pcf8574] registered
> i2c_adapter i2c-0: found normal entry for adapter 0, addr 0x20
> i2c_adapter i2c-0: master_xfer[0] W, addr=0x20, len=0
> i2c_adapter i2c-0: bus is not idle. status is 0xff
> i2c_adapter i2c-0: found normal entry for adapter 0, addr 0x21
> i2c_adapter i2c-0: master_xfer[0] W, addr=0x21, len=0
> i2c_adapter i2c-0: bus is not idle. status is 0xff
> i2c_adapter i2c-0: found normal entry for adapter 0, addr 0x22
> i2c_adapter i2c-0: master_xfer[0] W, addr=0x22, len=0
> i2c_adapter i2c-0: bus is not idle. status is 0xff
> i2c_adapter i2c-0: found normal entry for adapter 0, addr 0x23
> i2c_adapter i2c-0: master_xfer[0] W, addr=0x23, len=0
> i2c_adapter i2c-0: bus is not idle. status is 0xff
> i2c_adapter i2c-0: found normal entry for adapter 0, addr 0x24
> i2c_adapter i2c-0: master_xfer[0] W, addr=0x24, len=0
> i2c_adapter i2c-0: bus is not idle. status is 0xff
> i2c_adapter i2c-0: found normal entry for adapter 0, addr 0x25
> i2c_adapter i2c-0: master_xfer[0] W, addr=0x25, len=0
> i2c_adapter i2c-0: bus is not idle. status is 0xff
> i2c_adapter i2c-0: found normal entry for adapter 0, addr 0x26
> i2c_adapter i2c-0: master_xfer[0] W, addr=0x26, len=0
> i2c_adapter i2c-0: bus is not idle. status is 0xff
> i2c_adapter i2c-0: found normal entry for adapter 0, addr 0x27
> i2c_adapter i2c-0: master_xfer[0] W, addr=0x27, len=0
> i2c_adapter i2c-0: bus is not idle. status is 0xff
> i2c_adapter i2c-0: found normal entry for adapter 0, addr 0x38
> i2c_adapter i2c-0: master_xfer[0] W, addr=0x38, len=0
> i2c_adapter i2c-0: bus is not idle. status is 0xff
> i2c_adapter i2c-0: found normal entry for adapter 0, addr 0x39
> i2c_adapter i2c-0: master_xfer[0] W, addr=0x39, len=0
> i2c_adapter i2c-0: bus is not idle. status is 0xff
> i2c_adapter i2c-0: found normal entry for adapter 0, addr 0x3a
> i2c_adapter i2c-0: master_xfer[0] W, addr=0x3a, len=0
> i2c_adapter i2c-0: bus is not idle. status is 0xff
> i2c_adapter i2c-0: found normal entry for adapter 0, addr 0x3b
> i2c_adapter i2c-0: master_xfer[0] W, addr=0x3b, len=0
> i2c_adapter i2c-0: bus is not idle. status is 0xff
> i2c_adapter i2c-0: found normal entry for adapter 0, addr 0x3c
> i2c_adapter i2c-0: master_xfer[0] W, addr=0x3c, len=0
> i2c_adapter i2c-0: bus is not idle. status is 0xff
> i2c_adapter i2c-0: found normal entry for adapter 0, addr 0x3d
> i2c_adapter i2c-0: master_xfer[0] W, addr=0x3d, len=0
> i2c_adapter i2c-0: bus is not idle. status is 0xff
> i2c_adapter i2c-0: found normal entry for adapter 0, addr 0x3e
> i2c_adapter i2c-0: master_xfer[0] W, addr=0x3e, len=0
> i2c_adapter i2c-0: bus is not idle. status is 0xff
> i2c_adapter i2c-0: found normal entry for adapter 0, addr 0x3f
> i2c_adapter i2c-0: master_xfer[0] W, addr=0x3f, len=0
> i2c_adapter i2c-0: bus is not idle. status is 0xff
> i2c-core: driver [pcf8591] registered
> i2c_adapter i2c-0: found normal entry for adapter 0, addr 0x48
> i2c_adapter i2c-0: master_xfer[0] W, addr=0x48, len=0
> i2c_adapter i2c-0: bus is not idle. status is 0xff
> i2c_adapter i2c-0: found normal entry for adapter 0, addr 0x49
> i2c_adapter i2c-0: master_xfer[0] W, addr=0x49, len=0
> i2c_adapter i2c-0: bus is not idle. status is 0xff
> i2c_adapter i2c-0: found normal entry for adapter 0, addr 0x4a
> i2c_adapter i2c-0: master_xfer[0] W, addr=0x4a, len=0
> i2c_adapter i2c-0: bus is not idle. status is 0xff
> i2c_adapter i2c-0: found normal entry for adapter 0, addr 0x4b
> i2c_adapter i2c-0: master_xfer[0] W, addr=0x4b, len=0
> i2c_adapter i2c-0: bus is not idle. status is 0xff
> i2c_adapter i2c-0: found normal entry for adapter 0, addr 0x4c
> i2c_adapter i2c-0: master_xfer[0] W, addr=0x4c, len=0
> i2c_adapter i2c-0: bus is not idle. status is 0xff
> i2c_adapter i2c-0: found normal entry for adapter 0, addr 0x4d
> i2c_adapter i2c-0: master_xfer[0] W, addr=0x4d, len=0
> i2c_adapter i2c-0: bus is not idle. status is 0xff
> i2c_adapter i2c-0: found normal entry for adapter 0, addr 0x4e
> i2c_adapter i2c-0: master_xfer[0] W, addr=0x4e, len=0
> i2c_adapter i2c-0: bus is not idle. status is 0xff
> i2c_adapter i2c-0: found normal entry for adapter 0, addr 0x4f
> i2c_adapter i2c-0: master_xfer[0] W, addr=0x4f, len=0
> i2c_adapter i2c-0: bus is not idle. status is 0xff
> i2c-core: driver [RTC8564] registered
> i2c_adapter i2c-0: found normal entry for adapter 0, addr 0x51
> i2c_adapter i2c-0: master_xfer[0] W, addr=0x51, len=0
> i2c_adapter i2c-0: bus is not idle. status is 0xff
> 
> Is it normal that the kernel doesn't print all messages to the screen?

Yes. These are debugging messages, and you only see info and higher
level messages on the console.

> What do these messages mean? What should I do to get rid of the delay?

The "bus is not idle" messages are from i2c-algo-pca, which itself is
only used by i2c-pca-isa, so you must have compiled it into your
kernel. The other messages are from i2c-core, and suggest that you have
the eeprom, pcf8574, pcf8591 and rtc8564 drivers compiled in as well. 

The problem is that you don't have any of these devices. The
i2c-pca-isa device is almost undetectable, so the driver will register
one nevertheless, and then any access to it will fail after a timeout.
Due to the number of i2c chip drivers which you also compiled in, there
are many such accesses at boot time (when trying to detect the chips),
which cumulated give you the one minute delay you observe.

So, you should simply fix your kernel configuration. In the I2C support
section, say N to "PCA9564 on an ISA bus", "Philips PCF8574 and
PCF8574A", "Philips PCF8591" and "Epson 8564 RTC chip". In fact, don't
say Y to any I2C bus or chip driver unless you know for sure that you
have that device (and even then, M is usually prefered). This should
solve the long boot delay.

I'll submit a patch to let the user know about the problem in the
i2c-pca-isa Kconfig help text.

-- 
Jean Delvare
