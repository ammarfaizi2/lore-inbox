Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264194AbTCXNJm>; Mon, 24 Mar 2003 08:09:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264199AbTCXNJm>; Mon, 24 Mar 2003 08:09:42 -0500
Received: from paris.xisl.com ([193.112.238.192]:11935 "EHLO paris.xisl.com")
	by vger.kernel.org with ESMTP id <S264194AbTCXNJe>;
	Mon, 24 Mar 2003 08:09:34 -0500
Message-ID: <3E7F0625.2080406@xisl.com>
Date: Mon, 24 Mar 2003 13:20:37 +0000
From: John M Collins <jmc@xisl.com>
Organization: Xi Software Ltd
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20021120 Netscape/7.01
X-Accept-Language: en-us, en-gb
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Query about SIS963 Bridges
References: <3E7E43C3.2080605@xisl.com>	 <1048467041.10727.100.camel@irongate.swansea.linux.org.uk>	 <3E7EABB0.9010505@xisl.com> <1048514988.25140.11.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>Can you try
>
>	lspci -vxx -H1 -M
>
>and see if thats different
>  
>
Here's the output

00:00.0 Host bridge: Silicon Integrated Systems [SiS]: Unknown device 
0648 (rev 02)
        Subsystem: Asustek Computer, Inc.: Unknown device 8086
        Flags: bus master, medium devsel, latency 32
        Memory at d0000000 (32-bit, non-prefetchable)
        Capabilities: [c0] AGP version 3.0
00: 39 10 48 06 07 00 10 22 02 00 00 06 00 20 80 00
10: 00 00 00 d0 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 86 80
30: 00 00 00 00 c0 00 00 00 00 00 00 00 00 00 00 00

00:01.0 PCI bridge: Silicon Integrated Systems [SiS] 5591/5592 AGP 
(prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        Memory behind bridge: cf000000-cfffffff
        Prefetchable memory behind bridge: eff00000-febfffff
00: 39 10 01 00 07 00 00 00 00 00 04 06 00 00 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 00 e0 d0 00 20
20: 00 cf f0 cf f0 ef b0 fe 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 08 00

## 00.01:0 is a bridge from 00 to 01-01        {ONLY DIFFERENT LINE}
00:02.0 ISA bridge: Silicon Integrated Systems [SiS]: Unknown device 
0963 (rev 04)
        Flags: bus master, medium devsel, latency 0
00: 39 10 63 09 0f 00 00 02 04 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

And at the end we get:

Summary of buses:

00: Primary host bus
        01.0 Bridge to 01-01
01: Entered via 00:01.0

-- 
John Collins Xi Software Ltd www.xisl.com



