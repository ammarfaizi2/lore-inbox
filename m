Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270266AbRHWUOi>; Thu, 23 Aug 2001 16:14:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270264AbRHWUO3>; Thu, 23 Aug 2001 16:14:29 -0400
Received: from mail.fbab.net ([212.75.83.8]:18952 "HELO mail.fbab.net")
	by vger.kernel.org with SMTP id <S270263AbRHWUOQ>;
	Thu, 23 Aug 2001 16:14:16 -0400
X-Qmail-Scanner-Mail-From: mag@fbab.net via mail.fbab.net
X-Qmail-Scanner-Rcpt-To: raybry@timesn.com twalberg@mindspring.com linux-kernel@vger.kernel.org
X-Qmail-Scanner: 0.94 (No viruses found. Processed in 5.694597 secs)
Message-ID: <03fc01c12c10$8155b060$020a0a0a@totalmef>
From: "Magnus Naeslund\(f\)" <mag@fbab.net>
To: <raybry@timesn.com>, "Tim Walberg" <twalberg@mindspring.com>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <20010823143440.G20693@mindspring.com> <3B85615A.58920036@timesn.com>
Subject: Re: macro conflict
Date: Thu, 23 Aug 2001 22:16:34 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: <raybry@timesn.com>
> Without digging through the archives to see if this has already
> been suggested (if so, I apologize), why can't the following be done:
>
> min(x,y) = ({typeof((x)) __x=(x), __y=(y); (__x < __y) ? __x : __y})
>
> That gets you the correct "evaluate the args once" semantics and gives
> you control over typing (the comparison is done in the type of the
> first argument) and we don't have to change a zillion drivers.
>
> (typeof() is a gcc extension.)
>

But then again, how do you know it's the type of x we want, maybe we want
type of y, that is and signed char (not an int like x).
Talk about hidden buffer overflow stuff :)

Magnus

-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
 Programmer/Networker [|] Magnus Naeslund
 PGP Key: http://www.genline.nu/mag_pgp.txt
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-



