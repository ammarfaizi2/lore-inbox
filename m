Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266514AbSLOM6t>; Sun, 15 Dec 2002 07:58:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266489AbSLOM6t>; Sun, 15 Dec 2002 07:58:49 -0500
Received: from mail.hometree.net ([212.34.181.120]:42961 "EHLO
	mail.hometree.net") by vger.kernel.org with ESMTP
	id <S266514AbSLOM6s>; Sun, 15 Dec 2002 07:58:48 -0500
To: linux-kernel@vger.kernel.org
Path: forge.intermeta.de!not-for-mail
From: "Henning P. Schmiedehausen" <hps@intermeta.de>
Newsgroups: hometree.linux.kernel
Subject: Re: Networking/Becker et al [was Re: pci-skeleton duplex check]
Date: Sun, 15 Dec 2002 13:06:41 +0000 (UTC)
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
Message-ID: <athup1$pen$1@forge.intermeta.de>
References: <20021213092229.D9973@work.bitmover.com> <1039898841.855.1684.camel@phantasy> <athjft$4b7$1@forge.intermeta.de> <20021215123159.GJ27658@fs.tum.de>
Reply-To: hps@intermeta.de
NNTP-Posting-Host: forge.intermeta.de
X-Trace: tangens.hometree.net 1039957601 5958 212.34.181.4 (15 Dec 2002 13:06:41 GMT)
X-Complaints-To: news@intermeta.de
NNTP-Posting-Date: Sun, 15 Dec 2002 13:06:41 +0000 (UTC)
X-Copyright: (C) 1996-2002 Henning Schmiedehausen
X-No-Archive: yes
X-Newsreader: NN version 6.5.1 (NOV)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@fs.tum.de> writes:

>> Yes. And he does a great job. But the second he started to put
>> something in that he maintains in his subsystem, another obnoxious
>> developer with too much spare time popped up and started whining about
>> "don't put this crap in, Marcello". Of course, without offering any
>> alternative.

>I remember the mail you were referring to but I don't have any knowledge 
>regarding whether this specific patch is good or bad.

>It's often better to reject bad code and to have nothing in the kernel 
>instead of having bad code in the kernel. There are several examples 
>where bad code entered into the kernel and it would have been better if 
>it was rejected.

>You might discuss whether the code in question is "crap" or good code 
>but please discuss it on a technical level without personal offences.

Hi,

the problem is, that Donald diverted in his drivers from the "official
stance" by introducing a pci-layer which he uses in all his
drivers. To him, at that time, it was technically superior to the
(then existing) PCI code and after he created this layer, he no longer
cared about the ongoing Linux PCI development because he wanted to
keep his drivers stable and laid the emphasis not on "keeping up with
every PCI change in a minor kernel revision" but to keep his drivers
stable.

You can't simply take Donalds' drivers and drop them into the
kernel. You need at least the pci-scan.c file and even then you might
either not get it to work or have to make code changes. BTDTGTT.

But you do have to start somewhere. If Jeff drops the drivers into the
source in a way that they compile and work even if they don't adhere
to every linux kernel programming standard (which seem to be chiseled
in jelly anway...)  and after that start converting with Donalds' help
to the actual PCI core code, that's IMHO the right way to go.

But if one gets shot down for even trying to start this, you might
(after a while) drive developers away from the kernel source (just as
it did happen with Donald).

I considered the ChangeSet which included pci-scan.c as a start and a
peace offer to Donald. Too bad, that not all core developers seem to
be as understanding and ready to make an admission as Jeff.

 	Regards
 		Henning

-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- Geschaeftsfuehrer
INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de

Am Schwabachgrund 22  Fon.: 09131 / 50654-0   info@intermeta.de
D-91054 Buckenhof     Fax.: 09131 / 50654-20   
