Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261581AbSKKXH7>; Mon, 11 Nov 2002 18:07:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261613AbSKKXH6>; Mon, 11 Nov 2002 18:07:58 -0500
Received: from mail.hometree.net ([212.34.181.120]:52910 "EHLO
	mail.hometree.net") by vger.kernel.org with ESMTP
	id <S261581AbSKKXH5>; Mon, 11 Nov 2002 18:07:57 -0500
To: linux-kernel@vger.kernel.org
Path: forge.intermeta.de!not-for-mail
From: "Henning P. Schmiedehausen" <hps@intermeta.de>
Newsgroups: hometree.linux.kernel
Subject: Re: [PATCH] [2.4.20-rc1] compiler fix drivers/ide/pdc202xx.c
Date: Mon, 11 Nov 2002 23:14:45 +0000 (UTC)
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
Message-ID: <aqpdl5$kt6$1@forge.intermeta.de>
References: <hps@intermeta.de> <200211111502.gABF2ajg031284@pincoya.inf.utfsm.cl>
Reply-To: hps@intermeta.de
NNTP-Posting-Host: forge.intermeta.de
X-Trace: tangens.hometree.net 1037056485 29977 212.34.181.4 (11 Nov 2002 23:14:45 GMT)
X-Complaints-To: news@intermeta.de
NNTP-Posting-Date: Mon, 11 Nov 2002 23:14:45 +0000 (UTC)
X-Copyright: (C) 1996-2002 Henning Schmiedehausen
X-No-Archive: yes
X-Newsreader: NN version 6.5.1 (NOV)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Horst von Brand <vonbrand@inf.utfsm.cl> writes:

>"Henning P. Schmiedehausen" <hps@intermeta.de> said:
>> Daniel Mehrmann <daniel.mehrmann@gmx.de> writes:
>> 
>> >Hello Marcelo,
>> 
>> >i fix a compiler warning from pdc202xx.c.
>> >The "default:" value in the switch was empty. Gcc don`t like
>> >this. We don`t need this one. 
>> 
>> Correct solution is not to remove the "default:" but to add a "break;"

>So people start wondering if somehow the content of the default case got
>deleted by mistake? Better not. Plus it is needless (source) code bloat.

So comment it:

	default:
		break;  /* Does nothing */

A switch without a default case is simply asking for trouble in the
long run.

	Regards
		Henning


-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- Geschaeftsfuehrer
INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de

Am Schwabachgrund 22  Fon.: 09131 / 50654-0   info@intermeta.de
D-91054 Buckenhof     Fax.: 09131 / 50654-20   
