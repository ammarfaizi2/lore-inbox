Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129077AbQKFMA1>; Mon, 6 Nov 2000 07:00:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129071AbQKFMAR>; Mon, 6 Nov 2000 07:00:17 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:24332 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S129057AbQKFMAP>;
	Mon, 6 Nov 2000 07:00:15 -0500
Message-ID: <3A069CA8.5BB5FF20@mandrakesoft.com>
Date: Mon, 06 Nov 2000 06:57:28 -0500
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
In-Reply-To: <3A0698A8.8D00E9C1@mandrakesoft.com>  <3A0693E9.B4677F4E@mandrakesoft.com> <Pine.LNX.4.21.0011060302290.17667-100000@anime.net> <24273.973508761@redhat.com> <28752.973510632@redhat.com> <29788.973511264@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse wrote:
> 
> jgarzik@mandrakesoft.com said:
> > > * User continues to happily listen to radio through sound card
> > You're using the sound card without a driver?
> 
> Yes. The sound card allows itself to be unloaded when the pass-through mixer
> levels are non-zero. This is reasonable iff it can be reloaded without
> destroying those levels again.

I don't think that is reasonable.

The first thing most drivers do is reset the hardware.   That inevitably
leads to some sort of blip, when it comes to sound drivers.  If you
-don't- reset the hardware, the driver is using hardware that is in an
unknown state.  (using hardware w/out resetting it == unknown state)

You are depending on the hardware to keep its state -between- driver
unload and driver reload.  That seems inherently unstable to me.  It
amazes me that such is supported.

	Jeff


-- 
Jeff Garzik             | Dinner is ready when
Building 1024           | the smoke alarm goes off.
MandrakeSoft            |	-/usr/games/fortune
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
