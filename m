Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314154AbSDLWfH>; Fri, 12 Apr 2002 18:35:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314155AbSDLWfG>; Fri, 12 Apr 2002 18:35:06 -0400
Received: from CPE-203-51-26-88.nsw.bigpond.net.au ([203.51.26.88]:36080 "EHLO
	e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id <S314154AbSDLWfG>; Fri, 12 Apr 2002 18:35:06 -0400
Message-ID: <3CB76113.ABEAA49E@eyal.emu.id.au>
Date: Sat, 13 Apr 2002 08:34:59 +1000
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Karim Yaghmour <karym@opersys.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux Trace Toolkit ready for 2.5
In-Reply-To: <3CB61523.89BE3422@opersys.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Karim Yaghmour wrote:
> 
> I have prepared a 2.5.7 patch for the Linux Trace Toolkit.
> 
> #define TRACE_SCHEDCHANGE(OUT, IN) \
>            do \
>            {\
>            trace_schedchange sched_event;\
>            sched_event.out       = OUT->pid;\
>            sched_event.in        = (uint32_t) IN;\
>            sched_event.out_state = OUT->state; \
>            trace_event(TRACE_EV_SCHEDCHANGE, &sched_event);\
>            } while(0);

The macro body should not have the terminating semicolon. This is
the whole point of this trick, allowing it to be used safely in if
statements like a function.

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
