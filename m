Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265088AbSJWQRF>; Wed, 23 Oct 2002 12:17:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265089AbSJWQRF>; Wed, 23 Oct 2002 12:17:05 -0400
Received: from mail.hometree.net ([212.34.181.120]:25514 "EHLO
	mail.hometree.net") by vger.kernel.org with ESMTP
	id <S265088AbSJWQRD>; Wed, 23 Oct 2002 12:17:03 -0400
To: linux-kernel@vger.kernel.org
Path: forge.intermeta.de!not-for-mail
From: "Henning P. Schmiedehausen" <hps@intermeta.de>
Newsgroups: hometree.linux.kernel
Subject: Re: One for the Security Guru's
Date: Wed, 23 Oct 2002 16:23:13 +0000 (UTC)
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
Message-ID: <ap6idh$1pj$1@forge.intermeta.de>
References: <20021023130251.GF25422@rdlg.net>
Reply-To: hps@intermeta.de
NNTP-Posting-Host: forge.intermeta.de
X-Trace: tangens.hometree.net 1035390193 7977 212.34.181.4 (23 Oct 2002 16:23:13 GMT)
X-Complaints-To: news@intermeta.de
NNTP-Posting-Date: Wed, 23 Oct 2002 16:23:13 +0000 (UTC)
X-Copyright: (C) 1996-2002 Henning Schmiedehausen
X-No-Archive: yes
X-Newsreader: NN version 6.5.1 (NOV)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Robert L. Harris" <Robert.L.Harris@rdlg.net> writes:

>  I'd like it from the guru's on exactly how bad a hole this really is
>and if there is a method in the kernel that will prevent such exploits.
>For example, if I disable CONFIG_MODVERSIONS is the kernel less likely
>to accept a module we didn't build?  Are there plans to implement some
>form of finger printing on modules down the road?

You can get the same effect as a module with a kernel without any
modules support compiled. There are even root kits out there which do
exactly this.

If you want a little more security, don't run a vendor kernel
(sic!). Not because they're unsafe but because many rootkits have
binary modules for some well known kernels (2.4.9-34 or 2.4.18-3 come
to mind); clean up your systems (e.g. don't ever ever ever have a
compiler and a development kit on an internet connected system. If you
don't have a compiler, 80% of all root kits will not work or will
simply not be able to build the process hiding stuff because it comes
as C code). If you run 2.4.18-3-rerolled with MODVERSIONS off, lots of
the kiddie root kits break.

You can't get security by design. Ask the OpenBSD people who tried
this and failed.

You get security by installing your systems, administrating them
(which means looking at logfiles, unusual activities), keeping your
boxes up to date with vendor patches and by training your staff to be
security aware. Read lists like Bugtraq. Invest time (and money!) in
the security of the systems.

If some consultant sets up a box and slaps a "this is safe" label on
it, start being suspicious. I've seen more than my share of RedHat 5.x
and 6.x boxes which were installed like this and then they called me
12 months later because the "so secure" boxes have been rooted...

	Regards
		Henning


-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- Geschaeftsfuehrer
INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de

Am Schwabachgrund 22  Fon.: 09131 / 50654-0   info@intermeta.de
D-91054 Buckenhof     Fax.: 09131 / 50654-20   
