Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291942AbSBNWSf>; Thu, 14 Feb 2002 17:18:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291948AbSBNWSZ>; Thu, 14 Feb 2002 17:18:25 -0500
Received: from fsgi03.fnal.gov ([131.225.68.48]:46425 "EHLO fsgi03.fnal.gov")
	by vger.kernel.org with ESMTP id <S291942AbSBNWSS>;
	Thu, 14 Feb 2002 17:18:18 -0500
Date: Thu, 14 Feb 2002 16:18:07 -0600
From: Alexander Moibenko <moibenko@fnal.gov>
To: Andrew Morton <akpm@zip.com.au>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: fsync delays for a long time.
In-Reply-To: <3C6C2F13.B8A30DB@zip.com.au>
Message-ID: <Pine.SGI.4.31.0202141617010.3270649-100000@fsgi03.fnal.gov>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Feb 2002, Andrew Morton wrote:

> Alexander Moibenko wrote:
> >
> > On Thu, 14 Feb 2002, Alan Cox wrote:
> >
> > > > > > This could very well be due to request allocation starvation.
> > > > > > fsync is sleeping in __get_request_wait() while bonnie keeps
> > > > > > on stealing all the requests.
> > > > >
> > > > > That may amplify it but in the 2.2 case fsync on any sensible sized file
> > > > > is already horribly performing. It hits databases like solid quite badly
> > > > >
> > > > please elaborate on "sensible sized". In my case it is less then 20MB.
> > >
> > > That ought to be ok. Andrew may well be right in that case.
> > >
> > Then what is your advise. Switch to 2.4.x?
>
> I would recommend that, yes.  One consideration: if the problem
> is still appearing in 2.4 then it is about 1000 times more
> likely to get fixed.
Thanks a lot.
>
> What filesystem were you using, BTW?  ext2?
Yes, it is ext2
>
> If you do test on 2.4, and the problem still appears, please try
>
> wget http://www.zip.com.au/~akpm/linux/2.4/2.4.18-pre9/make_request.patch
> patch -p1 < make_request.patch
>

