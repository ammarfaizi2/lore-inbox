Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265065AbSKJS5M>; Sun, 10 Nov 2002 13:57:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265066AbSKJS5M>; Sun, 10 Nov 2002 13:57:12 -0500
Received: from mail.hometree.net ([212.34.181.120]:37249 "EHLO
	mail.hometree.net") by vger.kernel.org with ESMTP
	id <S265065AbSKJS5L>; Sun, 10 Nov 2002 13:57:11 -0500
To: linux-kernel@vger.kernel.org
Path: forge.intermeta.de!not-for-mail
From: "Henning P. Schmiedehausen" <hps@intermeta.de>
Newsgroups: hometree.linux.kernel
Subject: Re: [PATCH][2.5] notsc option needs some attention/TLC
Date: Sun, 10 Nov 2002 19:03:57 +0000 (UTC)
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
Message-ID: <aqmait$tmb$1@forge.intermeta.de>
References: <Pine.LNX.4.44.0211091308250.10475-100000@montezuma.mastecende.com> <Pine.LNX.4.44.0211091044060.12487-100000@home.transmeta.com>
Reply-To: hps@intermeta.de
NNTP-Posting-Host: forge.intermeta.de
X-Trace: tangens.hometree.net 1036955037 30640 212.34.181.4 (10 Nov 2002 19:03:57 GMT)
X-Complaints-To: news@intermeta.de
NNTP-Posting-Date: Sun, 10 Nov 2002 19:03:57 +0000 (UTC)
X-Copyright: (C) 1996-2002 Henning Schmiedehausen
X-No-Archive: yes
X-Newsreader: NN version 6.5.1 (NOV)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> writes:


> - a kernel compiled for TSC-only. This one simply will not _work_ without 
>   a TSC, since it is statically compiled for the TSC case. Here, "notsc"
>   simply cannot do anything, so it just prints a message saying that it 
>   doesn't work.

IMHO, if you boot a "TSC-only" kernel on a machine without TSC, the correct
answer should be 

Panic: This kernel is compiled for TSC-only. No TSC found.
Machine halted.

Same goes IMHO for "i686 on lower", "i586 on lower" and so on. 

Everything else leads to strange effects and hard to decipher bug
reports. If in doubt, boot i386 compiled kernel.

	Regards
		Henning



-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- Geschaeftsfuehrer
INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de

Am Schwabachgrund 22  Fon.: 09131 / 50654-0   info@intermeta.de
D-91054 Buckenhof     Fax.: 09131 / 50654-20   
