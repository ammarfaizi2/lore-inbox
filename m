Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282070AbRKVIXU>; Thu, 22 Nov 2001 03:23:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282071AbRKVIXK>; Thu, 22 Nov 2001 03:23:10 -0500
Received: from aragorn.ics.muni.cz ([147.251.4.33]:58528 "EHLO
	aragorn.ics.muni.cz") by vger.kernel.org with ESMTP
	id <S282070AbRKVIXD>; Thu, 22 Nov 2001 03:23:03 -0500
Date: Thu, 22 Nov 2001 09:23:00 +0100
From: Jan Kasprzak <kas@informatics.muni.cz>
To: Bernd Eckenfels <ecki@lina.inka.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: VM tuning for Linux routers
Message-ID: <20011122092300.D2421@informatics.muni.cz>
In-Reply-To: <20011117134127.A8041@se1.cogenit.fr> <E1658YH-0008Jp-00@calista.inka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <E1658YH-0008Jp-00@calista.inka.de>; from ecki@lina.inka.de on Sat, Nov 17, 2001 at 05:42:45PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernd Eckenfels wrote:
: Most important you can configure the
: kernel for large window sizes and advanced routing.

	Advanced routing is a feature tuning, not a performance one, I think
(yes, I have advanced routing configured in - I use the "ip rule" mechanism
for simple filtering. It is faster than iptables, because it uses the
routing cache).

	Large window sizes do matter only for TCP servers, not for
an IP router/firewall, I think. The only TCP my firewall does itself
is incoming ssh and outgoing smtp messages from my IDS.

: > However you can increase the length of the Rx/Tx rings on the 100Mb/s side 
: > and tune the pci latency timers (depends on the hardware fifo size). 
: 
: Increasing rx/rx rings is not a particular good idea cause it slows down
: TCPs adaption to network congestion and router overload.

	OK. I have the following:

/proc/sys/net/core/optmem_max	10240
/proc/sys/net/core/rmem_default	65535
/proc/sys/net/core/rmem_max	131071
/proc/sys/net/core/wmem_default	65535
/proc/sys/net/core/wmem_max	131071

	I can surely increase rmem_max, wmem_max (and _default).
What is the optmem_max? What is the difference between [rw]mem_max
and _default?

-Yenya

-- 
| Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - private}> |
| GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18A5E |
| http://www.fi.muni.cz/~kas/   Czech Linux Homepage: http://www.linux.cz/ |
               #include <stdio.h>
               int main(void) { printf("\t\b\b"); return 0; }
