Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271679AbRHQPyW>; Fri, 17 Aug 2001 11:54:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271678AbRHQPyM>; Fri, 17 Aug 2001 11:54:12 -0400
Received: from mail.fbab.net ([212.75.83.8]:2826 "HELO mail.fbab.net")
	by vger.kernel.org with SMTP id <S271677AbRHQPyF>;
	Fri, 17 Aug 2001 11:54:05 -0400
X-Qmail-Scanner-Mail-From: mag@fbab.net via mail.fbab.net
X-Qmail-Scanner-Rcpt-To: szaka@f-secure.com viro@math.psu.edu linux-kernel@vger.kernel.org
X-Qmail-Scanner: 0.94 (No viruses found. Processed in 8.84138 secs)
Message-ID: <015f01c12735$24d7d8c0$020a0a0a@totalmef>
From: "Magnus Naeslund\(f\)" <mag@fbab.net>
To: "Szabolcs Szakacsits" <szaka@f-secure.com>
Cc: "Alexander Viro" <viro@math.psu.edu>,
        "linux-kernel" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.30.0108162009260.2660-100000@fs131-224.f-secure.com>
Subject: Re: 2.4.8 Resource leaks + limits
Date: Fri, 17 Aug 2001 17:56:14 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
x-mimeole: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Szabolcs Szakacsits" <szaka@f-secure.com>
>
> On Wed, 15 Aug 2001, Magnus Naeslund(f) wrote:
>
> > The problem is that i can shh in as root, but not as any other user (
not
> > via login or su or either ).
>
> Are you using < 0.73 PAM without the change_uid pam_limit option? You
> set in /etc/security/limits.conf:
> *               soft    nproc           40
>
> the '*' valid for users but not for root, the relevant parts of
> a default login/pam works like:
>
> <running as root>
> setrlimit()
> fork()
> setuid(user_uid)
>
> So if you have at least 40 root processes running already for whatever
> reason then the result is what you see.
>

Well root is unlimited, and i have _no_ processes running as the user i'm
trying to log on as.
This must be a bug then.
I even tried adduser <newuser>, but i couldn't log in as that either.

> The livelocks what I mentioned is indeed different and fixed in 2.4.9 (I
> guess the 'kswapd thought shortage for highmem zone when its size is
> actually 0' issue what Linus said in the 'kswapd using all cpu for long
> periods' thread). Sorry for the confusion, hope the above fixes your
> problem.
>

I never had any lockups.

Magnus

-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
 Programmer/Networker [|] Magnus Naeslund
 PGP Key: http://www.genline.nu/mag_pgp.txt
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-



