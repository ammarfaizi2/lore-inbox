Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129991AbRCDC3D>; Sat, 3 Mar 2001 21:29:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130004AbRCDC2x>; Sat, 3 Mar 2001 21:28:53 -0500
Received: from granger.mail.mindspring.net ([207.69.200.148]:47122 "EHLO
	granger.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S129991AbRCDC2e>; Sat, 3 Mar 2001 21:28:34 -0500
Message-ID: <003001c0a452$ac242f60$1601a8c0@zeusinc.com>
From: "Tom Sightler" <ttsig@tuxyturvy.com>
To: "Keith Owens" <kaos@ocs.com.au>, <sjhill@cotw.com>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <22634.983669972@ocs3.ocs-net>
Subject: Re: LILO error with 2.4.3-pre1... 
Date: Sat, 3 Mar 2001 21:27:15 -0500
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


----- Original Message -----
From: "Keith Owens" <kaos@ocs.com.au>
To: <sjhill@cotw.com>
Cc: <linux-kernel@vger.kernel.org>
Sent: Saturday, March 03, 2001 8:39 PM
Subject: Re: LILO error with 2.4.3-pre1...


> On Sat, 03 Mar 2001 19:19:28 -0600,
> "Steven J. Hill" <sjhill@cotw.com> wrote:
> >I have no idea why the 1023 limit is coming up considering 2.4.2 and
> >LILO were working just fine together and I have a newer BIOS that has
> >not problems detecting the driver properly. Go ahead, call me idiot :).
>
> OK, you're an idiot :).  It only worked before because all the files
> that lilo used just happened to be below cylinder 1024.  Your partition
> goes past cyl 1024 and your new kernel is using space above 1024.

I would agree with this explanation.

> Find a version of lilo that can cope with cyl >= 1024 (is there one?)

Uh, the version he has can cope with this, see the following:

>    LILO version 21.4-4, Copyright (C) 1992-1998 Werner Almesberger
>    'lba32' extensions Copyright (C) 1999,2000 John Coffman

The lba32 extensions should take care of this, of course you have to add
'lba32' as a line in your lilo.conf before lilo actually uses them (and, I
assume, the BIOS must support the LBA extensions, but it seems most modern
ones do).

Give that a try.  Works for me.

Later,
Tom


