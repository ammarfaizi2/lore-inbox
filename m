Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932299AbVHNVUV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932299AbVHNVUV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Aug 2005 17:20:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932302AbVHNVUV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Aug 2005 17:20:21 -0400
Received: from nproxy.gmail.com ([64.233.182.206]:60841 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932299AbVHNVUU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Aug 2005 17:20:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UnpgJ6Ha+zk8c7SjOGHX4j6R22Q8uQBmgwEZaJEOdJGoQdLW1BJVll/ainxb6XouXsexqGImWkgt+YBeUQuCTVZ3pJlkKb47MpXv56w60S5lgw+19/nmZ6TH4IRE8VJxOV4v3Vi7j8jnSbaELDdfUxnZQVHT3sSBZEA5TRWsiFg=
Message-ID: <58cb370e050814142013db4ba1@mail.gmail.com>
Date: Sun, 14 Aug 2005 23:20:16 +0200
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: IT8212/ITE RAID
Cc: Daniel Drake <dsd@gentoo.org>, CaT <cat@zip.com.au>,
       linux-kernel@vger.kernel.org
In-Reply-To: <1124054033.26937.3.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050814053017.GA27824@zip.com.au> <42FF263A.8080009@gentoo.org>
	 <20050814114733.GB27824@zip.com.au> <42FF3CBA.1030900@gentoo.org>
	 <1124026385.14138.37.camel@localhost.localdomain>
	 <58cb370e050814080120291979@mail.gmail.com>
	 <1124034767.14138.55.camel@localhost.localdomain>
	 <58cb370e050814085613ccc42c@mail.gmail.com>
	 <1124054033.26937.3.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/14/05, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Sul, 2005-08-14 at 17:56 +0200, Bartlomiej Zolnierkiewicz wrote:
> > * your stuff was accepted after all (and some stuff like ide-cd
> >   fixes was never splitted from the -ac patchset and submitted)
> 
> They were.

I remember discussion about end-of-media ide-cd fixes but the patch
was never submitted.  If you have *URL* to the patch I'll work on the patch.

> > * you've never provided any technical details on "the stuff I broke"
> 
> I did, several times. I had some detailed locking discussions with
> Manfred and others on it as a result. The locking in the base IDE is
> still broken, in fact its become worse - the random locking around
> timing changes now causes some PIIX users to see double spinlock debug
> with the base kernel as an example.

Huh?  *WHICH* my patch causes this?

I don't remember this discussion et all, care to give some pointers?

> > > Would make sense, but I thought I had the right bits masked. Will take a
> >
> > WIN_RESTORE is send unconditionally (as it always was),
> >
> > This is not the right thing, somebody should go over all ATA/ATAPI
> > drafts and come with the correct strategy of handling WIN_RESTORE.
> 
> Ok that would make sense. Matthew Garrett also reported some problems in
> that area with suspend/resume (BIOS restoring its idea of things...)

Quite likely, WIN_RESTORE is not sent on resume etc.
