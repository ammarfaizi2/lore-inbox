Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263811AbRFDUN2>; Mon, 4 Jun 2001 16:13:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263805AbRFDUNK>; Mon, 4 Jun 2001 16:13:10 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:61451 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S263804AbRFDUNB>; Mon, 4 Jun 2001 16:13:01 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Linus Torvalds <torvalds@transmeta.com>,
        Richard Gooch <rgooch@ras.ucalgary.ca>
Subject: Re: [PATCH] fs/devfs/base.c
Date: Mon, 4 Jun 2001 22:15:05 +0200
X-Mailer: KMail [version 1.2]
Cc: Akash Jain <aki.jain@stanford.edu>, alan@lxorguk.ukuu.org.uk,
        linux-kernel@vger.kernel.org, su.class.cs99q@nntp.stanford.edu
In-Reply-To: <Pine.LNX.4.21.0106031652090.32451-100000@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.21.0106031652090.32451-100000@penguin.transmeta.com>
MIME-Version: 1.0
Message-Id: <01060422150505.08443@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 04 June 2001 01:55, Linus Torvalds wrote:
>  - the kernel stack is 4kB, and _nobody_ has the right to eat up a
>    noticeable portion of it. It doesn't matter if you "know" your
> caller or not: you do not know what interrupts happen during this
> time, and how much stack they want.

We'd better know the upper bound of interrupt allocations or we have an 
accident waiting to happen.  How much of the kernel stack is reserved 
for interrupts?

--
Daniel
