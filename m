Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316869AbSGURqV>; Sun, 21 Jul 2002 13:46:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316886AbSGURqV>; Sun, 21 Jul 2002 13:46:21 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:25078 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S316869AbSGURqU>; Sun, 21 Jul 2002 13:46:20 -0400
Subject: Re: [PATCH] VM strict overcommit, again
From: Robert Love <rml@tech9.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>, akpm@zip.com.au,
       riel@conectiva.com.br, linux-kernel@vger.kernel.org
In-Reply-To: <1027259191.16818.94.camel@irongate.swansea.linux.org.uk>
References: <1027216974.1116.996.camel@sinai> 
	<1027259191.16818.94.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 21 Jul 2002 10:49:11 -0700
Message-Id: <1027273751.1085.1004.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-07-21 at 06:46, Alan Cox wrote:

> On Sun, 2002-07-21 at 03:02, Robert Love wrote:
>
> > Attached patch implements VM strict overcommit with the following
> > changes over the previous patch:
> 
> Looks good to me

Great.

> > 	- (unrelated to the controversy) back out some of the shmem
> > 	  changes.  I am weary of them and they would be best brought
> > 	  forward from 2.4-ac in pieces. 2.4-ac, btw, has quite
> > 	  a few shmem fixes.
> 
> This is probably wise. Its partly complicated by the fact that the shmem
> changes are in part very recent (Hugh fixed a load) and also by the fact
> -ac has a vm callback for when a page cache page is freed up which is
> used by the shmem code I have

Maybe you can help me merge some of these over.  You are right, the
differences are great.  I tried to only bring over overcommit-related
fixes but it was tough.  Compounded by the new stuff Hugh sent us, it
was hard to tell what was what.

The only thing that is in the patch now re shmem is the basic accounting
and checks.  I removed all of Hugh's updates...

	Robert Love

