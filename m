Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262157AbTENNMq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 09:12:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262170AbTENNMq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 09:12:46 -0400
Received: from mail.hometree.net ([212.34.181.120]:45228 "EHLO
	mail.hometree.net") by vger.kernel.org with ESMTP id S262157AbTENNMp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 09:12:45 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: "Henning P. Schmiedehausen" <hps@intermeta.de>
Newsgroups: hometree.linux.kernel
Subject: Re: PCMCIA 2.5.X sleeping from illegal context
Date: Wed, 14 May 2003 13:25:31 +0000 (UTC)
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
Message-ID: <b9tg4b$e3m$1@tangens.hometree.net>
References: <1052775331.1995.49.camel@diemos> <20030513163323.516ad04b.akpm@digeo.com>
Reply-To: hps@intermeta.de
NNTP-Posting-Host: forge.intermeta.de
X-Trace: tangens.hometree.net 1052918731 14454 212.34.181.4 (14 May 2003 13:25:31 GMT)
X-Complaints-To: news@intermeta.de
NNTP-Posting-Date: Wed, 14 May 2003 13:25:31 +0000 (UTC)
X-Copyright: (C) 1996-2003 Henning Schmiedehausen
X-No-Archive: yes
User-Agent: nn/6.6.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@digeo.com> writes:

>diff -puN kernel/sched.c~might-sleep-fix kernel/sched.c
>--- 25/kernel/sched.c~might-sleep-fix	Tue May 13 16:32:18 2003
>+++ 25-akpm/kernel/sched.c	Tue May 13 16:32:46 2003
>@@ -2842,8 +2842,8 @@ void __might_sleep(char *file, int line)
> 		if (time_before(jiffies, prev_jiffy + HZ))
> 			return;
> 		prev_jiffy = jiffies;
>-		printk(KERN_ERR "Debug: sleeping function called from illegal"
>-				" context at %s:%d\n", file, line);
>+		printk(KERN_ERR "Debug: sleeping in immoral context "
>+					"at %s:%d\n", file, line);

We could change "in" to "with" to get an X rating for the kernel error
messages. ;-)

	SCNR
		Henning


-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen          INTERMETA GmbH
hps@intermeta.de        +49 9131 50 654 0   http://www.intermeta.de/

Java, perl, Solaris, Linux, xSP Consulting, Web Services 
freelance consultant -- Jakarta Turbine Development  -- hero for hire
