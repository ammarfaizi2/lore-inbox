Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262161AbSJZKhd>; Sat, 26 Oct 2002 06:37:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262178AbSJZKhd>; Sat, 26 Oct 2002 06:37:33 -0400
Received: from mail.hometree.net ([212.34.181.120]:64931 "EHLO
	mail.hometree.net") by vger.kernel.org with ESMTP
	id <S262161AbSJZKhN>; Sat, 26 Oct 2002 06:37:13 -0400
To: linux-kernel@vger.kernel.org
Path: forge.intermeta.de!not-for-mail
From: "Henning P. Schmiedehausen" <hps@intermeta.de>
Newsgroups: hometree.linux.kernel
Subject: Re: One for the Security Guru's
Date: Sat, 26 Oct 2002 10:43:29 +0000 (UTC)
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
Message-ID: <apdrkh$h8n$1@forge.intermeta.de>
References: <1035453664.1035.11.camel@syntax.dstl.gov.uk> <ap97nr$h6e$1@forge.intermeta.de> <1035479086.9935.6.camel@gby.benyossef.com> <1035539042.23977.24.camel@forge> <apcaub$ov5$1@cesium.transmeta.com>
Reply-To: hps@intermeta.de
NNTP-Posting-Host: forge.intermeta.de
X-Trace: tangens.hometree.net 1035629009 29587 212.34.181.4 (26 Oct 2002 10:43:29 GMT)
X-Complaints-To: news@intermeta.de
NNTP-Posting-Date: Sat, 26 Oct 2002 10:43:29 +0000 (UTC)
X-Copyright: (C) 1996-2002 Henning Schmiedehausen
X-No-Archive: yes
X-Newsreader: NN version 6.5.1 (NOV)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" <hpa@zytor.com> writes:

>Followup to:  <1035539042.23977.24.camel@forge>
>By author:    Henning Schmiedehausen <hps@intermeta.de>
>In newsgroup: linux.dev.kernel
>> > 
>> > A. If there's a buffer overflow in the SSL Accelerator box the firewall
>> > wont do you much good (it helps, but only a little). 
>> 
>> This is a hardware device. Hardware as in "silicon". I very much doubt
>> that you can run "general purpose programs" on a device specifically
>> designed to do crypto. And this is _not_ just an "embedded Linux on ix86
>> with a crypto chip". 
>> 

>Hardware devices have bugs, too.  Furthermore, most devices marketed
>as "hardware" still have programmable stuff underneath.  Trust me.

Of course they have. I'm not that dumb. :-) I won't expect any piece
of silicon speak http, snmp and have configureable ip adresses without
any programming. I do had my share of Cisco router fun.... :-)

But my point is, that these beasts normally don't run a general
purpose operating system and that they're much less prone to buffer
overflow or similar attacks, simply because they don't use popular
software with known bugs (e.g.  OpenSSL) or these functions (like
doing crypto) are in hardware.

If you have a processor that sets up an ASIC to do "insert https here,
use this key, remove http there", you might be able to attack the IP
stack running on the processor which gets the packets from the wire
and puts them back onto the wire. But you won't be able to trick any
bug or overflow in the crypto routines into opening a root shell on
the ASIC. :-)

Especially if there is no such thing as a /bin/sh binary on the
bugger.  And even if you _do_; you still only have a shell on the
accelerator. Not on the application server.

If you ask me "how can you trust such a device if you can't look at
the source; well, I don't have to. I can tell the customer "this
device has been approved by <insert your certification authority here>
and you pay gobs of cash for simply having this certified device".

Replace "device" with "certificate" and you have the same thing as
getting your web server key certification from Verisign or Thawte.
You pay money and get a "trusted device". 

	Regards
		Henning

-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- Geschaeftsfuehrer
INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de

Am Schwabachgrund 22  Fon.: 09131 / 50654-0   info@intermeta.de
D-91054 Buckenhof     Fax.: 09131 / 50654-20   
