Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261255AbVBMJT7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261255AbVBMJT7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Feb 2005 04:19:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261257AbVBMJT7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Feb 2005 04:19:59 -0500
Received: from mail03.hansenet.de ([213.191.73.10]:14269 "EHLO
	webmail.hansenet.de") by vger.kernel.org with ESMTP id S261255AbVBMJTz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Feb 2005 04:19:55 -0500
Message-ID: <420F1BD6.9090803@web.de>
Date: Sun, 13 Feb 2005 10:20:22 +0100
From: Marcus Hartig <m.f.h@web.de>
User-Agent: Mozilla Thunderbird  (X11/20041216)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: How to disable slow agpgart in kernel config?
References: <420E4812.7000006@web.de> <1108232773.4056.120.camel@localhost.localdomain> <420E5AAD.7080206@web.de> <20050212204707.GC18180@redhat.com>
In-Reply-To: <20050212204707.GC18180@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:

> Was there any differnces in the devices at 00:00.0 and 00:01.0 ?
> (host & pci bridges)

Only the Host bridge line c0:

With AGPGART:
00:00.0 Host bridge: nVidia Corporation: Unknown device 00e1 (rev a1)
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 0300
	Flags: bus master, 66Mhz, fast devsel, latency 0
	Memory at d0000000 (32-bit, prefetchable) [size=128M]
	Capabilities: [44] HyperTransport: Slave or Primary Interface
	Capabilities: [c0] AGP version 3.0
00: de 10 e1 00 06 00 b0 00 a1 00 00 06 00 00 00 00
10: 08 00 00 d0 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 62 14 00 03
30: 00 00 00 00 44 00 00 00 00 00 00 00 ff 00 00 00
40: 62 14 00 03 08 c0 c0 01 22 00 11 11 d0 00 00 00
50: 23 05 3f 00 03 00 00 00 00 00 00 00 00 00 00 00
60: 32 31 03 00 66 45 04 00 66 06 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 30 30 00 00 11 11 88 00
80: 13 88 88 00 c8 00 00 00 70 00 00 00 3f 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 07 00 00 00 66 00 66 00 00 00 00 00 00 00 00 00
c0: 02 00 30 00 1b 42 00 1f 01 00 00 00 ff ff ff ff
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

With NV_AGP:
00:00.0 Host bridge: nVidia Corporation: Unknown device 00e1 (rev a1)
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 0300
	Flags: bus master, 66Mhz, fast devsel, latency 0
	Memory at d0000000 (32-bit, prefetchable) [size=128M]
	Capabilities: [44] HyperTransport: Slave or Primary Interface
	Capabilities: [c0] AGP version 3.0
00: de 10 e1 00 06 00 b0 00 a1 00 00 06 00 00 00 00
10: 08 00 00 d0 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 62 14 00 03
30: 00 00 00 00 44 00 00 00 00 00 00 00 ff 00 00 00
40: 62 14 00 03 08 c0 c0 01 22 00 11 11 d0 00 00 00
50: 23 05 3f 00 03 00 00 00 00 00 00 00 00 00 00 00
60: 32 31 03 00 66 45 04 00 66 06 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 30 30 00 00 11 11 88 00
80: 13 88 88 00 c8 00 00 00 70 00 00 00 3f 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 07 00 00 00 66 00 66 00 00 00 00 00 00 00 00 00
c0: 02 00 30 00 1b 42 00 1f 02 03 00 00 ff ff ff ff
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

Greetings,
Marcus



