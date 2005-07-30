Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263058AbVG3MUR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263058AbVG3MUR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 08:20:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263060AbVG3MUR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 08:20:17 -0400
Received: from mailfe08.swip.net ([212.247.154.225]:54744 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S263058AbVG3MUP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 08:20:15 -0400
X-T2-Posting-ID: jLUmkBjoqvly7NM6d2gdCg==
Date: Sat, 30 Jul 2005 14:20:07 +0200
From: Alexander Nyberg <alexn@telia.com>
To: Chuck Ebbert <76306.1226@compuserve.com>,
       Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Making it easier to find which change introduced a bug
Message-ID: <20050730122007.GA8364@localhost.localdomain>
References: <200507300442_MC3-1-A5F6-A039@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200507300442_MC3-1-A5F6-A039@compuserve.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> > We need a super-easy way for people to do bisection searching.
> 
>  First step would be to make interdiffs available as quilt patchsets.
> 
>  If we had this for e.g. 2.6.13-rc3 -> rc4 it would make tracking down
> those new bugs much easier.
> 
> (Yes I know git does bisection but Andrew said it should be easy.)
> __

Yeah I agree, it would be extremely useful and simplify for people
who don't have git installed.

Linus, do you think we could have something like
patch-2.6.13-rc4-incremental-broken-out.tar.bz2 that could like Andrew's
be placed into patches/ in a tree?

So for example, have a tree with 2.6.13-rc3, download
patch-2.6.13-rc4-incremental-broken-out.tar.bz2, place it in patches/ and 
be able to do quilt push / quilt pop easily.

As it stands today it's easier for us who don't know git to just find
out in which mainline kernel it works and which -mm it doesn't work in,
get the broken-out and start push/pop. And I know I'm not the only one
who has noticed this.

Thanks
Alexander
