Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263595AbUAaH0o (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jan 2004 02:26:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263632AbUAaH0o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jan 2004 02:26:44 -0500
Received: from smtp2.clear.net.nz ([203.97.37.27]:58242 "EHLO
	smtp2.clear.net.nz") by vger.kernel.org with ESMTP id S263595AbUAaH0l
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jan 2004 02:26:41 -0500
Date: Sat, 31 Jan 2004 20:28:08 +1300
From: Nigel Cunningham <ncunningham@clear.net.nz>
Subject: Re: [Swsusp-devel] Software Suspend 2.0
In-reply-to: <20040131071619.GD7245@digitasaru.net>
To: trelane@digitasaru.net
Cc: Luke-Jr <luke7jr@yahoo.com>,
       swsusp-devel <swsusp-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <1075534088.18161.61.camel@laptop-linux>
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.4.4-8mdk
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <1075436665.2086.3.camel@laptop-linux>
 <200401310622.17530.luke7jr@yahoo.com>
 <1075531042.18161.35.camel@laptop-linux>
 <20040131064757.GB7245@digitasaru.net>
 <1075532166.17727.41.camel@laptop-linux> <20040131071619.GD7245@digitasaru.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again.

On Sat, 2004-01-31 at 20:16, Joseph Pingenot wrote:
> >In the past I have only done patches against the 2.6.x kernels. I'm
> >thinking, however, of requesting space on kernel.org for patches against
> >-rcX and -mm kernels. You're the second person to ask. If I get asked
> 
> That'd rock.  It's a very important thing nowadays.

Okay. I'll ask then.

> >some more, I might do it :> (It's not that it's hard, just that it takes
> 
> Hmm.  Do I have to be a *new* person to ask, or can I just keep
>   asking until you give in?  ;)

:> Okay, okay, I give in! (That wasn't hard, was it?!)

> >time and today is my last day working on the code full time).
> 
> Oi!  I'll give you five (US) dollars.  Is that near enough?  :)

:>

> Actually, in all seriousness, is there some sort of tips place
>   to give you money to fund the project?  Although I don't have
>   much time (working on yet another cpu governor, amongst other
>   things), I can not eat at a restauraunt for lunch a couple of
>   times and send the money your way.  :)

Sourceforge have a donations thing now, but I haven't done my bit to
sign the project up for it. Frankly, after all the support LinuxFund
gave over the last four months, I'd rather encourage people to give to
them :>

> >> Also, how does this differ from what is currently in the vanilla
> >>   kernels?
> >The best way to answer that is to point to
> >http://swsusp.sourceforge.net/features.html.
> 
> Ah.  Thankye.
> 
> A few last questions while I'm at it.  (I'm struggling to get it to work
>   with my new Dell Inspiron 8600.)  Is it alright to have the different
>   swsus/pmdisk versions enabled in the same kernel?  Finally, is there

Yes, I worked hard on making it play nicely with them. It does replace
the refrigerator they used, but if I've done it right and it hasn't been
broken it since (by any of the three of us), they shouldn't care.

>   any specific way to create the swap space for saving the state to?

Suspend2 will use any swap space you have available. It will even
automatically turn on a swap partition or file for you at the start of
suspending, and turn it off at the end. It doesn't care about how the
swap space is distributed or whether it's a partition or a file or a
combination. Saving to local IDE and SCSI is tested, but I've had
limited success with SCSI due to the lack of power management on the
drives I was testing with (the machine resumed up to the point where it
wanted to use the SCSI drive again with the restored kernel, at which
point the driver paniced because the request numbers were out of sync).

>   I created a swap partition (/dev/hda8 fwiw), made it type 82 and
>   ran mkswap on it.  However, after I tried to suspend, it didn't
>   recognize the saved data.

2.6 has problems with flushing caches properly at the moment. It might
be related to that. I'd need more info to properly diagnose the problem.

Nigel
-- 
Nigel Cunningham
495 St Georges Road South, Hastings 4201, New Zealand

Evolution (n): A hypothetical process whereby infinitely improbable events occur 
with alarming frequency, order arises from chaos, and no one is given credit.

