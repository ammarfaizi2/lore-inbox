Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130911AbRBJJma>; Sat, 10 Feb 2001 04:42:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130954AbRBJJmU>; Sat, 10 Feb 2001 04:42:20 -0500
Received: from [194.213.32.137] ([194.213.32.137]:2308 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S130911AbRBJJl7>;
	Sat, 10 Feb 2001 04:41:59 -0500
Message-ID: <20010209201243.D16776@bug.ucw.cz>
Date: Fri, 9 Feb 2001 20:12:43 +0100
From: Pavel Machek <pavel@suse.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Alex Belits <abelits@phobos.illtel.denver.co.us>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: Serial device with very large buffer
In-Reply-To: <Pine.LNX.4.10.10101312301110.1478-100000@mercury> <E14OTPp-0005MY-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <E14OTPp-0005MY-00@the-village.bc.nu>; from Alan Cox on Thu, Feb 01, 2001 at 11:45:23PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >   I also propose to increase the size of flip buffer to 640 bytes (so the
> > flipping won't occur every time in the middle of the full buffer), however
> > I understand that it's a rather drastic change for such a simple goal, and
> > not everyone will agree that it's worth the trouble:
> 
> Going to a 1K flip buffer would make sense IMHO for high speed devices too

Actually bigger flipbufs are needed for highspeed serials and
irda. Tytso received patch to make flipbuf size settable by the
driver. (Setting it to 1K is not easy, you need to change allocation
mechanism of buffers.)
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
