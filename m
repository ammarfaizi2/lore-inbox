Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315427AbSHaAr5>; Fri, 30 Aug 2002 20:47:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315445AbSHaAr5>; Fri, 30 Aug 2002 20:47:57 -0400
Received: from nameservices.net ([208.234.25.16]:13602 "EHLO opersys.com")
	by vger.kernel.org with ESMTP id <S315427AbSHaAr4>;
	Fri, 30 Aug 2002 20:47:56 -0400
Message-ID: <3D7012EC.C1FEF112@opersys.com>
Date: Fri, 30 Aug 2002 20:50:52 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.19 i686)
X-Accept-Language: en, French/Canada, French/France, fr-FR, fr-CA
MIME-Version: 1.0
To: "Ph. Marek" <marek@bmlv.gv.at>
CC: linux-kernel@vger.kernel.org, Richard Moore <richardj_moore@uk.ibm.com>
Subject: Re: AGAIN: Re: gettimeofday clock jump bug (on AMD 756)
References: <200208291200.54694.marek@bmlv.gv.at>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


"Ph. Marek" wrote:
> The difference is both times about 4295 seconds - so I think that the problem
> has something to do with 2^32 microseconds.

This 2^32 jump is consistent with the jumps I saw.

I was discussing this issue with Richard Moore (IBM) a couple of weeks
ago and he mentionned that they had seen a similar problem with OS/2.
In that case, the problems were due to the time it took to read some
timer register. In other words, there may be a short time-window where
the values available are valid and nothing is garanteed if we exceed this
time-window. (This is second hand and I may have misunderstood a couple
of details, so I attached Richard so he can confirm/deny what I'm saying
here.)

Linux reads the PIT (8253) every 10ms on a PC, so the question is:
anyone know about 8253 reading deadlines ?

Karim

===================================================
                 Karim Yaghmour
               karim@opersys.com
      Embedded and Real-Time Linux Expert
===================================================
