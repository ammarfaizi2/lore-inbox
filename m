Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263027AbSJBKHe>; Wed, 2 Oct 2002 06:07:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263028AbSJBKHe>; Wed, 2 Oct 2002 06:07:34 -0400
Received: from faui02.informatik.uni-erlangen.de ([131.188.30.102]:33464 "EHLO
	faui02.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id <S263027AbSJBKHd>; Wed, 2 Oct 2002 06:07:33 -0400
Date: Wed, 2 Oct 2002 11:45:25 +0200
From: Richard Zidlicky <rz@linux-m68k.org>
To: Daniel Phillips <phillips@arcor.de>
Cc: Jens Axboe <axboe@suse.de>, Rik van Riel <riel@conectiva.com.br>,
       zippel@linux-m68k.org, linux-m68k@lists.linux-m68k.org,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4 mm trouble [possible lru race]
Message-ID: <20021002114524.A237@linux-m68k.org>
References: <Pine.LNX.4.44L.0210011356300.653-100000@duckman.distro.conectiva> <E17wQXN-0005vL-00@starship> <20021001173119.GY3867@suse.de> <E17wRKZ-0005vf-00@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E17wRKZ-0005vf-00@starship>; from phillips@arcor.de on Tue, Oct 01, 2002 at 08:01:10PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2002 at 08:01:10PM +0200, Daniel Phillips wrote:

> Richard, before I go making a test patch for you (it's not completely
> straightforward) can you confirm that your bug comes back when you back
> the lru race patch out?

bad luck, the disappearance of the bug was rather accidental - I have
switched to a different swap partition in the meantime. So backing out
the changes doesn't make the bug reappear, restoring previous IDE
configuration does.

Very likely interrupt related trouble, somewhere a missing spinlock_irqsave 
perhaps. The bug manifests itself so that pages from wrong procesess get 
swapped in for some process, however I have also had the luck to crash the 
kernel (no Oops) so it is not likely to be one of the TLB/cache problems.

What strikes me is that is always related to swap and I 've never got any
strange dmesg so far.

Richard
