Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275862AbRJBIf4>; Tue, 2 Oct 2001 04:35:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275963AbRJBIfq>; Tue, 2 Oct 2001 04:35:46 -0400
Received: from zok.SGI.COM ([204.94.215.101]:45539 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S275862AbRJBIfi>;
	Tue, 2 Oct 2001 04:35:38 -0400
From: "LA Walsh" <law@sgi.com>
To: "Matti Aarnio" <matti.aarnio@zmailer.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: 'dd' local works, but not over net, help as to why?
Date: Tue, 2 Oct 2001 01:35:28 -0700
Message-ID: <NDBBJDKDKDGCIJFBPLFHAEKACGAA.law@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <20011002112005.K1144@mea-ext.zmailer.org>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org
> [mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Matti Aarnio
> Sent: Tuesday, October 02, 2001 1:20 AM
> To: LA Walsh
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: 'dd' local works, but not over net, help as to why?
>
>
> On Tue, Oct 02, 2001 at 12:52:48AM -0700, LA Walsh wrote:
> > I'm sure there's an obvious answer to this, but it is eluding me.
>     Probably...
>
> > If I am on my local laptop, I can 'dd' an 8G partition to a
> > removable HD of the same or slightly larger size (slightly large
> > because of geometry differences).
> >
> > If I am on my desktop, "I can 'dd' the same size partition to
> > a slightly larger one -- again, no problem.
> >
> > But if I use:
> >
> > dd if=/dev/hda2 bs=1M|rsh other-system of=/dev/sda2 bs=1M, I
> > get failures of running out of room on target.  I've tried
> > a variety of block size ranging from 1K->64G, but no luck.
>
>    You are missing one 'dd' from the other system side, but
>    are you also sure that the remote system can support large
>    files, and that the dd in there does support large files ?
---
	Missing 'dd' typo.  It's on the other system I tried copying the 8G
to a slightly large 9G partition -- that worked.  On the source system
I can copy 8G to another 8G partition.  Just running them over rsh seems to
be a problem.  Same version of 'dd' on each side (SuSE 7.2).

	Maybe I can fool ftp with symlinks tomorrow into doing the copy and see
if that works.  Just for fun I tried 'cat' as well -- same error -- out of
space on target.

It transfers a lot of data -- right around 2G the first time I tried it, so
it looked awfully suspicious.

Linda

