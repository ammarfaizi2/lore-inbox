Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280684AbRKNQgz>; Wed, 14 Nov 2001 11:36:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280683AbRKNQgp>; Wed, 14 Nov 2001 11:36:45 -0500
Received: from mail307.mail.bellsouth.net ([205.152.58.167]:7078 "EHLO
	imf07bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S280680AbRKNQg3>; Wed, 14 Nov 2001 11:36:29 -0500
Message-ID: <3BF29D69.B16479A1@mandrakesoft.com>
Date: Wed, 14 Nov 2001 11:35:53 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Stuart MacDonald <stuartm@connecttech.com>
CC: tytso@mit.edu, rmk@arm.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: Fw: [Patch] Some updates to serial-5.05
In-Reply-To: <00df01c16d23$b409ab20$294b82ce@connecttech.com> <3BF2947B.DF3BE9DC@mandrakesoft.com> <013d01c16d29$bc5d4380$294b82ce@connecttech.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stuart MacDonald wrote:
> 
> From: "Jeff Garzik" <jgarzik@mandrakesoft.com>
> > Your code formatting is totally different from the formatting of the
> > surrounding serial.c code you modify.
> 
> Please point out the bad parts. From my end the formatting is
> exactly the same.

Easily.  Your patch:
> +  case TIOCSER485GET:
> +  case TIOCSER485SET:
> +   if (state->lmode_fn)
> +    return (state->lmode_fn)(state, cmd,
> +       (unsigned int *) arg);
> +   else
> +    return -EINVAL;
>    case TIOCMGET:
>     return get_modem_info(info, (unsigned int *) arg);
>    case TIOCMBIS:

2.4.x serial.c:
>                 case TIOCMGET:
>                         return get_modem_info(info, (unsigned int *) arg);
>                 case TIOCMBIS:

The formatting is blatantly, obviously different.


> > Also, a diff against the kernel 2.4.x serial.c might be nice, as there
> > haven't been updates from tytso in ages (serial-5.05), and rmk has a new
> > serial driver for 2.5.x.
> 
> 2.4.0 contains 5.02 and 2.4.14 contains 5.05c. These patches should
> apply cleanly to all 5.xx serial drivers, although there may be
> fuzz/offsets.

Doubtful.  When applied to 2.4.x-current:

[jgarzik@rum linux_2_4]$ patch drivers/char/serial.c < ~/tmp/patch 
patching file drivers/char/serial.c
Hunk #1 FAILED at 1405.
Hunk #2 FAILED at 2514.
Hunk #3 FAILED at 2572.
Hunk #4 FAILED at 3968.
patch: **** malformed patch at line 55: {


-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno

