Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129663AbQKFHqU>; Mon, 6 Nov 2000 02:46:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129932AbQKFHqJ>; Mon, 6 Nov 2000 02:46:09 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:58376 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S129374AbQKFHpy>;
	Mon, 6 Nov 2000 02:45:54 -0500
Message-ID: <3A0661A1.668BD8CB@mandrakesoft.com>
Date: Mon, 06 Nov 2000 02:45:37 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
CC: Oliver Xymoron <oxymoron@waste.org>, Keith Owens <kaos@ocs.com.au>,
        linux-kernel@vger.kernel.org
Subject: Re: Persistent module storage [was Linux 2.4 Status / TODO page]
In-Reply-To: <Pine.LNX.4.21.0011060730410.14068-100000@imladris.demon.co.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse wrote:
> The desired mixer levels should be available to the module at the time of
> initialisation.

For drivers built into the kernel that gets messy.  The command line is
only so long.  Sounds messy for modules too.  Further (responding to
your other e-mail), few probably care about having the mixer containing
default, not custom, values for 10 seconds between driver init and aumix
execution from initscripts...

It sounds smarter to delay mixer initialization, or mute all mixer
channels at init.  That effectively initializes the mixer channels to
the custom values you desire, without having to add special case module
gunk for the subset of people who need correct mixer values Right
Now(tm).

	Jeff


-- 
Jeff Garzik             | Dinner is ready when
Building 1024           | the smoke alarm goes off.
MandrakeSoft            |	-/usr/games/fortune
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
