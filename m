Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313571AbSHFQrB>; Tue, 6 Aug 2002 12:47:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313687AbSHFQq6>; Tue, 6 Aug 2002 12:46:58 -0400
Received: from mail.hometree.net ([212.34.181.120]:57557 "EHLO
	mail.hometree.net") by vger.kernel.org with ESMTP
	id <S313571AbSHFQqz>; Tue, 6 Aug 2002 12:46:55 -0400
To: linux-kernel@vger.kernel.org
Path: forge.intermeta.de!not-for-mail
From: "Henning P. Schmiedehausen" <hps@intermeta.de>
Newsgroups: hometree.linux.kernel
Subject: Re: 2.4.19-ac4 IRQ messup?
Date: Tue, 6 Aug 2002 16:50:33 +0000 (UTC)
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
Message-ID: <aiouop$5ut$1@forge.intermeta.de>
References: <Pine.LNX.4.44.0208052251170.21076-100000@korben.citd.de> <200208061139.35323.tmi@wikon.de> <20020806100101.GA20758@alpha.home.local> <200208061643.56773.tmi@wikon.de>
Reply-To: hps@intermeta.de
NNTP-Posting-Host: forge.intermeta.de
X-Trace: tangens.hometree.net 1028652633 11282 212.34.181.4 (6 Aug 2002 16:50:33 GMT)
X-Complaints-To: news@intermeta.de
NNTP-Posting-Date: Tue, 6 Aug 2002 16:50:33 +0000 (UTC)
X-Copyright: (C) 1996-2002 Henning Schmiedehausen
X-No-Archive: yes
X-Newsreader: NN version 6.5.1 (NOV)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Mierau <tmi@wikon.de> writes:

>I switched cables, checked the switch etc....
>nothing helps.
>I installed an extra PCI card which came up as eth0, making the internal ones 
>eth1 and eth2. No I started pinging with eth0, which was giving me strange 
>effects again.
>eth0 = 192.168.47.11
>eth1 = 192.168.47.12
>eth2 = 192.168.47.13
>I took a tcpdump on the receiving box. It was kind of interesting.
>There were arp packages askin who is 192.168.47.11 and answers coming back 
>with two dofferent MAC-Id's One from the eth0 and the other one from the eth2 
>which was actually configured on  IP .13
> After I shut down etho1 and 2 and ran the box with "noapic" it preforms 
>perfect with the external card.
>Either the NIC's are broken, or the driver  or whatever. I hate that !!

Are they all on the same ethernet? If yes, then

a) don't do this
b) try echo "1"> /proc/sys/net/ipv4/conf/all/arp_filter

	Regards
		Henning

-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- Geschaeftsfuehrer
INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de

Am Schwabachgrund 22  Fon.: 09131 / 50654-0   info@intermeta.de
D-91054 Buckenhof     Fax.: 09131 / 50654-20   
