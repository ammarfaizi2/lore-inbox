Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280752AbRKBSBR>; Fri, 2 Nov 2001 13:01:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280755AbRKBSBH>; Fri, 2 Nov 2001 13:01:07 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:40255 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S280752AbRKBSAu>; Fri, 2 Nov 2001 13:00:50 -0500
Date: Fri, 2 Nov 2001 19:00:46 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Sven Heinicke <sven@research.nj.nec.com>
Cc: linux-kernel@vger.kernel.org, Daniel Phillips <phillips@bonn-fries.net>,
        Ben Smith <ben@google.com>, Rik van Riel <riel@conectiva.com.br>
Subject: Re: Google's mm problem - not reproduced on 2.4.13
Message-ID: <20011102190046.B6003@athlon.random>
In-Reply-To: <E15yzlQ-00021P-00@starship.berlin> <E15z28m-0000vb-00@starship.berlin> <20011031214540.D1291@athlon.random> <E15z2WJ-0000wc-00@starship.berlin> <3BE07730.60905@google.com> <15330.56589.291830.542215@abasin.nj.nec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <15330.56589.291830.542215@abasin.nj.nec.com>; from sven@research.nj.nec.com on Fri, Nov 02, 2001 at 12:51:09PM -0500
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 02, 2001 at 12:51:09PM -0500, Sven Heinicke wrote:
> a bunch of times.  Then doesn't free the mmaped memory until file
> system is unmounted.  It never starts going into swap.

thanks for testing. This matches the idea that those pages doesn't want
to be unmapped for whatever reason (and because there's an mlock in our
way at the moment I'd tend to point my finger in that direction rather
than into the vm direction). I'll look more closely into this testcase
shortly.

Andrea
