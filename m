Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317018AbSF0Xlb>; Thu, 27 Jun 2002 19:41:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317020AbSF0Xla>; Thu, 27 Jun 2002 19:41:30 -0400
Received: from mailout07.sul.t-online.com ([194.25.134.83]:43987 "EHLO
	mailout07.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S317018AbSF0Xl3>; Thu, 27 Jun 2002 19:41:29 -0400
Date: Fri, 28 Jun 2002 01:43:40 +0200
From: Tobias Diedrich <ranma@gmx.at>
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: another way to activate AMD disconnect on VIA KT266 (aka cooling bits)
Message-ID: <20020627234340.GA7995@router.ranmachan.dyndns.org>
Mail-Followup-To: Tobias Diedrich <ranma@gmx.at>,
	LKML <linux-kernel@vger.kernel.org>
References: <20020626212659.GA3565@utx.vol.cz> <200206272052.g5RKqOe01878@adsl-209-76-109-63.dsl.snfc21.pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200206272052.g5RKqOe01878@adsl-209-76-109-63.dsl.snfc21.pacbell.net>
User-Agent: Mutt/1.4i
X-Accept-Language: en; q=1.0, de; q=0.9, ja; q=0.1
X-Operating-System: Linux 2.4.19-pre8-ac5
X-PGP-Key: 0x9AC7E0BC
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wayne Whitney wrote:

> Well, from a WPCREDIT file I found floating around the net
> (11063099.pcr):
> 
> [70:2]=PCI Master Read Buffering  0=disable  1=enable
> [92:7]=Disc when STPGNT# Detect   0=disable  1=enable
> [95:1]=HALT Command Detect        0=disable  1=enable

Didn't know about register 70 until now, but I don't seem to need it...

I've been enabling this in a boot script (setpci -d 1106:3099 92=f9 95=1a)
ever since I bought the Board (Asus A7V266E with Athlon XP1700+).

Both the Enermax 300W powersupply and the power regulators on the Asus
board seem to take the extra stress well enough.
Temperature drops from ~70 degree to ~50 degree (which the board
measures using an external sensors, not the cpu diode), however
I'm shutting down the system every so often and because of that
my uptime is seldom more than 7 days and I can't say much about long
time stability. (Well, at the moment at least)

The TV Card does not like this at all, both the extra noise on the power
lines and the increased latency the PCI bus seems to have when this is
enabled. When I'm using the pci soundcard at the same time, whole
scanlines get missed.  If I do a hdparm -tT /dev/hda in addition to that
I can reliably crash the system as long as this is enabled.
I also see a visible performance drop for the network card. (But not too
much, maybe 10%)

-- 
Tobias								PGP: 0x9AC7E0BC
Shortly into her spell, the No-Camping Enforcer appeared behind her, again
unnoticed by Sakura.
