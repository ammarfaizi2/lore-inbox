Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268145AbRH1PpB>; Tue, 28 Aug 2001 11:45:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271507AbRH1Pow>; Tue, 28 Aug 2001 11:44:52 -0400
Received: from tangens.hometree.net ([212.34.181.34]:15518 "EHLO
	mail.hometree.net") by vger.kernel.org with ESMTP
	id <S268145AbRH1Pom>; Tue, 28 Aug 2001 11:44:42 -0400
To: linux-kernel@vger.kernel.org
Path: forge.intermeta.de!not-for-mail
From: "Henning P. Schmiedehausen" <mailgate@hometree.net>
Newsgroups: hometree.linux.kernel
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war
Date: Tue, 28 Aug 2001 15:44:53 +0000 (UTC)
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
Message-ID: <9mge9l$sb9$1@forge.intermeta.de>
In-Reply-To: <3B8BA883.3B5AAE2E@linux-m68k.org> <Pine.LNX.4.33.0108280732560.8585-100000@penguin.transmeta.com>
Reply-To: hps@intermeta.de
NNTP-Posting-Host: forge.intermeta.de
X-Trace: tangens.hometree.net 999013493 29130 212.34.181.4 (28 Aug 2001 15:44:53 GMT)
X-Complaints-To: news@intermeta.de
NNTP-Posting-Date: Tue, 28 Aug 2001 15:44:53 +0000 (UTC)
X-Copyright: (C) 1996-2001 Henning Schmiedehausen
X-No-Archive: yes
X-Newsreader: NN version 6.5.1 (NOV)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> writes:

>I'll show you a real example from drivers/acorn/scsi/acornscsi.c:

>	min(host->scsi.SCp.this_residual, DMAC_BUFFER_SIZE / 2);

>this_residual is "int", and "DMAC_BUFFER_SIZE" is just a #define for
>an integer constant. So the above is actually a signed comparison, and
>I'll bet you that was not what the author intended.

And the mistake of the author was not to write "unsigned int this_residual".
That's the bug. Not the min() function.

	Regards
		Henning

-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- Geschaeftsfuehrer
INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de

Am Schwabachgrund 22  Fon.: 09131 / 50654-0   info@intermeta.de
D-91054 Buckenhof     Fax.: 09131 / 50654-20   
