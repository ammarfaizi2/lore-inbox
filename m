Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129523AbQLKIcQ>; Mon, 11 Dec 2000 03:32:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130216AbQLKIcH>; Mon, 11 Dec 2000 03:32:07 -0500
Received: from smtp2.libero.it ([193.70.192.52]:7832 "EHLO smtp2.libero.it")
	by vger.kernel.org with ESMTP id <S129523AbQLKIbw>;
	Mon, 11 Dec 2000 03:31:52 -0500
Message-ID: <3A34898A.8629587F@alsa-project.org>
Date: Mon, 11 Dec 2000 09:00:10 +0100
From: Abramo Bagnara <abramo@alsa-project.org>
Organization: Opera Unica
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17 i586)
X-Accept-Language: it, en
MIME-Version: 1.0
To: Richard Henderson <rth@twiddle.net>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [2*PATCH] alpha I/O access and mb()
In-Reply-To: <3A31F094.480AAAFB@alsa-project.org> <20001209161013.A30555@twiddle.net> <3A334F7C.3205A3DF@alsa-project.org> <20001210104413.A31257@twiddle.net> <3A33D3A7.FCD55F4@alsa-project.org> <20001210124918.A31383@twiddle.net> <3A33F448.258A731@alsa-project.org> <20001210161955.A31596@twiddle.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Before of all I want to publicly apologize with Richard as never my
intention was to exacerbate him.

> 
> On Sun, Dec 10, 2000 at 10:23:20PM +0100, Abramo Bagnara wrote:
> > asm/io.h uses out of line function only when CONFIG_ALPHA_GENERIC is
> > defined, otherwise it uses (take writel as an example) __raw_writel that
> > IMHO need to be defined in core_t2.h.
> 
> Perhaps you should _show_ an actual failure rather than just guessing.

I've not access to this specific hardware but I was trying to fix the
alpha case wrt write[bwlq] function as I've had a lot of trouble with
ALSA drivers and 2.2 (that still now is broken wrt mb() and I've sent a
patch to Alpha Processor guys). This is the reason why I've given a look
to 2.4.

> 
> You are wildly incorrect asserting that out of line functions are used
> only with CONFIG_ALPHA_GENERIC.  You should examine
> 
> #ifndef __raw_writel
> # define __raw_writel(v,a)  ___raw_writel((v),(unsigned long)(a))
> #endif
> 
> and suchlike definitions.

Now I understand, thanks.

I see that some core*.h leaves out of line some functions because they
are more complex than a choosen threshold.

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
