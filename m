Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263960AbRGBQLk>; Mon, 2 Jul 2001 12:11:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264614AbRGBQL3>; Mon, 2 Jul 2001 12:11:29 -0400
Received: from [213.203.46.68] ([213.203.46.68]:29199 "HELO grolsch.solbors.no")
	by vger.kernel.org with SMTP id <S263960AbRGBQLU>;
	Mon, 2 Jul 2001 12:11:20 -0400
To: <kernel@ddx.a2000.nu>
Cc: <linux-kernel@vger.kernel.org>, Enforcer <enforcer@ddx.a2000.nu>
Subject: Re: Strange errors in /var/log/messages
In-Reply-To: <Pine.LNX.4.30.0107021800410.5490-100000@ddx.a2000.nu>
From: remco@rc6.org (Remco B. Brink)
Organization: rc6.org <http://www.rc6.org>
Date: 02 Jul 2001 18:11:15 +0200
Message-ID: <m3wv5rl3a4.fsf@solbors.no>
User-Agent: Gnus/5.090004 (Oort Gnus v0.04) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<kernel@ddx.a2000.nu> writes:

> Hi!
> 
> I'm running RedHat 7.0 with all official RH patches applied. The kernel I
> currently run fow a few days is 2.2.19-7.0.8
> I run the pre-compiled kernel of RH. Suddenly I the following messages:

<snip error messages>

> This continued for about half an hour. Then it stopped. What's going on
> here??

Here you have two options:

You are either under attack by someone who's trying to exploit your
LPRng (someone's trying to use LPR's logging function to get a shell).
This is the LPRng string format _syslog bug that theoretically could
allow root access. For more info check http://www.securityfocus.com/vdb/bottom.html?vid=1712

The other option is that you're under rpc.statd attack at the moment.

In either case, make sure you upgraded to the latest patch versions
and subscribe to BugTraq and the Security Focus Incidents mailinglist :)

regards,
Remco

-- 
Remco B. Brink - SOL Børs A/S systemsdeveloper - http://www.norge-invest.no
Personal site at http://rc6.org  -  PGP/GnuPG key at http://rc6.org/rbb.pgp

"What you end up with, after running an operating system concept through
these many marketing coffee filters, is something not unlike plain hot
water."
(By Matt Welsh)
