Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285325AbRLGACH>; Thu, 6 Dec 2001 19:02:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285328AbRLGABy>; Thu, 6 Dec 2001 19:01:54 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:62477 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S285333AbRLGABl>; Thu, 6 Dec 2001 19:01:41 -0500
Message-ID: <3C1006C3.895EEE9F@zip.com.au>
Date: Thu, 06 Dec 2001 16:01:07 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: James Stevenson <mistral@stev.org>
CC: Roy Sigurd Karlsbakk <roy@karlsbakk.net>, linux-kernel@vger.kernel.org
Subject: Re: temporarily system freeze with high I/O write to ext2 fs
In-Reply-To: <Pine.LNX.4.30.0112061458360.15516-100000@mustard.heime.net> <3C0FD78D.F567ECBD@zip.com.au> <00e601c17eb0$25e20d80$0801a8c0@Stev.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Stevenson wrote:
> 
> > > why is it that Linux 'hangs' while doing heavy I/O operations (such as
> dd)
> > > to (and perhaps from?) ext2 file systems? I can't see the same behaivour
> > > when using other file systems, such as ReiserFS
> > >
> >
> > A partial fix for this went into 2.4.17-pre2.  What kernel are you
> > using?
> 
> i have always had with problem normally during disk writes.
> currently on 2.4.x-14 + 2.4.16

Please try 2.4.17-pre2 or later.

> > For how long does it "hang"?   What exactly are you doing when it
> > occurs?
> 
> its not that it hangs but it gets extremely laggy eg 2/3 seconds pause
> for keyboard input to appear on a console.

Your app got paged out, and the enormous read latencies in 2.4.16
caused it to remain there.
