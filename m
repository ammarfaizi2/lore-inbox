Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129264AbQJ0KDO>; Fri, 27 Oct 2000 06:03:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129452AbQJ0KDE>; Fri, 27 Oct 2000 06:03:04 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:43272 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S129264AbQJ0KC4>; Fri, 27 Oct 2000 06:02:56 -0400
Date: Fri, 27 Oct 2000 12:02:20 +0200
From: Martin Mares <mj@suse.cz>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: "Richard B. Johnson" <root@chaos.analogic.com>,
        Yoann Vandoorselaere <yoann@mandrakesoft.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Possible critical VIA vt82c686a chip bug (private question)
Message-ID: <20001027120220.A5741@atrey.karlin.mff.cuni.cz>
In-Reply-To: <m3d7gnd31m.fsf@test1.mandrakesoft.com> <Pine.LNX.3.95.1001026115039.12337A-100000@chaos.analogic.com> <20001026190309.A372@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <20001026190309.A372@suse.cz>; from vojtech@suse.cz on Thu, Oct 26, 2000 at 07:03:09PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> So this is not our problem here. Anyway I guess it's time to hunt for
> i8259 accesses in the kernel that lack the necessary spinlock, even when
> they're not probably the cause of the problem we see here.

BTW what about trying to modify your work-around code to make it
attempt to read the timer again? This way we could test whether it was
a race condition during timer read or really timer jumping to a bogus
value.

				Have a nice fortnight
-- 
Martin `MJ' Mares <mj@ucw.cz> <mj@suse.cz> http://atrey.karlin.mff.cuni.cz/~mj/
"This line is umop apisdn."
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
