Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265912AbUBPVs5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 16:48:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265911AbUBPVs5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 16:48:57 -0500
Received: from mail.ondacorp.com.br ([200.195.196.14]:715 "EHLO
	mail.ondacorp.com.br") by vger.kernel.org with ESMTP
	id S265914AbUBPVs2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 16:48:28 -0500
Message-ID: <40313AA9.1060906@arenanetwork.com.br>
Date: Mon, 16 Feb 2004 21:48:25 +0000
From: dual_bereta_r0x <dual_bereta_r0x@arenanetwork.com.br>
Organization: ArenaNetwork Lan House & Cyber
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dominik Brodowski <linux@dominikbrodowski.de>
Cc: linux-kernel@vger.kernel.org, cpufreq@www.linux.org.uk
Subject: Re: 2.6.2: P4 ClockMod speed
References: <20040216213435.GA9680@dominikbrodowski.de>
In-Reply-To: <20040216213435.GA9680@dominikbrodowski.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dominik Brodowski wrote:
> Hi,
> 
> 
>>I have a P4 2.4 running @ 3.12GHz.
> 
> 
> So you overclock your CPU but then throttle it down... strange, but well...

Actually it isn't throttled down, only sysfs is showing it with low 
speed. It *is* running @ 3.12 (or /proc/cpuinfo and boot messages are 
lying to me) when in full power.

>>In 2.6.0, i could change it frequency 
>>via speedfreqd(8) up to its actual speed. Since 2.6.1, its max speed is 
>>locked on cpu *real* speed.
> 
> 
> It's just a change of appearance -- the cpufreq driver uses the theoretical
> speed of the CPU for its calculations; the actual CPU speed isn't
> affected. You can verify this by looking at /proc/cpuinfo which still tells
> 3124.376 MHz.
> 
> By doing so it becomes easier to enter different frequencies e.g. into
> /sys/devices/system/cpu/cpufreq/scaling_setspeed -- on my desktop, typing in
> 1200000 is easier than 12121224... [*]

Sure but if i want to downgrade it, for example, by night, to a lower 
speed, and then next day return it to full power? Will I stuck at 2.4GHz?

> 	Dominik
> 
> [*] The _actual_ CPU speed should be used on all cpufreq drivers where this
> specific CPU frequency has implications to external components, e.g. LCD,
> memory or pcmcia devices. Where only the _frequency ratio_ is of importance
> [for loops_per_jiffy and friends] such "rounding" is acceptable, as long as
> the ratio is constant.

Indeed. I'll showing in LCD a lower speed than the running.

-- 
dual_bereta_r0x -- Alexandre Hautequest
ArenaNetwork Lan House & Cyber -- www.arenanetwork.com.br

Três anéis para os Reis Élficos sob este céu,
    Sete para os Senhores-Anões em seus rochosos corredores,
Nove para Homens Mortais, fadados ao eternos sono,
    Um para o Senhor do Escuro em seu escuro trono
Na Terra de Mordor onde as Sombras se deitam.
    Um Anel para a todos governar, Um Anel para encontrá-los,
    Um Anel para a todos trazer e na escuridão aprisioná-los
Na Terra de Mordor onde as Sombras se deitam.
