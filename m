Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280789AbRKLOFs>; Mon, 12 Nov 2001 09:05:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280786AbRKLOFi>; Mon, 12 Nov 2001 09:05:38 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:42828 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S280789AbRKLOF1>; Mon, 12 Nov 2001 09:05:27 -0500
Date: Mon, 12 Nov 2001 15:04:52 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: mathijs@knoware.nl, jgarzik@mandrakesoft.com, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com, kuznet@ms2.inr.ac.ru
Subject: Re: [PATCH] fix loop with disabled tasklets
Message-ID: <20011112150452.S1381@athlon.random>
In-Reply-To: <20011110152845.8328F231A4@brand.mmohlmann.demon.nl> <20011110173751.C1381@athlon.random> <20011112021142.O1381@athlon.random> <20011112.000305.45744181.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20011112.000305.45744181.davem@redhat.com>; from davem@redhat.com on Mon, Nov 12, 2001 at 12:03:05AM -0800
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2001 at 12:03:05AM -0800, David S. Miller wrote:
>    From: Andrea Arcangeli <andrea@suse.de>
>    Date: Mon, 12 Nov 2001 02:11:42 +0100
> 
>    I'm just guessing: the scheduler isn't yet functional when
>    spawn_ksoftirqd is called.
> 
> The scheduler is fully functional, this isn't what is going wrong.

check ret_from_fork path, sparc32 scheduler is broken and this is why it
deadlocks at boot, it has nothing to do with the softirq code, softirq
code is innocent and it only get bitten by the sparc32 bug.

Andrea
