Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262610AbUKXLH0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262610AbUKXLH0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 06:07:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262613AbUKXLH0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 06:07:26 -0500
Received: from rproxy.gmail.com ([64.233.170.193]:45884 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262610AbUKXLHR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 06:07:17 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=Zj4OnwsYkxJCcr6jFlpYqvrtyKVa7/YibkKwZ07YeamVmVsIGYTUec83E1TmE+mwCxTjvvOa2VGVMubPNHkgFX/OytwSwstjjH4PMwq6iPj4beXhIK1sUzA//Bkfv/AV/1KNPaVdRZhQaWCcqwFUsM/6tI878zMlwsfB3g9CvjY=
Message-ID: <2c59f00304112403076b497bd1@mail.gmail.com>
Date: Wed, 24 Nov 2004 16:37:16 +0530
From: Amit Gud <amitgud1@gmail.com>
Reply-To: Amit Gud <amitgud1@gmail.com>
To: Helge Hafting <helge.hafting@hist.no>
Subject: Re: file as a directory
Cc: linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
In-Reply-To: <41A4632D.4060608@hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <2c59f00304112205546349e88e@mail.gmail.com>
	 <41A1FFFC.70507@hist.no> <2c59f003041122222038834d7e@mail.gmail.com>
	 <41A4632D.4060608@hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Nov 2004 11:32:13 +0100, Helge Hafting <helge.hafting@hist.no> wrote:
> Amit Gud wrote:
> 
> 
> 
> >On Mon, 22 Nov 2004 16:04:28 +0100, Helge Hafting <helge.hafting@hist.no> wrote:
> >
> >
> >
> >>You won't get .tar or .tar.gz support in the VFS, for a few simple reasons:
> >>1. .tar and .tar.gz are complicated formats, and are therefore better
> >>   left to userland.
> >>
> >>
> >
> >Agreed that .tar.gz is a complicated format, but zlib is already in
> >the kernel. It _should_ simplify inflate and deflate of files. And as
> >compared to .gz format, .tar is much simpler, I guess.
> >
> >
> >
> >>   It is hard to make a guaranteed bug-free decompressor that
> >>   is efficient and works with a finite amount of memory.  The kernel
> >>   needs all that - userland doesn't.
> >>
> >>
> >
> >I think, finite amount of memory is the concern of worry, not the rest
> >... if we could rely on zlib.
> >
> >
> >
> >>2. Both .tar and .gz  file formats may improve with time.  Getting a new
> >>    version of tar og gunzip is easy enough - getting another compression
> >>    algorithm into the kernel won't be that easy.
> >>
> >>
> >
> >Doesn't zlib in the kernel gets updated as the formats change? If not,
> >.tar formats would be worth trying first as proof of concept.
> >
> This is not so easy, as you have to audit the new version for
> correctness.  It is not the end of the world if tar or gzip
> occationally crashes on some corner case.   The kernel
> must not do that though.
> 

Yes, thats what I said in my last post...if the archive looks improper
forget it.

> And then there is the much more complicated issues when
> writing into such an archive.  You skipped that part, or
> are you looking for a read-only solution only?
> 

I'm coming up with something soon, along with the proof of
concept....to wrap up all scenarios....need some time ;)

AG
