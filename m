Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132736AbRDINQN>; Mon, 9 Apr 2001 09:16:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132742AbRDINQE>; Mon, 9 Apr 2001 09:16:04 -0400
Received: from tangens.hometree.net ([212.34.181.34]:9165 "EHLO
	mail.hometree.net") by vger.kernel.org with ESMTP
	id <S132736AbRDINP6>; Mon, 9 Apr 2001 09:15:58 -0400
To: linux-kernel@vger.kernel.org
Path: forge.intermeta.de!not-for-mail
From: "Henning P. Schmiedehausen" <hps@intermeta.de>
Newsgroups: hometree.linux.kernel
Subject: Re: Multi-function PCI devices
Date: Mon, 9 Apr 2001 13:15:57 +0000 (UTC)
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
Message-ID: <9ascmd$27d$1@forge.intermeta.de>
In-Reply-To: <3ACECA8F.FEC9439@eunet.at> <3ACED679.7E334234@mandrakesoft.com>
Reply-To: hps@intermeta.de
NNTP-Posting-Host: forge.intermeta.de
X-Trace: tangens.hometree.net 986822157 24657 212.34.181.4 (9 Apr 2001 13:15:57 GMT)
X-Complaints-To: news@intermeta.de
NNTP-Posting-Date: Mon, 9 Apr 2001 13:15:57 +0000 (UTC)
X-Copyright: (C) 1996-2001 Henning Schmiedehausen
X-No-Archive: yes
X-Newsreader: NN version 6.5.1 (NOV)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@mandrakesoft.com> writes:

>Not so hard.

>There is no need to register more than one driver per PCI device -- just
>create a PCI driver whose probe routine registers serial and parallel,
>and whose remove routine unregisters same.

Sigh. Register a small dummy driver, which takes the device and then hands
out the parallel ports to the parallel driver and the serial ports to the
serial driver. All you need are just two small hooks.

	Regards
		Henning


-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- Geschaeftsfuehrer
INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de

Am Schwabachgrund 22  Fon.: 09131 / 50654-0   info@intermeta.de
D-91054 Buckenhof     Fax.: 09131 / 50654-20   
