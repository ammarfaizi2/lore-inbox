Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129075AbRBNR3G>; Wed, 14 Feb 2001 12:29:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129107AbRBNR25>; Wed, 14 Feb 2001 12:28:57 -0500
Received: from sportingbet.gw.dircon.net ([195.157.147.30]:57101 "HELO
	sysadmin.sportingbet.com") by vger.kernel.org with SMTP
	id <S129075AbRBNR2i>; Wed, 14 Feb 2001 12:28:38 -0500
Date: Wed, 14 Feb 2001 17:26:07 +0000
From: Sean Hunter <sean@dev.sportingbet.com>
To: Carlos Carvalho <carlos@fisica.ufpr.br>
Cc: jbglaw@lug-owl.de, linux-kernel@vger.kernel.org,
        axp-hardware@talisman.alphalinux.org
Subject: Re: Alpha: bad unaligned access handling
Message-ID: <20010214172607.E11048@dev.sportingbet.com>
Mail-Followup-To: Sean Hunter <sean@dev.sportingbet.com>,
	Carlos Carvalho <carlos@fisica.ufpr.br>, jbglaw@lug-owl.de,
	linux-kernel@vger.kernel.org, axp-hardware@talisman.alphalinux.org
In-Reply-To: <20010214154808.A15974@lug-owl.de> <14986.48181.55212.358637@hoggar.fisica.ufpr.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <14986.48181.55212.358637@hoggar.fisica.ufpr.br>; from carlos@fisica.ufpr.br on Wed, Feb 14, 2001 at 03:11:17PM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 14, 2001 at 03:11:17PM -0200, Carlos Carvalho wrote:
> Jan-Benedict Glaw (jbglaw@lug-owl.de) wrote on 14 February 2001 15:48:
>  >With my currently installed ping (netkit-ping 0.10-6 from Debian Woody)
>  >I get unaligned accesses:
>  >
>  >ping(15953): unaligned trap at 00000001200030e4: 0000000120026b34 29 1
>  >ping(15953): unaligned trap at 0000000120003110: 0000000120026b2c 29 2
>  >
>  >The worse part is: they seem to be handled The Wrong Way:
>  >
>  >[jbglaw@air:/home/jbglaw] $> ping -c 1 localhost
>  >PING localhost (127.0.0.1): 56 data bytes
>  >64 bytes from 127.0.0.1: icmp_seq=0 ttl=255 time=13.8 ms
>  >wrong data byte #8 should be 0x8 but was 0xdc
>  >        c d e f 10 11 12 13 14 15 16 17 18 19 1a 1b 1c 1d 1e 1f 20 21 22 23 24 25 26 27 28 29 2a 2b 
>  >        2c 2d 2e 2f 0 0 0 0 0 0 0 0 0 0 0 0 
>  >
>  >--- localhost ping statistics ---
>  >1 packets transmitted, 1 packets received, 0% packet loss
>  >round-trip min/avg/max = 13.8/13.8/13.8 ms
>  >
>  >
>  >This is on a NoName Alpha box, running 2.4.0-test8-pre1 (with very good
>  >uptimes), but I think 2.4.2-pre2 would do the same (wrong) things as
>  >arch/alpha/kernel/traps.c wasn't really changed since ages...
> 
> I also get these, with 2.2.18pre5 (plus some Andrea patches) and
> vanilla 2.2.19pre10 on a SMP UP2000.

This is an application problem, not a kernel one.  You need to upgrade your
netkit.

Sean

P.S.  I wrote a small wrapper to aid in the debugging of unaligned traps, which
I'll send to anyone who's interested.

> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
