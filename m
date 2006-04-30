Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751146AbWD3PK4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751146AbWD3PK4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Apr 2006 11:10:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751148AbWD3PK4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Apr 2006 11:10:56 -0400
Received: from 84-72-61-190.dclient.hispeed.ch ([84.72.61.190]:30365 "EHLO
	kestrel.twibright.com") by vger.kernel.org with ESMTP
	id S1751146AbWD3PKz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Apr 2006 11:10:55 -0400
Date: Sun, 30 Apr 2006 16:18:30 +0200
From: Karel Kulhavy <clock@twibright.com>
To: linux-kernel@vger.kernel.org
Subject: i2c-related 1-minute hang during bootup
Message-ID: <20060430141829.GA9546@kestrel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Orientation: Gay
X-Stance: Goofy
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

I upgraded my kernel from 2.6.12 to 2.6.16.11 using make oldconfig.
My machine is DELL Inspiron 510m laptop. Before everything was OK.
Now the kernel hangs for a minute during bootup between the messages
"input: AlpsPS/2 ALPS GlidePoint as /class/input/input2"
and "Advanced Linux Sound Architecture Driver Version 1.0.11rc2 (Wed Jan
04 08:57:20 2006 U
TC)."

During the bootup nothing is printed during the hang, but dmesg contains
this at that point:
i2c_adapter i2c-0: bus is not idle. status is 0xff
i2c_adapter i2c-0: found normal entry for adapter 0, addr 0x51
i2c_adapter i2c-0: master_xfer[0] W, addr=0x51, len=0
i2c_adapter i2c-0: bus is not idle. status is 0xff
i2c_adapter i2c-0: found normal entry for adapter 0, addr 0x52
i2c_adapter i2c-0: master_xfer[0] W, addr=0x52, len=0
i2c_adapter i2c-0: bus is not idle. status is 0xff
i2c_adapter i2c-0: found normal entry for adapter 0, addr 0x53
i2c_adapter i2c-0: master_xfer[0] W, addr=0x53, len=0
i2c_adapter i2c-0: bus is not idle. status is 0xff
i2c_adapter i2c-0: found normal entry for adapter 0, addr 0x54
i2c_adapter i2c-0: master_xfer[0] W, addr=0x54, len=0
i2c_adapter i2c-0: bus is not idle. status is 0xff
i2c_adapter i2c-0: found normal entry for adapter 0, addr 0x55
i2c_adapter i2c-0: master_xfer[0] W, addr=0x55, len=0
i2c_adapter i2c-0: bus is not idle. status is 0xff
i2c_adapter i2c-0: found normal entry for adapter 0, addr 0x56
i2c_adapter i2c-0: master_xfer[0] W, addr=0x56, len=0
i2c_adapter i2c-0: bus is not idle. status is 0xff
i2c_adapter i2c-0: found normal entry for adapter 0, addr 0x57
i2c_adapter i2c-0: master_xfer[0] W, addr=0x57, len=0
i2c_adapter i2c-0: bus is not idle. status is 0xff
i2c-core: driver [pcf8574] registered
i2c_adapter i2c-0: found normal entry for adapter 0, addr 0x20
i2c_adapter i2c-0: master_xfer[0] W, addr=0x20, len=0
i2c_adapter i2c-0: bus is not idle. status is 0xff
i2c_adapter i2c-0: found normal entry for adapter 0, addr 0x21
i2c_adapter i2c-0: master_xfer[0] W, addr=0x21, len=0
i2c_adapter i2c-0: bus is not idle. status is 0xff
i2c_adapter i2c-0: found normal entry for adapter 0, addr 0x22
i2c_adapter i2c-0: master_xfer[0] W, addr=0x22, len=0
i2c_adapter i2c-0: bus is not idle. status is 0xff
i2c_adapter i2c-0: found normal entry for adapter 0, addr 0x23
i2c_adapter i2c-0: master_xfer[0] W, addr=0x23, len=0
i2c_adapter i2c-0: bus is not idle. status is 0xff
i2c_adapter i2c-0: found normal entry for adapter 0, addr 0x24
i2c_adapter i2c-0: master_xfer[0] W, addr=0x24, len=0
i2c_adapter i2c-0: bus is not idle. status is 0xff
i2c_adapter i2c-0: found normal entry for adapter 0, addr 0x25
i2c_adapter i2c-0: master_xfer[0] W, addr=0x25, len=0
i2c_adapter i2c-0: bus is not idle. status is 0xff
i2c_adapter i2c-0: found normal entry for adapter 0, addr 0x26
i2c_adapter i2c-0: master_xfer[0] W, addr=0x26, len=0
i2c_adapter i2c-0: bus is not idle. status is 0xff
i2c_adapter i2c-0: found normal entry for adapter 0, addr 0x27
i2c_adapter i2c-0: master_xfer[0] W, addr=0x27, len=0
i2c_adapter i2c-0: bus is not idle. status is 0xff
i2c_adapter i2c-0: found normal entry for adapter 0, addr 0x38
i2c_adapter i2c-0: master_xfer[0] W, addr=0x38, len=0
i2c_adapter i2c-0: bus is not idle. status is 0xff
i2c_adapter i2c-0: found normal entry for adapter 0, addr 0x39
i2c_adapter i2c-0: master_xfer[0] W, addr=0x39, len=0
i2c_adapter i2c-0: bus is not idle. status is 0xff
i2c_adapter i2c-0: found normal entry for adapter 0, addr 0x3a
i2c_adapter i2c-0: master_xfer[0] W, addr=0x3a, len=0
i2c_adapter i2c-0: bus is not idle. status is 0xff
i2c_adapter i2c-0: found normal entry for adapter 0, addr 0x3b
i2c_adapter i2c-0: master_xfer[0] W, addr=0x3b, len=0
i2c_adapter i2c-0: bus is not idle. status is 0xff
i2c_adapter i2c-0: found normal entry for adapter 0, addr 0x3c
i2c_adapter i2c-0: master_xfer[0] W, addr=0x3c, len=0
i2c_adapter i2c-0: bus is not idle. status is 0xff
i2c_adapter i2c-0: found normal entry for adapter 0, addr 0x3d
i2c_adapter i2c-0: master_xfer[0] W, addr=0x3d, len=0
i2c_adapter i2c-0: bus is not idle. status is 0xff
i2c_adapter i2c-0: found normal entry for adapter 0, addr 0x3e
i2c_adapter i2c-0: master_xfer[0] W, addr=0x3e, len=0
i2c_adapter i2c-0: bus is not idle. status is 0xff
i2c_adapter i2c-0: found normal entry for adapter 0, addr 0x3f
i2c_adapter i2c-0: master_xfer[0] W, addr=0x3f, len=0
i2c_adapter i2c-0: bus is not idle. status is 0xff
i2c-core: driver [pcf8591] registered
i2c_adapter i2c-0: found normal entry for adapter 0, addr 0x48
i2c_adapter i2c-0: master_xfer[0] W, addr=0x48, len=0
i2c_adapter i2c-0: bus is not idle. status is 0xff
i2c_adapter i2c-0: found normal entry for adapter 0, addr 0x49
i2c_adapter i2c-0: master_xfer[0] W, addr=0x49, len=0
i2c_adapter i2c-0: bus is not idle. status is 0xff
i2c_adapter i2c-0: found normal entry for adapter 0, addr 0x4a
i2c_adapter i2c-0: master_xfer[0] W, addr=0x4a, len=0
i2c_adapter i2c-0: bus is not idle. status is 0xff
i2c_adapter i2c-0: found normal entry for adapter 0, addr 0x4b
i2c_adapter i2c-0: master_xfer[0] W, addr=0x4b, len=0
i2c_adapter i2c-0: bus is not idle. status is 0xff
i2c_adapter i2c-0: found normal entry for adapter 0, addr 0x4c
i2c_adapter i2c-0: master_xfer[0] W, addr=0x4c, len=0
i2c_adapter i2c-0: bus is not idle. status is 0xff
i2c_adapter i2c-0: found normal entry for adapter 0, addr 0x4d
i2c_adapter i2c-0: master_xfer[0] W, addr=0x4d, len=0
i2c_adapter i2c-0: bus is not idle. status is 0xff
i2c_adapter i2c-0: found normal entry for adapter 0, addr 0x4e
i2c_adapter i2c-0: master_xfer[0] W, addr=0x4e, len=0
i2c_adapter i2c-0: bus is not idle. status is 0xff
i2c_adapter i2c-0: found normal entry for adapter 0, addr 0x4f
i2c_adapter i2c-0: master_xfer[0] W, addr=0x4f, len=0
i2c_adapter i2c-0: bus is not idle. status is 0xff
i2c-core: driver [RTC8564] registered
i2c_adapter i2c-0: found normal entry for adapter 0, addr 0x51
i2c_adapter i2c-0: master_xfer[0] W, addr=0x51, len=0
i2c_adapter i2c-0: bus is not idle. status is 0xff

Is it normal that the kernel doesn't print all messages to the screen?
What do these messages mean? What should I do
to get rid of the delay?

CL<
"
