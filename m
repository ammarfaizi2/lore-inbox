Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131598AbQLYQsj>; Mon, 25 Dec 2000 11:48:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131866AbQLYQsa>; Mon, 25 Dec 2000 11:48:30 -0500
Received: from smtp01.mrf.mail.rcn.net ([207.172.4.60]:9706 "EHLO
	smtp01.mrf.mail.rcn.net") by vger.kernel.org with ESMTP
	id <S131598AbQLYQsY>; Mon, 25 Dec 2000 11:48:24 -0500
Message-ID: <3A477333.1BC64D4C@haque.net>
Date: Mon, 25 Dec 2000 11:17:55 -0500
From: "Mohammad A. Haque" <mhaque@haque.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test13-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: test13-pre4... udf problem with dvd access vs test12
In-Reply-To: <3A47212D.F9F119C3@xmission.com> <3A476C7D.1952EDB4@haque.net> <3A477014.CE908BFC@haque.net> <20001225171305.G303@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix confirmed. Am i supposed to get some DriveSense errors? I probably
am just don't recall.

Jens Axboe wrote:
> Yes I know about this one, I've attached the patch here again. Linus,
> could you apply?
> 
> --- drivers/ide/ide-cd.c~       Sat Dec 23 23:59:52 2000
> +++ drivers/ide/ide-cd.c        Sun Dec 24 00:03:38 2000
> @@ -333,7 +333,7 @@
>  {
>         int log = 0;
> 
> -       if (sense == NULL || pc->quiet)
> +       if (sense == NULL || pc == NULL || pc->quiet)
>                 return 0;
> 
>         switch (sense->sense_key) {
> 
> --
> * Jens Axboe <axboe@suse.de>
> * SuSE Labs

-- 

=====================================================================
Mohammad A. Haque                              http://www.haque.net/ 
                                               mhaque@haque.net

  "Alcohol and calculus don't mix.             Project Lead
   Don't drink and derive." --Unknown          http://wm.themes.org/
                                               batmanppc@themes.org
=====================================================================
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
