Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261199AbVEOS5N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261199AbVEOS5N (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 May 2005 14:57:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261201AbVEOS5N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 May 2005 14:57:13 -0400
Received: from rutherford.zen.co.uk ([212.23.3.142]:26269 "EHLO
	rutherford.zen.co.uk") by vger.kernel.org with ESMTP
	id S261199AbVEOS5J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 May 2005 14:57:09 -0400
Date: Sun, 15 May 2005 19:56:42 +0100
From: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
To: David Schwartz <davids@webmaster.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Hyper-Threading Vulnerability
Message-ID: <20050515185642.GH7100@gallifrey>
References: <20050515094352.GB68736@muc.de> <MDEHLPKNGKAHNMBLJOLKGEADDNAB.davids@webmaster.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKGEADDNAB.davids@webmaster.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/2.6.10-5-k7-smp (i686)
X-Uptime: 19:53:06 up 1 day,  7:26,  3 users,  load average: 2.05, 2.07, 2.02
User-Agent: Mutt/1.5.6+20040907i
X-Originating-Rutherford-IP: [212.23.14.246]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* David Schwartz (davids@webmaster.com) wrote:
> 
> Andi Kleen wrote:
> 
> > And what you're doing is to ask all the non crypto guys to give
> > up an useful optimization just to fix a problem in the crypto guy's
> > code. The cache line information leak is just a information leak
> > bug in the crypto code, not a general problem.
> 
> 	Portable code shouldn't even have to know that there is such a thing as a
> cache line. It should be able to rely on the operating system not to let
> other tasks with a different security context spy on the details of its
> operation.

I find it interesting to compare this thread with a thread from about
a week ago talking about how /proc/cpuinfo wasn't consistent
across architectures - where we come round to the view of whether
the application writers shouldn't care/are too dumb/shouldn't need
to know about/can't be trusted  with knowing about what the real
hardware is.

Personally I think this is a good case of where the application
should take care of it - with whatever support the OS can really
give.

(That is if this is actually a real problem and not just
purely theoretical - my crypto knowledge isn't good enough
to answer that - but it feels very very abstract).

Dave
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    | Running GNU/Linux on Alpha,68K| Happy  \ 
\ gro.gilbert @ treblig.org | MIPS,x86,ARM,SPARC,PPC & HPPA | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
