Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136411AbRD2Xrx>; Sun, 29 Apr 2001 19:47:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132993AbRD2Xrn>; Sun, 29 Apr 2001 19:47:43 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:13652 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S136409AbRD2Xr2>; Sun, 29 Apr 2001 19:47:28 -0400
Date: Mon, 30 Apr 2001 01:46:53 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "Magnus Naeslund(f)" <mag@fbab.net>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Alpha compile problem solved by Andrea (pte_alloc)
Message-ID: <20010430014653.C923@athlon.random>
In-Reply-To: <052901c0ceca$e6a543c0$020a0a0a@totalmef> <20010427155246.O16020@athlon.random> <m1k843qoc1.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1k843qoc1.fsf@frodo.biederman.org>; from ebiederm@xmission.com on Sun, Apr 29, 2001 at 05:27:10PM -0600
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 29, 2001 at 05:27:10PM -0600, Eric W. Biederman wrote:
> 
> Do you know if anyone has fixed the lazy vmalloc code?  I know of
> as of early 2.4 it was broken on alpha.  At the time I noticed it I didn't
> have time to persue it, but before I forget to even put in a bug
> report I thought I'd ask if you know anything about it?

On alpha it's racy if you set CONFIG_ALPHA_LARGE_VMALLOC y (so don't do
that as you don't need it). As long as you use only 1 entry of the pgd
for the whole vmalloc space (CONFIG_ALPHA_LARGE_VMALLOC n) alpha is
safe.

OTOH x86 is racy and there's no workaround available at the moment.

Andrea
