Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267853AbTBVIjw>; Sat, 22 Feb 2003 03:39:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267855AbTBVIjw>; Sat, 22 Feb 2003 03:39:52 -0500
Received: from ce06d.unt0.torres.ka0.zugschlus.de ([212.126.206.6]:39684 "EHLO
	torres.ka0.zugschlus.de") by vger.kernel.org with ESMTP
	id <S267853AbTBVIju>; Sat, 22 Feb 2003 03:39:50 -0500
Date: Sat, 22 Feb 2003 09:49:58 +0100
From: Marc Haber <mh+linux-kernel@zugschlus.de>
To: linux-kernel@vger.kernel.org
Subject: ethernet-ATM-Router freezing
Message-ID: <20030222084958.GC23827@torres.ka0.zugschlus.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

we use Linux to terminate ATM PVCs and to move the traffic coming in
on the ATM link to Ethernet. We have two parallel machines with
identical hardware (about two years old), in a Debian GNU/Linux setup
built in November 2002. Current kernel is 2.4.20-ac1, and the setup
hasn't been touched since December 2002. One of the machines does the
work, while the other is waiting to be activated in case of failure.
Max load is about 6 Mbit, the machines are mostly idle. At least I
won't call them loaded.

A few days ago, the "active" machine has started spontaneously
freezing. The freezes don't happen at times with especially high or
low load, they don't happan during the same time of day. The freezes
are complete:
- no network respose on the ATM link
- no network response on the Ethernet link
- no response at all on the system console
- no error or panic messages on the console
- no response to Magic SysRq
- atsar doesn't show any strange patterns in CPU/memory usage
- syslog doesn't show anything strange
- mrtg doesn't show anything strange in network load

Reset button is needed to revive the frozen box.

These freezes occur on the machine actually doing the work. If I move
the work to the other box, the freezes go with the work. Thus, I am
pretty confident that this is not faulty hardware. I don't believe
either that this is a incompatibility of the kernel since the systems
in question have been working in this software configuration for two
months before the problems started.

Are there any known problems in the current ATM code that might cause
these freezes? Any other kernel versions I could try?

I am currently thinking about splitting the load between both boxes,
and downgrading one of them to a 2.4.19 or 2.4.18 kernel, and
upgrading the other one to a 2.4.21pre kernel. Have there been any
relevant changes to the ATM code recently?

Any hints will be appreciated. Thanks!

Cheers
Marc

-- 
-----------------------------------------------------------------------------
Marc Haber         | "I don't trust Computers. They | Mailadresse im Header
Karlsruhe, Germany |  lose things."    Winona Ryder | Fon: *49 721 966 32 15
Nordisch by Nature |  How to make an American Quilt | Fax: *49 721 966 31 29
