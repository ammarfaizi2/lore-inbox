Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751564AbWCLRyz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751564AbWCLRyz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 12:54:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751560AbWCLRyz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 12:54:55 -0500
Received: from hummeroutlaws.com ([12.161.0.3]:37900 "EHLO atpro.com")
	by vger.kernel.org with ESMTP id S1751322AbWCLRyz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 12:54:55 -0500
Date: Sun, 12 Mar 2006 12:54:21 -0500
From: Jim Crilly <jim@why.dont.jablowme.net>
To: Jun OKAJIMA <okajima@digitalinfra.co.jp>
Cc: Nigel Cunningham <ncunningham@cyclades.com>, linux-kernel@vger.kernel.org
Subject: Re: Faster resuming of suspend technology.
Message-ID: <20060312175421.GE24084@mail>
Mail-Followup-To: Jun OKAJIMA <okajima@digitalinfra.co.jp>,
	Nigel Cunningham <ncunningham@cyclades.com>,
	linux-kernel@vger.kernel.org
References: <200603112246.47596.ncunningham@cyclades.com> <200603120926.AA00811@bbb-jz5c7z9hn9y.digitalinfra.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603120926.AA00811@bbb-jz5c7z9hn9y.digitalinfra.co.jp>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/12/06 06:26:17PM +0900, Jun OKAJIMA wrote:
> >>
> >> Yes, right. In your way, there is no thrashing. but it slows booting.
> >> I mean, there is a trade-off between booting and after booted.
> >> But, what people would want is always both, not either.
> >
> >I don't understand what you're saying. In particular, I'm not sure why/how you 
> >think suspend functionality slows booting or what the tradeoff is "between 
> >booting and after booted".
> >
> 
> Sorry, I used words in not usual way.
> I refer "booting" as just resuming. And "after booted" means "after resumed".
> In other words, I treat swsusp2 as not note PC's hibernation equivalent,
> but just for faster booting technology.
> So, What I wanted to say was,
> 
>   --- Reading all image in advance ( your way) slows resuming itself.
>   --- Reading pages on demand ( e.g. VMware) slows apps after resumed.
> 
> Hope my English is understandable one...
> 

But you have to read all of the pages at some point so the hard disk is
going to be the bottleneck no matter what you do. And since Suspend2
currently saves the cache as a contiguous stream, possibly compressed, it
should be a good bit faster than seeking around the disk loading the files
from the filesystem.

> 
> >> Especially, your way has problem if you boot( resume ) not from HDD
> >> but for example, from NFS server or CD-R or even from Internet.
> >
> >Resuming from the internet? Scary. Anyway, I hope I'll understand better what 
> >you're getting at after your next reply.
> >
> 
> In Japan, it is not so scary.
> We have 100Mbps symmetric FTTH ( optical Fiber To The Home), and
> more than 1M homes have it, and price is about 30USD/month.
> With this, theoretically you can download 600MB ISO image in one min,
> and actually you can download 100MBytes suspend image within 30sec.
> So, not click to run (e.g. Java applet) but "click to resume" is not dreaming
> but rather feasible. You still think it is scary on this situation?
> 

I don't think the scary part is speed, but security. I for one wouldn't
want to resume from an image hosted on a remote machine unless I had some
way to be sure it wasn't tampered with, like gpg signing or something.

> >> >That said, work has already been done along the lines that you're
> >> > describing. You might, for example, look at the OLS papers from last
> >> > year. There was a paper there describing work on almost exactly what
> >> > you're describing.
> >>
> >> Could I have URL or title of the paper?
> >
> >http://www.linuxsymposium.org/2005/. I don't recall the title now, sorry, and 
> >can't tell you whether it's in volume 1 or 2 of the proceedings, but I'm sure 
> >it will stick out like a sore thumb.
> >
> >
> 
> I checked the URL but could not find the paper,
> with keywords of "Cunningham" or "swsusp" or "suspend".
> Could you tell me any keyword to find it?
> 

I took a quick look at the PDFs and I believe the section Nigel is talking
about is called "On faster application startup times: Cache stuffing, seek
profiling, adaptive preloading" in volume 1.

Jim.
