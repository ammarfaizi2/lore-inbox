Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266667AbRGEIr7>; Thu, 5 Jul 2001 04:47:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266668AbRGEIru>; Thu, 5 Jul 2001 04:47:50 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:52404 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S266667AbRGEIro>;
	Thu, 5 Jul 2001 04:47:44 -0400
Message-ID: <3B4429AA.208BB183@mandrakesoft.com>
Date: Thu, 05 Jul 2001 04:47:38 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Oleg I. Vdovikin" <vdovikin@jscc.ru>
Cc: Richard Henderson <rth@twiddle.net>, alan@redhat.com,
        torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [patch] Re: alpha - generic_init_pit - why using RTC for  
 calibration?
In-Reply-To: <022901c10095$f4fca650$4d28d0c3@jscc.ru> <20010629211931.A582@jurassic.park.msu.ru> <20010704114530.A1030@twiddle.net> <003e01c10522$1c9cf580$4d28d0c3@jscc.ru> <3B441618.638A3FC@mandrakesoft.com> <00a001c1052d$a3201320$4d28d0c3@jscc.ru>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg,

How is this relative to HZ, when you remove all references to HZ?

> -#define CALIBRATE_LATCH        (52 * LATCH)
> -#define CALIBRATE_TIME (52 * 1000020 / HZ)
> +#define CALIBRATE_LATCH        0xffff
[...]
> +       /* and the final result in HZ */
> +       return ((unsigned long)cc * CLOCK_TICK_RATE) / CALIBRATE_LATCH;

and in asm-alpha/timex.h,
> #define CLOCK_TICK_RATE 1193180 /* Underlying HZ */

-- 
Jeff Garzik      | Thalidomide, eh? 
Building 1024    | So you're saying the eggplant has an accomplice?
MandrakeSoft     |
