Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293283AbSCOV1D>; Fri, 15 Mar 2002 16:27:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293288AbSCOV04>; Fri, 15 Mar 2002 16:26:56 -0500
Received: from users.ccur.com ([208.248.32.211]:61832 "HELO rudolph.ccur.com")
	by vger.kernel.org with SMTP id <S293283AbSCOV0f>;
	Fri, 15 Mar 2002 16:26:35 -0500
From: jak@rudolph.ccur.com (Joe Korty)
Message-Id: <200203152125.VAA27707@rudolph.ccur.com>
Subject: Re: [PATCH] 2.4.18 scheduler bugs
To: mingo@elte.hu
Date: Fri, 15 Mar 2002 16:25:35 -0500 (EST)
Cc: joe.korty@ccur.com (Joe Korty), marcelo@conectiva.com.br (Marcelo Tosatti),
        alan@lxorguk.ukuu.org.uk (Alan Cox),
        torvalds@transmeta.com (Linus Torvalds), linux-kernel@vger.kernel.org
Reply-To: joe.korty@ccur.com (Joe Korty)
In-Reply-To: <Pine.LNX.4.44.0203152053001.21386-100000@elte.hu> from "Ingo Molnar" at Mar 15, 2002 08:55:52 PM
X-Mailer: ELM [version 2.5 PL0b1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> - reschedule_idle() - smp_send_reschedule when setting idle's need_resched
>> 
>>     Idle tasks nowdays don't spin waiting for need->resched to change,
>>     they sleep on a halt insn instead.  Therefore any setting of
>>     need->resched on an idle task running on a remote CPU should be
>>     accompanied by a cross-processor interrupt.
> 
> this is broken as well. Check out the idle=poll feature i wrote some time
> ago.

The idle=poll stuff is a hack.  I'd like my idle cpus to sleep and still
have them wake up the moment work for them becomes available.  I see no
reason why an idle cpu should be forced to remain idle until the next
tick, nor why fixing that should be considered `broken'.

Joe

