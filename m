Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268194AbRGZQDf>; Thu, 26 Jul 2001 12:03:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268231AbRGZQD0>; Thu, 26 Jul 2001 12:03:26 -0400
Received: from smtpnotes.altec.com ([209.149.164.10]:2312 "HELO
	smtpnotes.altec.com") by vger.kernel.org with SMTP
	id <S268194AbRGZQDN>; Thu, 26 Jul 2001 12:03:13 -0400
X-Lotus-FromDomain: ALTEC
From: Wayne.Brown@altec.com
To: sentry21@cdslash.net
cc: "Richard B. Johnson" <root@chaos.analogic.com>,
        linux-kernel@vger.kernel.org
Message-ID: <86256A95.00581EDA.00@smtpnotes.altec.com>
Date: Thu, 26 Jul 2001 11:02:04 -0500
Subject: Re: Weird ext2fs immortal directory bug
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing



Try lsattr ./#3147 and see if the i attribute is set.  If so, then (as root) do
chattr -i ./#3147 and try again to remove it.

Wayne




sentry21@cdslash.net on 07/26/2001 10:04:48 AM

To:   "Richard B. Johnson" <root@chaos.analogic.com>
cc:   linux-kernel@vger.kernel.org (bcc: Wayne Brown/Corporate/Altec)

Subject:  Re: Weird ext2fs immortal directory bug



> On Thu, 26 Jul 2001 sentry21@cdslash.net wrote:
> [SNIPPED...]
> >
> > Here's the problem(s) (or at least, the symptoms):
> >
> > sentry21@Petra:1:/lost+found$ ls -l
> > total 0
> > lr----S---    1 52       12337           0 Nov  1  2022 #3147 ->
> >
>
> Did you try..
> # rm -r lost+found
> # mklost+found
>
> Without knowing how to use the ext2fs tools, and not wanting to
> risk more damage, I tried this and it worked when I had such a
> crash-induced problem.

sentry21@Petra:1:/$ sudo rm -rf lost+found/
rm: cannot unlink `lost+found/#3147': Operation not permitted
rm: cannot remove directory `lost+found': Directory not empty


Dang.

--Dan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/





