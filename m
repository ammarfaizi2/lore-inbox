Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129228AbQKSSug>; Sun, 19 Nov 2000 13:50:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129251AbQKSSu1>; Sun, 19 Nov 2000 13:50:27 -0500
Received: from lepidachrosite.lion-access.net ([212.19.217.3]:43720 "HELO
	lepidachrosite.lion-access.net") by vger.kernel.org with SMTP
	id <S129228AbQKSSuU>; Sun, 19 Nov 2000 13:50:20 -0500
Message-ID: <009f01c05255$0546d5c0$bf9874d5@teukels>
From: "Luuk van der Duim" <l.a.van.der.duim.st@ppsw.rug.nl>
To: <tspin@epix.net>, <dtig@ihug.com.au>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: isofs crash on 2.4.0-test11-pre7 [1.] MAINTAINERS: ISO  FILESYSTEM
Date: Sun, 19 Nov 2000 19:17:46 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2919.6600
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent and Tony,

Hate to spoil the fun :( but, try the patch Tom Leete commited on Saturday
november 18th.
Since your Oopses are related to get_joliet_filename(), this might just do
the trick?

Luuk



>Hi,
>
>
>The second and third arguments of get_joliet_filename() are swapped.
>
>
>Tom
>
>
>
>--- linux-2.4.0-test11/fs/isofs/namei.c.orig Sat Nov 18 01:55:55 2000
>+++ linux-2.4.0-test11/fs/isofs/namei.c Sat Nov 18 07:08:05 2000
>@@ -127,7 +127,7 @@
>                         dpnt = tmpname;
> #ifdef CONFIG_JOLIET
>                 } else if (dir->i_sb->u.isofs_sb.s_joliet_level)

>- dlen = get_joliet_filename(de, dir, tmpname);
>+ dlen = get_joliet_filename(de, tmpname, dir);
>                        dpnt = tmpname;
>#endif
>                 } else if (dir->i_sb->u.isofs_sb.s_mapping == 'a')

>-




-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
