Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265809AbTFSPhc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 11:37:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265810AbTFSPhc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 11:37:32 -0400
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:43727 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id S265809AbTFSPhb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 11:37:31 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH] sleep_decay for interactivity 2.5.72 - testers  needed
Date: Fri, 20 Jun 2003 01:51:30 +1000
User-Agent: KMail/1.5.2
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andreas Boman <aboman@midgaard.us>
References: <5.2.0.9.2.20030619171843.02299e00@pop.gmx.net>
In-Reply-To: <5.2.0.9.2.20030619171843.02299e00@pop.gmx.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306200151.30187.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Jun 2003 01:47, Mike Galbraith wrote:
> At 12:05 AM 6/20/2003 +1000, Con Kolivas wrote:
> >Testers required. A version for -ck will be created soon.
>
> That idea definitely needs some refinement.
>
> Run test-starve.c, and try to login.  I'm not sure, but I don't think I've
> seen any task change more than one priority from what it started life
> at.  In test-starve's case, that's 16.  It's partner is at 16 as well, so
> it can't preempt (bad).  A dd if=/dev/zero of=/dev/null stays glued to
> 21.  Repeated sh -c 'ps l $$'  bounces back and forth between 15 and
> 21.  (maybe I should fly to Vegas.. when I try to login with test-starve
> running, I keep hitting 21:)

Heh, sounds like you'll get to go there lose all your money come back and 
still be waiting :P

Too fast a woody that stays up too long?
Perhaps 2 seconds up and 10 down would be better than 1 up 60 down. I was just 
trying to make a point with those numbers; they were hardly tuned. Also 
perhaps the child penalty of 50 is now too low and IIRC the 95 used a long 
time ago may give the shell a better chance of firing up.

Con

