Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261760AbSIXTtc>; Tue, 24 Sep 2002 15:49:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261767AbSIXTtc>; Tue, 24 Sep 2002 15:49:32 -0400
Received: from cc78409-a.hnglo1.ov.home.nl ([212.120.97.185]:32787 "EHLO
	dexter.hensema.net") by vger.kernel.org with ESMTP
	id <S261760AbSIXTtb>; Tue, 24 Sep 2002 15:49:31 -0400
From: Erik Hensema <usenet@hensema.xs4all.nl>
Subject: Re: via-rhine, VT6103 and VT8235
Date: Tue, 24 Sep 2002 19:54:42 +0000 (UTC)
Message-ID: <slrnap1go1.1nc.usenet@bender.home.hensema.net>
References: <JOGPEBMEIODLJAAA@mailcity.com> <20020923210112.GA423@k3.hellgate.ch>
Reply-To: erik@hensema.xs4all.nl
User-Agent: slrn/0.9.7.4 (Linux)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roger Luethi (rl@hellgate.ch) wrote:
> On Mon, 23 Sep 2002 20:17:38 +0100, svetljo wrote:
>> Hi just found previous report about my troubles
>> dating 2002-07-20
>> http://marc.theaimsgroup.com/?l=linux-kernel&m=102718248323184&w=2
>> 
>> ETDEV WATCHDOG: eth1: transmit timed out
>> eth1: Transmit timed out, status 0000, PHY status 786d, resetting...
> [...]
>> mobo EPoX 8K5A-3+ KT333 + VT8235 2.4.19-pre10jam3(with/without the fix) 
>> couldn't find 2.4.20-pre7 with SGI's xfs :( to test
> 
> Beautiful. Now that the regular Rhine chips seem to work it's all those VIA
> wonder south bridges. I'm currently swamped with work but I'll hopefully
> have a driver with additional fixes ready in a two or three weeks time
> frame (unless somebody beats me to it).
> 
>> so i wanted to ask whether someone has it working
>> and if there is a newer fix? :)
> 
> The VT823x are still a problem. I added your report to my list. Thx.

I've got a VT6105 Rhine-III card (an actual PCI card, not embedded on my
mobo). It works fine with SuSE's 2.4.18 kernel (the driver seems unpatched
in that kernel), but it gives transmit timed out errors in 2.4.20pre7. No
data hits the wire at all.

This is kernel 2.4.20pre7:

| via-rhine.c:v1.10-LK1.1.14  May-3-2002  Written by Donald Becker
|   http://www.scyld.com/network/via-rhine.html
| eth0: VIA VT6105 Rhine-III at 0xd000, 00:40:f4:5f:94:d6, IRQ 16.
| eth0: MII PHY found at address 1, status 0x7869 advertising 05e1 Link 45e1.
| eth0: Setting full-duplex based on MII #1 link partner capability of 45e1.
| NETDEV WATCHDOG: eth0: transmit timed out
| eth0: Transmit timed out, status 0003, PHY status 786d, resetting...

And this is 2.4.18-4GB (SuSE 8.0 standard kernel):

| via-rhine.c:v1.10-LK1.1.13  Nov-17-2001  Written by Donald Becker
|   http://www.scyld.com/network/via-rhine.html
| PCI: Found IRQ 11 for device 00:0d.0
| eth0: VIA VT6105 Rhine-III at 0xcc00, 00:40:f4:5f:94:d6, IRQ 11.
| eth0: MII PHY found at address 1, status 0x786d advertising 05e1 Link 45e1.
| eth0: Setting full-duplex based on MII #1 link partner capability of 45e1.

Note that I've got local APIC support compiled in on the 2.4.20 kernel.
Could this be the cause of the problem?

It's a MSI 745 Ultra board (SiS 745 based).

The NIC is: 00:0d.0 Class 0200: 1106:3106 (rev 85)

-- 
Erik Hensema (erik@hensema.net)
