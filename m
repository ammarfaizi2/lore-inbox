Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270578AbRHNLtm>; Tue, 14 Aug 2001 07:49:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270573AbRHNLtb>; Tue, 14 Aug 2001 07:49:31 -0400
Received: from alfik.ms.mff.cuni.cz ([195.113.19.71]:23571 "EHLO
	alfik.ms.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S270575AbRHNLtV>; Tue, 14 Aug 2001 07:49:21 -0400
Date: Sat, 11 Aug 2001 01:04:11 +0000
From: Pavel Machek <pavel@suse.cz>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Jamie Lokier <lk@tantalophile.demon.co.uk>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: /proc/<n>/maps getting _VERY_ long
Message-ID: <20010811010411.A55@toy.ucw.cz>
In-Reply-To: <20010806194120.A5803@thefinal.cern.ch> <Pine.LNX.4.33.0108101445350.7596-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.33.0108101445350.7596-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Fri, Aug 10, 2001 at 02:55:11PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > There are garbage collectors that use mprotect() and SEGV trapping per
> > page.  It would be nice if there was a way to change the protections per
> > page without requiring a VMA for each one.
> 
> This is actually how Linux used to work a long long time ago - all
> protection information was in the page tables, and you could do per-page
> things without having to worry about piddling details like vma's.
> 
> It does work, but it had major downsides. Trivial things like re-creating
> the permission after throwing a page out or swapping it out.

For some uses, spurious SEGV after swap-in might be okay ;-). Garbage
collector might be that example.				Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

