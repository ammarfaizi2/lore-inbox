Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263270AbSJ1K7b>; Mon, 28 Oct 2002 05:59:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263276AbSJ1K7b>; Mon, 28 Oct 2002 05:59:31 -0500
Received: from ns.suse.de ([213.95.15.193]:40456 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S263270AbSJ1K7a>;
	Mon, 28 Oct 2002 05:59:30 -0500
To: Paul Eggert <eggert@twinsun.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: nanosecond file timestamp resolution in filesystems, GNU make, etc.
References: <20021027153651.GB26297@pimlott.net.suse.lists.linux.kernel> <200210280947.g9S9l9H01162@sic.twinsun.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 28 Oct 2002 12:05:49 +0100
In-Reply-To: Paul Eggert's message of "28 Oct 2002 10:55:39 +0100"
Message-ID: <p73u1j6su0i.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Eggert <eggert@twinsun.com> writes:
> 
> > Another way would be to round on flush, but that also has some problems :-
> 
> Rounding is even worse.  GNU Make assumes truncation, i.e. it assumes
> that a timestamp is truncated (floored, actually) when it is stored on
> a non-nanosecond-aware filesystem.

That is what my patchkit does currently, so I guess it should work fine.

> 
> > In my current patchkit I just chose to truncate because that was the 
> > easiest and the other more complicated solutions didn't offer any 
> > compeling advantage.
> 
> Can't you truncate/floor to filesystem timestamp resolution
> immediately, i.e., before the inode is flushed?  That would address
> the problems that I see.

That would complicate the timestamp management in the kernel considerably.
I'm not sure if I want to do that, probably not.

-Andi

