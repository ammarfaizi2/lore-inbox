Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267915AbRGWS7u>; Mon, 23 Jul 2001 14:59:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268330AbRGWS7j>; Mon, 23 Jul 2001 14:59:39 -0400
Received: from 216-60-128-137.ati.utexas.edu ([216.60.128.137]:36824 "HELO
	tsunami.webofficenow.com") by vger.kernel.org with SMTP
	id <S267915AbRGWS7a>; Mon, 23 Jul 2001 14:59:30 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@webofficenow.com>
Reply-To: landley@webofficenow.com
To: Horst von Brand <vonbrand@sleipnir.valparaiso.cl>,
        landley@webofficenow.com
Subject: Re: NFS Client patch
Date: Mon, 23 Jul 2001 05:57:34 -0400
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200107230202.f6N228NG016619@sleipnir.valparaiso.cl>
In-Reply-To: <200107230202.f6N228NG016619@sleipnir.valparaiso.cl>
MIME-Version: 1.0
Message-Id: <01072305573400.00996@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Sunday 22 July 2001 22:02, Horst von Brand wrote:
> Rob Landley <landley@webofficenow.com> said:
> > On Thursday 19 July 2001 14:24, Pavel Machek wrote:
>
> [...]
>
> > > > No, if the file was removed, it still tells you where to start your
> > > > search.  A missing filename is just as good a marker as a present
> > > > one.
> > >
> > > And if new file is created with same name?
> >
> > The same thing that happens as if a new file was inserted BEFORE your
> > cursor, in the part of the directory you've already looked at.  You
> > ignore it.
>
> Who says that if I've got files A, B, C, D, and delete B, and create a new
> B, whatever underlying directory structure there is will place it where the
> old B was? It might reuse holes before A...

I suppose the assumption was that the directory entries are returned in 
alphabetically sorted order, even if the underlying filesystem doesn't do 
that.  Maybe this is a waste of effort on the server's part (and 
generating/maintaining other sorts of cookies aren't?), but it also seems 
fairly easy to make it work.  (I could easily be missing something obvious...)

Rob
