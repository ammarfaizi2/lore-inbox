Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263473AbRFMRde>; Wed, 13 Jun 2001 13:33:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263904AbRFMRdX>; Wed, 13 Jun 2001 13:33:23 -0400
Received: from 20dyn128.com21.casema.net ([213.17.90.128]:12305 "HELO
	home.ds9a.nl") by vger.kernel.org with SMTP id <S263473AbRFMRdI>;
	Wed, 13 Jun 2001 13:33:08 -0400
Date: Wed, 13 Jun 2001 19:31:39 +0200
From: bert hubert <ahu@ds9a.nl>
To: linux-kernel@vger.kernel.org
Subject: Re: threading question
Message-ID: <20010613193139.A10072@home.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0106121213570.24593-100000@gene.pbi.nrc.ca> <Pine.GSO.4.10.10106121200330.20809-100000@orbit-fe.eng.netapp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.10.10106121200330.20809-100000@orbit-fe.eng.netapp.com>; from kmacy@netapp.com on Tue, Jun 12, 2001 at 12:06:40PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2001 at 12:06:40PM -0700, Kip Macy wrote:
> This may sound like flamebait, but its not. Linux threads are basically
> just processes that share the same address space. Their performance is
> measurably worse than it is on most commercial Unixes and FreeBSD.

Thread creation may be a bit slow. But the kludges to provide posix threads
completely from userspace also hurt. Notably, they do not scale over
multiple CPUs.

> They are not, or at least two years ago, were not POSIX compliant
> (they behaved badly with respect to signals). The impoverished

POSIX threads are silly with respect to signals. I do almost all my
programming these days with pthreads and I find that I really do not miss
signals at all.

> from Larry McVoy's home page attributed to Alan Cox illustrates this
> reasonably well: "A computer is a state machine. Threads are for people
> who can't program state machines." Sorry for not being more helpful.

I got that response too. When I pressed kernel people for details it turns
out that they think having hundreds of runnable threads/processes (mostly
the same thing under Linux) is wasteful. The scheduler is just not optimised
for that.

Regards,

bert

-- 
http://www.PowerDNS.com      Versatile DNS Services  
Trilab                       The Technology People   
'SYN! .. SYN|ACK! .. ACK!' - the mating call of the internet
