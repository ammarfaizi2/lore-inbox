Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310527AbSBRMzp>; Mon, 18 Feb 2002 07:55:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310526AbSBRMze>; Mon, 18 Feb 2002 07:55:34 -0500
Received: from dsl-213-023-043-245.arcor-ip.net ([213.23.43.245]:11662 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S310525AbSBRMzY>;
	Mon, 18 Feb 2002 07:55:24 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Andrea Arcangeli <andrea@suse.de>,
        William Lee Irwin III <wli@holomorphy.com>,
        linux-kernel@vger.kernel.org, rsf@us.ibm.com
Subject: Re: [TEST] page tables filling non-highmem
Date: Mon, 18 Feb 2002 13:59:42 +0100
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <20020215045106.GB26322@holomorphy.com> <20020218032644.GD3511@holomorphy.com> <20020218132757.K7940@athlon.random>
In-Reply-To: <20020218132757.K7940@athlon.random>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16cnOQ-0000LC-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On February 18, 2002 01:27 pm, Andrea Arcangeli wrote:
> Agreed, this is why I fighted with Linus and Marcelo trying to convince
> them not to reintroduce the loop crap into the allocator that leads to
> all sort of oom deadlocks because we lack the knowledge on the amount of
> freeable pages (I even re-read the emails about such stuff in the thread
> "VM tweaks" to be sure I was remembering right). OTOH, I really cannot
> complain, they included so much stuff from my tree that even if we
> disagreed on something at the end I don't mind :).  And this is probably
> also why I don't like very much to restart those threads about oom
> deadlocks, I know my way is the only right way (i.e. non deadlock prone)
> possible, and I live with it just fine.
>
> The only way we can learn if a page or a mapping is freeable or not, is
> by trying to free it and by checking if we failed or not. We cannot know
> in another manner, only checking the size of the caches or the amount of
> the swap still unused is totally meaningless and broken. That's
> unfortunate but that's how all linux kernels I know of works, and what I
> did in my tree at the moment is the only possible way to avoid deadlocks
> without having to do a major rework on the accounting side.

Could you describe your page table deadlock-avoidance algorithm in more
detail please?

-- 
Daniel
