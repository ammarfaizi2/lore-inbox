Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262774AbSJCKpj>; Thu, 3 Oct 2002 06:45:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263233AbSJCKpj>; Thu, 3 Oct 2002 06:45:39 -0400
Received: from mail.hometree.net ([212.34.181.120]:6801 "EHLO
	mail.hometree.net") by vger.kernel.org with ESMTP
	id <S262774AbSJCKpi>; Thu, 3 Oct 2002 06:45:38 -0400
To: linux-kernel@vger.kernel.org
Path: forge.intermeta.de!not-for-mail
From: "Henning P. Schmiedehausen" <hps@intermeta.de>
Newsgroups: hometree.linux.kernel
Subject: Sequence of IP fragment packets on the wire
Date: Thu, 3 Oct 2002 10:51:08 +0000 (UTC)
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
Message-ID: <anh7es$mpl$1@forge.intermeta.de>
Reply-To: hps@intermeta.de
NNTP-Posting-Host: forge.intermeta.de
X-Trace: tangens.hometree.net 1033642268 31782 212.34.181.4 (3 Oct 2002 10:51:08 GMT)
X-Complaints-To: news@intermeta.de
NNTP-Posting-Date: Thu, 3 Oct 2002 10:51:08 +0000 (UTC)
X-Copyright: (C) 1996-2002 Henning Schmiedehausen
X-No-Archive: yes
X-Newsreader: NN version 6.5.1 (NOV)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

as far as I can see, Linux sends out fragmented IP packets
"butt-first":

11:34:53.927146 alice > bob: (frag 44605:343@1480)
11:34:53.927189 alice.4831 > bob.udpdemo:  udp 1815 (frag 44605:1480@0+)

(where the first packet is actually the fragmented 2nd part of the
second packet).

This confuses at least one firewall appliance. As I understand it,
this is done for efficency reasons. Still, is there any way to
suppress this and get the packets sent out in "head first" sequence? I
know that routers might resort the fragments again but in my case I
have an "alice -- firewall -- bob" topology which at the moment drops
the fragment on the floor...

Is there a way to configure this? Maybe even connection specific? 

I tested 2.2.19 and 2.4.18 with 100 MBit Ethernet (3Com and eepro100).
Both show the same behaviour.

	Regards
		Henning



-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- Geschaeftsfuehrer
INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de

Am Schwabachgrund 22  Fon.: 09131 / 50654-0   info@intermeta.de
D-91054 Buckenhof     Fax.: 09131 / 50654-20   
