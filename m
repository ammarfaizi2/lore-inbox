Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132546AbQKDH1l>; Sat, 4 Nov 2000 02:27:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132535AbQKDH1a>; Sat, 4 Nov 2000 02:27:30 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:28939 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S132500AbQKDH1V>;
	Sat, 4 Nov 2000 02:27:21 -0500
Message-ID: <3A03BA36.3296AF2D@mandrakesoft.com>
Date: Sat, 04 Nov 2000 02:26:46 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.18pre18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Thomas Sailer <sailer@ife.ee.ethz.ch>, linux-kernel@vger.kernel.org
Subject: Re: Poll and OSS API
In-Reply-To: <Pine.LNX.4.10.10011032237270.25382-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> Considering that about 100% of the sound drivers do not follow that
> particular API damage anyway (they can't, as has been pointed out: the
> driver doesn't even receive enough information to be _able_ to follow the
> documented API), I doubt that there are all that many programs that depend
> on it.

While I'm thinking about the subject..  even after updating the API, the
drivers still need to know what events to poll for.

AFAIK 99% of the drivers currently select to block on
read/write/read+write based on file->f_mode, which works, but isn't
really correct.

	Jeff


-- 
Jeff Garzik             | Dinner is ready when
Building 1024           | the smoke alarm goes off.
MandrakeSoft            |	-/usr/games/fortune
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
