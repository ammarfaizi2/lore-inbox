Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133039AbQL3IjQ>; Sat, 30 Dec 2000 03:39:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133052AbQL3IjH>; Sat, 30 Dec 2000 03:39:07 -0500
Received: from piglet.twiddle.net ([207.104.6.26]:64776 "EHLO
	piglet.twiddle.net") by vger.kernel.org with ESMTP
	id <S133039AbQL3Ii4>; Sat, 30 Dec 2000 03:38:56 -0500
Date: Sat, 30 Dec 2000 00:08:12 -0800
From: Richard Henderson <rth@twiddle.net>
To: Matti Aarnio <matti.aarnio@zmailer.org>
Cc: Neil Brown <neilb@cse.unsw.edu.au>, Dave Gilbert <gilbertd@treblig.org>,
        linux-alpha@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>,
        linux-kernel@vger.kernel.org
Subject: Re: memmove broken on alpha - was Re: NFS oddity (2.4.0test13pre4ac2 server, 2.0.36/2.2.14 clients)
Message-ID: <20001230000812.A16941@twiddle.net>
In-Reply-To: <14925.12964.995179.63899@notabene.cse.unsw.edu.au> <Pine.LNX.4.10.10012300105100.26235-100000@tardis.home.dave> <14925.16964.875883.863169@notabene.cse.unsw.edu.au> <20001230051825.Z28963@mea-ext.zmailer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <20001230051825.Z28963@mea-ext.zmailer.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 30, 2000 at 05:18:25AM +0200, Matti Aarnio wrote:
>   As the patch by mr. Kokshaysky is quite different doing more work
>   (and not only label name changes), I would prefer Richard Henderson
>   to act as an umpire to tell if your patch is sufficient, or if that
>   big thing by Kokshaysky is needed.

Ivan's code is needed.  You can't fall back to memcpy when
there is overlap.  The ev6 version _will_ corrupt data if
you do.


r~
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
