Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314162AbSDMAdz>; Fri, 12 Apr 2002 20:33:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314163AbSDMAdy>; Fri, 12 Apr 2002 20:33:54 -0400
Received: from relay04.valueweb.net ([216.219.253.238]:23314 "EHLO
	relay04.valueweb.net") by vger.kernel.org with ESMTP
	id <S314162AbSDMAdx>; Fri, 12 Apr 2002 20:33:53 -0400
Message-ID: <3CB77C73.3981374@opersys.com>
Date: Fri, 12 Apr 2002 20:31:47 -0400
From: Karim Yaghmour <karym@opersys.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.16-TRACE i686)
X-Accept-Language: en, French/Canada, French/France, fr-FR, fr-CA
MIME-Version: 1.0
To: Eyal Lebedinsky <eyal@eyal.emu.id.au>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux Trace Toolkit ready for 2.5
In-Reply-To: <3CB61523.89BE3422@opersys.com> <3CB76113.ABEAA49E@eyal.emu.id.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Eyal Lebedinsky wrote:
> > #define TRACE_SCHEDCHANGE(OUT, IN) \
> >            do \
> >            {\
> >            trace_schedchange sched_event;\
> >            sched_event.out       = OUT->pid;\
> >            sched_event.in        = (uint32_t) IN;\
> >            sched_event.out_state = OUT->state; \
> >            trace_event(TRACE_EV_SCHEDCHANGE, &sched_event);\
> >            } while(0);
> 
> The macro body should not have the terminating semicolon. This is
> the whole point of this trick, allowing it to be used safely in if
> statements like a function.

True. Although those trace statements have never been called upon to
be in if statements, your observation is correct. Thanks.

Karim

===================================================
                 Karim Yaghmour
               karym@opersys.com
      Embedded and Real-Time Linux Expert
===================================================
