Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271578AbRIJSei>; Mon, 10 Sep 2001 14:34:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271582AbRIJSe2>; Mon, 10 Sep 2001 14:34:28 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:18426 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S271578AbRIJSeY>; Mon, 10 Sep 2001 14:34:24 -0400
Message-ID: <3B9D07AD.E3310270@mvista.com>
Date: Mon, 10 Sep 2001 11:34:21 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Timur Tabi <ttabi@interactivesi.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Which CPU do timers run on?
In-Reply-To: <3B9BD508.1050200@interactivesi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timur Tabi wrote:
> 
> When I create a timer (init_timer(), etc) on an SMP system, will the timer
> always run on one CPU, or can it run on any CPU?  If I disabled interrupts on
> only one CPU, will that disable the timer completely?
> 
I believe that timers, like other interrupts, are handled by the CPU
pool.  Interrupts can be pinned to a particular cpu, but I don't think
the timer interrupt is.

George
