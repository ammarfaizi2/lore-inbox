Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269067AbRHWRaV>; Thu, 23 Aug 2001 13:30:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269197AbRHWRaN>; Thu, 23 Aug 2001 13:30:13 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:22269 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S269067AbRHWRaB>; Thu, 23 Aug 2001 13:30:01 -0400
Message-ID: <3B853D40.33BD96D9@mvista.com>
Date: Thu, 23 Aug 2001 10:28:32 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Maksim Krasnyanskiy <maxk@qualcomm.com>
CC: "Raj, Ashok" <ashok.raj@intel.com>,
        "Linux-Kernel (E-mail)" <linux-kernel@vger.kernel.org>
Subject: Re: tasklet question...
In-Reply-To: <4.3.1.0.20010822153241.01f40100@mail1>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maksim Krasnyanskiy wrote:
> 
> >processing in the tasklet would like to reschedule tasklet again. will the following work
> >
> >tasklet_function()
> >{
> >         more_processing = DeferredProcessing()
> >             if (more_processing)
> >                tasklet_schedule() // this will schedule the same tasklet.
> >}
> >
> >is the above legal.
> It's fine and it will work.
> 
Does the tasklet get run again on the same interrupt (assuming that
tasklets are run at the end of irq processing) or the next one?

If the same, it would seem to be better to just do it.

George
