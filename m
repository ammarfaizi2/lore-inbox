Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267323AbSKPSMs>; Sat, 16 Nov 2002 13:12:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267326AbSKPSMr>; Sat, 16 Nov 2002 13:12:47 -0500
Received: from waste.org ([209.173.204.2]:48877 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S267323AbSKPSMr>;
	Sat, 16 Nov 2002 13:12:47 -0500
Date: Sat, 16 Nov 2002 12:18:32 -0600
From: Oliver Xymoron <oxymoron@waste.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <akpm@digeo.com>, Stelian Pop <stelian.pop@fr.alcove.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: lan based kgdb
Message-ID: <20021116181832.GG19061@waste.org>
References: <3DD5591E.A3D0506D@efi.com> <334960000.1037397999@flay> <ar3op8$f20$1@penguin.transmeta.com> <20021115222430.GA1877@tahoe.alcove-fr> <3DD57A5F.87119CB4@digeo.com> <1037414103.21922.12.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1037414103.21922.12.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 16, 2002 at 02:35:03AM +0000, Alan Cox wrote:
> 
> netdump has polled eepro100 handlers that will plug nicely into this. Of
> course you still want a protocol on top of it, but there are some tiny
> tcp implementations that are GPL (eg the Linux 8086 TCP by Harry K)

TCP is complete overkill. You don't want to run a debugging protocol
over a WAN in any case. Let's assume LAN, 1ms or less round-trip,
let's assume polling ACKs per packet so we don't have to keep a
window, UDP with hand-specified src/dst/gateway/MACs/ports.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.." 
