Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264711AbTARM6g>; Sat, 18 Jan 2003 07:58:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264716AbTARM6g>; Sat, 18 Jan 2003 07:58:36 -0500
Received: from keetweej.xs4all.nl ([213.84.46.114]:44229 "EHLO
	muur.intranet.vanheusden.com") by vger.kernel.org with ESMTP
	id <S264711AbTARM6f>; Sat, 18 Jan 2003 07:58:35 -0500
From: "Folkert van Heusden" <folkert@vanheusden.com>
To: <Valdis.Kletnieks@vt.edu>, <robw@optonline.net>
Cc: "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: RE: any chance of 2.6.0-test*? 
Date: Sat, 18 Jan 2003 14:07:26 +0100
Message-ID: <002201c2bef2$8d1175d0$3640a8c0@boemboem>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <200301122018.h0CKIcWN004203@turing-police.cc.vt.edu>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Now, it's provable you never *NEED* a goto.  On the other hand,
*judicious*
> use of goto can prevent code that is so cluttered with stuff of the form:
>         if(...) {
> 		...
> 		die_flag = 1;
> 		if (!die _flag) {...
>
> Pretty soon, you have die_1_flag, die_2_flag, die_3_flag and so on,
> rather than 3 or 4 "goto bail_now;".

There's always the construction:

	for(;;)
	{
		/* do something */

		if (something_failed)
			break;

		/* do something */

		if (something_failed)
			break;

		...

		break;	/* the final break */
	}

	etc.


