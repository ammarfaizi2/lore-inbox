Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292936AbSCAKiN>; Fri, 1 Mar 2002 05:38:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293682AbSCAKgU>; Fri, 1 Mar 2002 05:36:20 -0500
Received: from [195.157.147.30] ([195.157.147.30]:41230 "HELO
	pookie.dev.sportingbet.com") by vger.kernel.org with SMTP
	id <S310426AbSCAKdq>; Fri, 1 Mar 2002 05:33:46 -0500
Date: Fri, 1 Mar 2002 10:36:00 +0000
From: Sean Hunter <sean@dev.sportingbet.com>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Rik van Riel <riel@conectiva.com.br>, Bill Davidsen <davidsen@tmr.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.19-preX: What we really need: -AA patches finally in the tree
Message-ID: <20020301103600.D7765@dev.sportingbet.com>
Mail-Followup-To: Sean Hunter <sean@dev.sportingbet.com>,
	Davide Libenzi <davidel@xmailserver.org>,
	Rik van Riel <riel@conectiva.com.br>,
	Bill Davidsen <davidsen@tmr.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33L.0203010009510.2801-100000@imladris.surriel.com> <Pine.LNX.4.44.0202281942420.939-100000@blue1.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.44.0202281942420.939-100000@blue1.dev.mcafeelabs.com>; from davidel@xmailserver.org on Thu, Feb 28, 2002 at 07:43:57PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Excuse my stupidity, but would a patch that just adds Davide's macro and
changes all instances of 

current->policy |= SCHED_YIELD;
schedule();

to yield() be acceptable?  Is there more involved than that, because I am
perfectly happy to create and submit such a patch.

...or am I just being dumb?

Sean

On Thu, Feb 28, 2002 at 07:43:57PM -0800, Davide Libenzi wrote:
> On Fri, 1 Mar 2002, Rik van Riel wrote:
> 
> > Not at all. The yield() function would just be a define to
> > the code which no longer works with the new scheduler, ie:
> >
> > #define yield()				\
> > 	current->policy |= SCHED_YIELD;	\
> > 	schedule();
> 
> or better :
> 
> #define yield() \
> 	do { \
> 		current->policy |= SCHED_YIELD; \
> 		schedule(); \
> 	} while (0)
> 
> 
> 
> - Davide
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
