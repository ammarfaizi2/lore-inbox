Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286812AbRLVQQL>; Sat, 22 Dec 2001 11:16:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286818AbRLVQPx>; Sat, 22 Dec 2001 11:15:53 -0500
Received: from sushi.toad.net ([162.33.130.105]:7890 "EHLO sushi.toad.net")
	by vger.kernel.org with ESMTP id <S286812AbRLVQPb>;
	Sat, 22 Dec 2001 11:15:31 -0500
Subject: Re: APM driver patch summary
From: Thomas Hood <jdthood@mail.com>
To: Andreas Steinmetz <ast@domdv.de>
Cc: Borsenkow Andrej <Andrej.Borsenkow@mow.siemens.ru>,
        Russell King <rmk@arm.linux.org.uk>,
        Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org
In-Reply-To: <XFMail.20011222154452.ast@domdv.de>
In-Reply-To: <XFMail.20011222154452.ast@domdv.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 22 Dec 2001 11:13:58 -0500
Message-Id: <1009037653.807.14.camel@thanatos>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks.

I have put Andreas's idle patch, Russell King's notification patch,
and a combined patch up at:
   http://panopticon.csustan.edu/thood/apm.html

--
Thomas Hood

On Sat, 2001-12-22 at 09:44, Andreas Steinmetz wrote:
> Hi,
> I merged 2., 3. and 4. (attached) with some modifications.
> 
> 1. There is now a module parameter apm-idle-threshold which allows to override
>    the compiled in idle percentage threshold above which BIOS idle calls are
>    done.
> 
> 2. I modified Andrej's mechanism to detect a defunct BIOS (stating 'does stop
>    CPU' when it actually doesn't) to take into account that there's other
>    interrupts than the timer interrupt that could reactivate the cpu.
>    As there's 16 hardware interrupts on x86 (apm is arch specific anyway) I do
>    use a leaky bucket counter for a maximum of 16 idle rounds until jiffies is
>    increased. When the counter reaches zero it stays at this value and the
>    system idle routine is called. If BIOS idle is a noop then the counter
>    reaches zero fast, thus effectively halting the cpu.
> 
> Andrej, could you please test the patch if it works for your laptop?


