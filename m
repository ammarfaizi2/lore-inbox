Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261609AbVHBQL5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261609AbVHBQL5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 12:11:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261646AbVHBQJk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 12:09:40 -0400
Received: from smtp3.nextra.sk ([195.168.1.142]:32267 "EHLO mailhub3.nextra.sk")
	by vger.kernel.org with ESMTP id S261651AbVHBQIu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 12:08:50 -0400
Message-ID: <42EF9A8E.8020302@rainbow-software.org>
Date: Tue, 02 Aug 2005 18:08:46 +0200
From: Ondrej Zary <linux@rainbow-software.org>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James Bruce <bruce@andrew.cmu.edu>
CC: sclark46@earthlink.net, linux-kernel@vger.kernel.org
Subject: Re: Power consumption HZ100, HZ250, HZ1000: new numbers
References: <20050730195116.GB9188@elf.ucw.cz> <1122753864.14769.18.camel@mindpipe> <20050730201049.GE2093@elf.ucw.cz> <42ED32D3.9070208@andrew.cmu.edu> <20050731211020.GB27433@elf.ucw.cz> <42ED4CCF.6020803@andrew.cmu.edu> <20050731224752.GC27580@elf.ucw.cz> <1122852234.13000.27.camel@mindpipe> <20050801074447.GJ9841@khan.acc.umu.se> <42EE4B4A.80602@andrew.cmu.edu> <20050801204245.GC17258@thunk.org> <42EEFB9B.10508@andrew.cmu.edu> <42EF70BD.7070804@earthlink.net> <42EF947E.1070600@andrew.cmu.edu>
In-Reply-To: <42EF947E.1070600@andrew.cmu.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bruce wrote:
> Stephen Clark wrote:
> 
>> Maybe new desktop systems - but what about the tens of millions of old 
>> systems that don't.
> 
> 
> If it's an old system, it probably doesn't have working ACPI C-states 
> though.  Without that, low HZ does not save you anything.  I should have 
> said: 99% of desktops with the capability to do ACPI sleep have at least 
> one USB device attached (usually a mouse).

rainbow@pentium:~$ cat /proc/acpi/processor/CPU0/power
active state:            C2
max_cstate:              C8
bus master activity:     00000000
states:
     C1:                  type[C1] promotion[C2] demotion[--] 
latency[000] usage[00052470]
    *C2:                  type[C2] promotion[--] demotion[C1] 
latency[090] usage[02699149]


This is PCPartner TXB820DS motherboard (Socket 7, i430TX) with 1998 
Award BIOS and C-states seem to work fine. I've tested it in Windows 98 
some time ago - the CPU is almost cold when idle with ACPI enabled and 
hot with ACPI disabled (that's partly caused by the fact that Windows 9x 
does not HLT the CPU when idle). With Pentium 100MHz in the socket and 
ACPI enabled, I could even touch the CPU (without heatsink) without 
burning my fingers.

-- 
Ondrej Zary
