Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129306AbRA3CxN>; Mon, 29 Jan 2001 21:53:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129101AbRA3CxD>; Mon, 29 Jan 2001 21:53:03 -0500
Received: from dns2.chaven.com ([207.238.162.18]:61342 "EHLO shell.chaven.com")
	by vger.kernel.org with ESMTP id <S129306AbRA3Cwu>;
	Mon, 29 Jan 2001 21:52:50 -0500
Message-ID: <007201c08a67$42a925e0$160912ac@stcostlnds2zxj>
From: "List User" <lists@chaven.com>
To: "James Sutherland" <jas88@cam.ac.uk>
Cc: "Chris Evans" <chris@scary.beasts.org>, <Tony.Young@ir.com>,
        <slug@slug.org.au>, <csa@oss.sgi.com>, <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.SOL.4.21.0101300215050.21740-100000@green.csi.cam.ac.uk>
Subject: Re: Linux Disk Performance/File IO per process
Date: Mon, 29 Jan 2001 20:49:21 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It depends on what the performance hit is 'after coding'.  If the code is
say less than 5%
overhead I honestly don't see there being a problem then just to compile it
in the kernel
and keep it active all the time.  Only people who would need it would
compile it in, and
from experience 5% or less for the systems that would be keeping this data
is negligible
considering functionality/statistics gained.


Steve
----- Original Message -----
From: "James Sutherland" <jas88@cam.ac.uk>
To: "List User" <lists@chaven.com>
Cc: "Chris Evans" <chris@scary.beasts.org>; <Tony.Young@ir.com>;
<slug@slug.org.au>; <csa@oss.sgi.com>; <linux-kernel@vger.kernel.org>
Sent: Monday, January 29, 2001 20:18
Subject: Re: Linux Disk Performance/File IO per process


> On Mon, 29 Jan 2001, List User wrote:
>
> > Just wanted to 'chime' in here.  Yes this would be noisy and will have
> > an affect on system performance however these statistics are what are
> > used in conjunction with several others to size systems as well as to
> > plan on growth.  If Linux is to be put into an enterprise environment
> > these types of statistics will be needed.
> >
> > When you start hooking up 100's of 'physical volumes' (be it real
> > disks or raided logical drives) this data helps you pin-point
> > problems.  I think the idea of having the ability to turn such
> > accounting on/off via /proc entry a very nice method of doing things.
>
> Question: how will the extra overhead of checking this configuration
> compare with just doing it anyway?
>
> If the code ends up as:
>
> if (stats_enabled)
>   counter++;
>
> then you'd be better off keeping stats enabled all the time...
>
> Obviously it'll be a bit more complex, but will the stats code be able to
> remove itself completely when disabled, even at runtime??
>
> Might be possible with IBM's dprobes, perhaps...?
>
> > That way you can leave it off for normal run-time but when users
> > complain or DBA's et al you can turn it on get some stats for a couple
> > hours/days whatever, then turn it back off and plan an upgrade or
> > re-create a logical volume or stripping set.
>
> NT allows boot-time (en|dis)abling of stats; they quote a percentage for
> the performance hit caused - 4%, or something like that?? Of course, they
> don't say whether that's a 486 on a RAID array or a quad Xeon on IDE, so
> the accuracy of that figure is a bit questionable...
>
>
> James.
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
>

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
