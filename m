Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279914AbRJ3LFP>; Tue, 30 Oct 2001 06:05:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279916AbRJ3LE4>; Tue, 30 Oct 2001 06:04:56 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:32759 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S279914AbRJ3LEo>; Tue, 30 Oct 2001 06:04:44 -0500
Message-ID: <3BDE6A80.3A68A44E@mvista.com>
Date: Tue, 30 Oct 2001 00:53:20 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jonathan Briggs <zlynx@acm.org>
CC: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Nasty suprise with uptime
In-Reply-To: <E15yJD1-0003uO-00@the-village.bc.nu> <3BDDBE89.397E42C0@lexus.com> <20011029124753.F21285@one-eyed-alien.net> <4.3.2.7.2.20011029172525.00bb2270@mail.osagesoftware.com> <3BDDE642.8000901@acm.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Briggs wrote:
> 
> A 32 bit uptime patch should also include a new kernel parameter that
> could be passed from LILO: uptime.  Then you could test the uptime patch
> by passing uptime=4294967295
> 
> Or make /proc/uptime writable.

NO NO NO!  

First uptime is a conversion of jiffies.  Second, the POSIX standard
wants a CLOCK_MONOTONIC which, by definition, can not be set.  Jiffies
is the most reasonable source for this clock.  I am afraid you will have
to accumulate "real" time for uptime :)

George


> 
> David Relson wrote:
> 
> > Let's assume you have the counter changed to 32 bits - RIGHT NOW
> > (tm).  Build a kernel, install it, reboot.  It'll be over a year
> > (approx Jan 2003) before the change will be noticeable...
> >
> > Methinks that's a long time to wait for a result :-)
> >
> > David
> >
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
