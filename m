Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131197AbRA2WpJ>; Mon, 29 Jan 2001 17:45:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131199AbRA2Wot>; Mon, 29 Jan 2001 17:44:49 -0500
Received: from dns2.chaven.com ([207.238.162.18]:28574 "EHLO shell.chaven.com")
	by vger.kernel.org with ESMTP id <S131197AbRA2Wom>;
	Mon, 29 Jan 2001 17:44:42 -0500
Message-ID: <037d01c08a44$9bb9ace0$160912ac@stcostlnds2zxj>
From: "List User" <lists@chaven.com>
To: "Chris Evans" <chris@scary.beasts.org>, <Tony.Young@ir.com>
Cc: <chris@scary.beasts.org>, <slug@slug.org.au>, <csa@oss.sgi.com>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.30.0101291209290.3063-100000@ferret.lmh.ox.ac.uk>
Subject: Re: Linux Disk Performance/File IO per process
Date: Mon, 29 Jan 2001 16:41:18 -0600
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

Just wanted to 'chime' in here.  Yes this would be noisy and will have an
affect
on system performance however these statistics are what are used in
conjunction with
several others to size systems as well as to plan on growth.  If Linux is to
be put into
an enterprise environment these types of statistics will be needed.

When you start hooking up 100's of 'physical volumes' (be it real disks or
raided logical drives)
this data helps you pin-point problems.   I think the idea of having the
ability to turn such accounting
on/off via  /proc entry a very nice method of doing things.

That way you can leave it off for normal run-time but when users complain or
DBA's et al
you can turn it on get some stats for a couple hours/days whatever, then
turn it back off and
plan an upgrade or re-create a logical volume or stripping set.


Steve
----- Original Message -----
From: "Chris Evans" <chris@scary.beasts.org>
To: <Tony.Young@ir.com>
Cc: <chris@scary.beasts.org>; <slug@slug.org.au>; <csa@oss.sgi.com>;
<linux-kernel@vger.kernel.org>
Sent: Monday, January 29, 2001 07:26
Subject: RE: Linux Disk Performance/File IO per process


>
> On Mon, 29 Jan 2001 Tony.Young@ir.com wrote:
>
> > Thanks to both Jens and Chris - this provides the information I need to
> > obtain our busy rate
> > It's unfortunate that the kernel needs to be patched to provide this
> > information - hopefully it will become part of the kernel soon.
> >
> > I had a response saying that this shouldn't become part of the kernel
due to
> > the performance cost that obtaining such data will involve. I agree that
a
> > cost is involved here, however I think it's up to the user to decide
which
> > cost is more expensive to them - getting the data, or not being able to
see
> > how busy their disks are. My feeling here is that this support could be
user
> > configurable at run time - eg 'cat 1 > /proc/getdiskperf'.
>
> Hi,
>
> I disagree with this runtime variable. It is unnecessary complexity.
> Maintaining a few counts is total noise compared with the time I/O takes.
>
> Cheers
> Chris
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
