Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287595AbSAEHys>; Sat, 5 Jan 2002 02:54:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287593AbSAEHyj>; Sat, 5 Jan 2002 02:54:39 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:16380 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S287582AbSAEHya> convert rfc822-to-8bit; Sat, 5 Jan 2002 02:54:30 -0500
Message-ID: <3C36B112.5A533652@mvista.com>
Date: Fri, 04 Jan 2002 23:53:54 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>
CC: mingo@elte.hu,
        "Dieter =?iso-8859-1?Q?N=FCtzel?=" <Dieter.Nuetzel@hamburg.de>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [announce] [patch] ultra-scalable O(1) SMP and UP scheduler
In-Reply-To: <Pine.LNX.4.33.0201041238350.2247-100000@localhost.localdomain> <200201050031.g050V7217956@mailf.telia.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roger Larsson wrote:
> 
> On Fridayen den 4 January 2002 12.42, Ingo Molnar wrote:
> > On Fri, 4 Jan 2002, Dieter [iso-8859-15] Nützel wrote:
> > > What next? Maybe a combination of O(1) and preempt?
> >
> > yes, fast preemption of kernel-mode tasks and the scheduler code are
> > almost orthogonal. So i agree that to get the best interactive performance
> > we need both.
> >
> >       Ingo
> >
> > ps. i'm working on fixing the crashes you saw.
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> 
> Ingo,
> 
> The preemtion kernel adds protection to per process data...
> And it is not (yet) updated to handle the O(1) scheduler!

The two patches will are not compatable.  When the time comes we will
have to work out how to make them compatable as they both modify key
parts of sched.c.

George
> 
> /RogerL
> 
> --
> Roger Larsson
> Skellefteå
> Sweden
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
George           george@mvista.com
High-res-timers: http://sourceforge.net/projects/high-res-timers/
Real time sched: http://sourceforge.net/projects/rtsched/
