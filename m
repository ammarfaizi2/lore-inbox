Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278924AbRKANjt>; Thu, 1 Nov 2001 08:39:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278928AbRKANjj>; Thu, 1 Nov 2001 08:39:39 -0500
Received: from tangens.hometree.net ([212.34.181.34]:54447 "EHLO
	mail.hometree.net") by vger.kernel.org with ESMTP
	id <S278924AbRKANj3>; Thu, 1 Nov 2001 08:39:29 -0500
To: linux-kernel@vger.kernel.org
Path: forge.intermeta.de!not-for-mail
From: "Henning P. Schmiedehausen" <mailgate@hometree.net>
Newsgroups: hometree.linux.kernel
Subject: Re: Intel EEPro 100 with kernel drivers
Date: Thu, 1 Nov 2001 13:39:27 +0000 (UTC)
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
Message-ID: <9rrjaf$iq5$1@forge.intermeta.de>
In-Reply-To: <20011029021339.B23985@stud.ntnu.no> <3BDCD06E.8AF8FF69@pobox.com> <20011031090125.B10751@stud.ntnu.no> <15yzpC-26N6dEC@fwd04.sul.t-online.com>
Reply-To: hps@intermeta.de
NNTP-Posting-Host: forge.intermeta.de
X-Trace: tangens.hometree.net 1004621967 32031 212.34.181.4 (1 Nov 2001 13:39:27 GMT)
X-Complaints-To: news@intermeta.de
NNTP-Posting-Date: Thu, 1 Nov 2001 13:39:27 +0000 (UTC)
X-Copyright: (C) 1996-2001 Henning Schmiedehausen
X-No-Archive: yes
X-Newsreader: NN version 6.5.1 (NOV)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hasch@t-online.de (Juergen Hasch) writes:

>> I've now tried the Intel driver, no help, still get the NFS timeouts (the
>> intel driver doesn't output anything to dmesg, so it's no way of telling if
>> the same things occur as in the eepro100 stock-kernel driver).

>I had some trouble with an Intel STL 2 board and the onboard EEPRO100.
>Samba worked OK but it always got stuck on NFS transfers.

A datapoint that might be interesting:

I run four of these buggers with eepros as Internet-Interfaces for
heavy traffic (30-80 MBit sustained 24/7) under 2.2.19. Not a single
glitch on each of these boxes. The machines have two PIII/1GHz each
and a (custom built) SMP kernel based off RH 2.2.19-6.2.7

boot message:

eepro100.c:v1.09j-t 9/29/99 Donald Becker http://cesdis.gsfc.nasa.gov/linux/drivers/eepro100.html
eepro100.c: $Revision: 1.20.2.10 $ 2000/05/31 Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and others
eepro100.c: VA Linux custom, Dragan Stancevic <visitor@valinux.com> 2000/11/15
eth0: Intel PCI EtherExpress Pro100 82557, 00:D0:B7:A8:67:EC, I/O at 0x2c00, IRQ 21.
  Board assembly 000000-000, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).

So there may be a change between 2.2 and 2.4 that triggers the problems.

	Regards
		Henning
-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- Geschaeftsfuehrer
INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de

Am Schwabachgrund 22  Fon.: 09131 / 50654-0   info@intermeta.de
D-91054 Buckenhof     Fax.: 09131 / 50654-20   
