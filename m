Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132642AbQLJVyO>; Sun, 10 Dec 2000 16:54:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133079AbQLJVyE>; Sun, 10 Dec 2000 16:54:04 -0500
Received: from smtp5.libero.it ([193.70.192.55]:23954 "EHLO smtp5.libero.it")
	by vger.kernel.org with ESMTP id <S132642AbQLJVxz>;
	Sun, 10 Dec 2000 16:53:55 -0500
Message-ID: <3A33F448.258A731@alsa-project.org>
Date: Sun, 10 Dec 2000 22:23:20 +0100
From: Abramo Bagnara <abramo@alsa-project.org>
Organization: Opera Unica
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17 i586)
X-Accept-Language: it, en
MIME-Version: 1.0
To: Richard Henderson <rth@twiddle.net>
CC: Linux Kernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [2*PATCH] alpha I/O access and mb()
In-Reply-To: <3A31F094.480AAAFB@alsa-project.org> <20001209161013.A30555@twiddle.net> <3A334F7C.3205A3DF@alsa-project.org> <20001210104413.A31257@twiddle.net> <3A33D3A7.FCD55F4@alsa-project.org> <20001210124918.A31383@twiddle.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Henderson wrote:
> 
> On Sun, Dec 10, 2000 at 08:04:07PM +0100, Abramo Bagnara wrote:
> > ... the only missing things from core_t2.h are some defines to
> > permit to it to work when CONFIG_ALPHA_T2 is defined.
> 
> Have you tried it?  I did.  It works fine.
> 
> What _is_ defined in asm/core_t2.h is enough for alpha/lib/io.c to
> define out of line functions that asm/io.h then uses.

asm/io.h uses out of line function only when CONFIG_ALPHA_GENERIC is
defined, otherwise it uses (take writel as an example) __raw_writel that
IMHO need to be defined in core_t2.h.

core_t2.h is the only core_*.h file that does not define it and this is
why I've proposed that patch.

Perhaps there is a reason I don't understand and in this case I want to
apologize and I'd like to ask you to explain me what I'm missing.

-- 
Abramo Bagnara                       mailto:abramo@alsa-project.org

Opera Unica                          Phone: +39.546.656023
Via Emilia Interna, 140
48014 Castel Bolognese (RA) - Italy

ALSA project is            http://www.alsa-project.org
sponsored by SuSE Linux    http://www.suse.com

It sounds good!
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
