Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129033AbQKFLmN>; Mon, 6 Nov 2000 06:42:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129034AbQKFLmD>; Mon, 6 Nov 2000 06:42:03 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:9996 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S129033AbQKFLlt>;
	Mon, 6 Nov 2000 06:41:49 -0500
Message-ID: <3A0698A8.8D00E9C1@mandrakesoft.com>
Date: Mon, 06 Nov 2000 06:40:24 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
CC: Dan Hollis <goemon@anime.net>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Oliver Xymoron <oxymoron@waste.org>, Keith Owens <kaos@ocs.com.au>,
        linux-kernel@vger.kernel.org
Subject: Re: Persistent module storage [was Linux 2.4 Status / TODO page]
In-Reply-To: <3A0693E9.B4677F4E@mandrakesoft.com>  <Pine.LNX.4.21.0011060302290.17667-100000@anime.net> <24273.973508761@redhat.com> <28752.973510632@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse wrote:
> * Sound module is unloaded
> * User continues to happily listen to radio through sound card

You're using the sound card without a driver?


> * Time passes
> * User is listening intently to something on the radio
> * Something wants to beep through /dev/audio
> * Sound module is autoloaded again, default to zero levels.
>         This time it is _NOT_ fine. User is rightly pissed off :)

If you create a post-action in /etc/modules.conf which initializes the
mixer to proper levels, this problem does not exist.

No kernel coding required.

	Jeff


-- 
Jeff Garzik             | Dinner is ready when
Building 1024           | the smoke alarm goes off.
MandrakeSoft            |	-/usr/games/fortune
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
