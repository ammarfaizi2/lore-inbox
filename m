Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261190AbVBLTgE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261190AbVBLTgE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Feb 2005 14:36:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261192AbVBLTgE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Feb 2005 14:36:04 -0500
Received: from mail02.hansenet.de ([213.191.73.62]:51096 "EHLO
	webmail.hansenet.de") by vger.kernel.org with ESMTP id S261190AbVBLTfx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Feb 2005 14:35:53 -0500
Message-ID: <420E5AAD.7080206@web.de>
Date: Sat, 12 Feb 2005 20:36:13 +0100
From: Marcus Hartig <m.f.h@web.de>
User-Agent: Mozilla Thunderbird  (X11/20041216)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: How to disable slow agpgart in kernel config?
References: <420E4812.7000006@web.de> <1108232773.4056.120.camel@localhost.localdomain>
In-Reply-To: <1108232773.4056.120.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:

> hmm I wonder.. .could you collect lspci -vxxx settings for the AGP
> device (lspci -vxxx gives you lots of devices, but only one is relevant)
> in both cases, maybe the difference between the two shows something
> useful...

Hmmm...only the latency at the VGA card.

With AGPGART:

01:00.0 VGA compatible controller: nVidia Corporation NV35 [GeForce FX 
5900] (rev a1) (prog-if 00 [VGA])
         Flags: bus master, 66Mhz, medium devsel, latency 32, IRQ 5
         Memory at e0000000 (32-bit, non-prefetchable) [size=16M]
         Memory at d8000000 (32-bit, prefetchable) [size=128M]
         Capabilities: [60] Power Management version 2
         Capabilities: [44] AGP version 3.0
00: de 10 31 03 07 00 b0 02 a1 00 00 03 00 20 00 00
10: 00 00 00 e0 08 00 00 d8 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 60 00 00 00 00 00 00 00 05 01 05 01
40: 00 00 00 00 02 00 30 00 1b 0e 00 1f 00 00 00 00
50: 01 00 00 00 01 00 00 00 ce d6 23 00 0f 00 00 00
60: 01 44 02 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

With NV_AGP:

01:00.0 VGA compatible controller: nVidia Corporation NV35 [GeForce FX 
5900] (rev a1) (prog-if 00 [VGA])
         Flags: bus master, 66Mhz, medium devsel, latency 248, IRQ 5
         Memory at e0000000 (32-bit, non-prefetchable) [size=16M]
         Memory at d8000000 (32-bit, prefetchable) [size=128M]
         Capabilities: [60] Power Management version 2
         Capabilities: [44] AGP version 3.0
00: de 10 31 03 07 00 b0 02 a1 00 00 03 00 f8 00 00
10: 00 00 00 e0 08 00 00 d8 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 60 00 00 00 00 00 00 00 05 01 05 01
40: 00 00 00 00 02 00 30 00 1b 0e 00 1f 02 43 00 1f
50: 01 00 00 00 01 00 00 00 ce d6 23 00 0f 00 00 00
60: 01 44 02 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00


Both complete output: http://www.marcush.de/bench/

Greetings,
Marcus
