Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129659AbQKFLsf>; Mon, 6 Nov 2000 06:48:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129672AbQKFLs0>; Mon, 6 Nov 2000 06:48:26 -0500
Received: from cerebus-ext.cygnus.co.uk ([194.130.39.252]:14590 "EHLO
	passion.cygnus") by vger.kernel.org with ESMTP id <S129659AbQKFLsN>;
	Mon, 6 Nov 2000 06:48:13 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <3A0698A8.8D00E9C1@mandrakesoft.com> 
In-Reply-To: <3A0698A8.8D00E9C1@mandrakesoft.com>  <3A0693E9.B4677F4E@mandrakesoft.com> <Pine.LNX.4.21.0011060302290.17667-100000@anime.net> <24273.973508761@redhat.com> <28752.973510632@redhat.com> 
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Dan Hollis <goemon@anime.net>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Oliver Xymoron <oxymoron@waste.org>, Keith Owens <kaos@ocs.com.au>,
        linux-kernel@vger.kernel.org
Subject: Re: Persistent module storage [was Linux 2.4 Status / TODO page] 
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Date: Mon, 06 Nov 2000 11:47:44 +0000
Message-ID: <29788.973511264@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



jgarzik@mandrakesoft.com said:
> > * User continues to happily listen to radio through sound card
> You're using the sound card without a driver?

Yes. The sound card allows itself to be unloaded when the pass-through mixer
levels are non-zero. This is reasonable iff it can be reloaded without 
destroying those levels again.

jgarzik@mandrakesoft.com said:
>  If you create a post-action in /etc/modules.conf which initializes
> the mixer to proper levels, this problem does not exist.

Yes it does. It can be a few seconds between initialisation and the 
post-action running. That's plenty of time to miss what the news announcer 
was saying about whether you need to go to work today (my gf is a teacher) 
or to wake the entire house if the mixer levels don't default to zero.

--
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
