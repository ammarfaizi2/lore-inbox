Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262295AbVAOQWz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262295AbVAOQWz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 11:22:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262297AbVAOQWz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 11:22:55 -0500
Received: from [195.110.122.101] ([195.110.122.101]:22410 "EHLO
	cadalboia.ferrara.linux.it") by vger.kernel.org with ESMTP
	id S262295AbVAOQWt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 11:22:49 -0500
From: Simone Piunno <pioppo@ferrara.linux.it>
To: "Jean Delvare" <khali@linux-fr.org>
Subject: Re: 2.6.10-mm2: it87 sensor driver stops CPU fan
Date: Sat, 15 Jan 2005 16:54:45 +0100
User-Agent: KMail/1.7.2
Cc: "Greg KH" <greg@kroah.com>, "Jonas Munsin" <jmunsin@iki.fi>, djg@pdp8.net,
       "LM Sensors" <sensors@stimpy.netroedge.com>,
       "LKML" <linux-kernel@vger.kernel.org>
References: <g7Idbr9m.1105713630.9207120.khali@localhost>
In-Reply-To: <g7Idbr9m.1105713630.9207120.khali@localhost>
X-Key-URL: http://members.ferrara.linux.it/pioppo/mykey.asc
X-Key-FP: 9C15F0D3E3093593AC952C92A0CD52B4860314FC
X-Key-ID: 860314FC/C09E842C
X-Message: GnuPG/PGP5 are welcome
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501151654.46412.pioppo@ferrara.linux.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 14 January 2005 15:40, Jean Delvare wrote:

> Kernel 2.6.11-rc1-mm1 is just out, which does contain the latest updates
> to the it87 driver. I would like you to test them. What you should see:
> 1* When loading the it87 driver, the fans should not change speeds.

confirmed.

> 2* In the logs, you should see an information line with the chip type,
> address and revision.
> 3* Still in the logs, you should see a warning about your BIOS being
> broken and PWM being disabled as a consequence.

Confirmed, but it looks like there's a missing linefeed in the warning.

pioppo@roentgen ~ $ uname -a
Linux roentgen 2.6.11-rc1-mm1 #1 Sat Jan 15 16:23:34 CET 2005 x86_64 AMD 
Athlon(tm) 64 Processor 3200+ AuthenticAMD GNU/Linux
pioppo@roentgen ~ $ dmesg|grep it87
it87: Found IT8705F chip at 0x290, revision 2
it87 0-0290: detected broken BIOS defaults, disabling pwm interface<6>8139too 
Fast Ethernet driver 0.9.27

> 4* PWM interface should NOT be available in sysfs.

confirmed.

pioppo@roentgen ~ $ ls /sys/devices/platform/i2c-0/0-0290
alarms        fan3_div    in2_input  in5_input  in8_input    temp2_min
detach_state  fan3_input  in2_max    in5_max    name         temp2_type
driver        fan3_min    in2_min    in5_min    power        temp3_input
fan1_div      in0_input   in3_input  in6_input  temp1_input  temp3_max
fan1_input    in0_max     in3_max    in6_max    temp1_max    temp3_min
fan1_min      in0_min     in3_min    in6_min    temp1_min    temp3_type
fan2_div      in1_input   in4_input  in7_input  temp1_type
fan2_input    in1_max     in4_max    in7_max    temp2_input
fan2_min      in1_min     in4_min    in7_min    temp2_max

/Simone

-- 
http://thisurlenablesemailtogetthroughoverzealousspamfilters.org
