Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288512AbSBIHSJ>; Sat, 9 Feb 2002 02:18:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288557AbSBIHSA>; Sat, 9 Feb 2002 02:18:00 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:761 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S288512AbSBIHRm>; Sat, 9 Feb 2002 02:17:42 -0500
Message-ID: <3C64CCF2.124684D@mvista.com>
Date: Fri, 08 Feb 2002 23:17:06 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Mike Fedyk <mfedyk@matchmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [patch] larger kernel stack (8k->16k) per task
In-Reply-To: <Pine.LNX.4.33.0202081645170.1359-100000@einstein.homenet> <d3eljvlo5u.fsf@lxplus052.cern.ch> <20020208211221.GB343@mis-mike-wstn>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Fedyk wrote:
> 
> On Fri, Feb 08, 2002 at 09:22:05PM +0100, Jes Sorensen wrote:
> > Tigran Aivazian <tigran@veritas.com> writes:
> >
> > > So, I found this patch useful at least for debugging. Moreover, I think it
> > > would be very useful to have it in Linus' kernel as a CONFIG_ option so
> > > that if people complain about random memory corruption then they can try
> > > to reproduce it with larger stack and then (with aid of /proc/stack) the
> > > offender is found and fixed. I cc'd Alan; if he thinks this is a bad idea
> > > I would be interested to know why.
> >
> > Well as someone suggested, stick it under CONFIG_SLAB_DEBUG then, it
> 
> That was suggested by Andrew Morton...
> 
> > surely shouldn't be an option to be enabled in normal production
> > kernels but for debugging it's fine.
> >
> 
> Ahh, but if you are overflowing the stack by a few bytes, and then enable
> stack debugging the error will go away because of the alrger stack.

It really isn't that hard (or expensive) to put a stack overflow test in
entry.S.  Of course this should be a debug config option.

George
> 
> If this goes in, it should have its own config option.
> 
> Mike
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
George           george@mvista.com
High-res-timers: http://sourceforge.net/projects/high-res-timers/
Real time sched: http://sourceforge.net/projects/rtsched/
