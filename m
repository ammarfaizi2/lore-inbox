Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281314AbRKLIDe>; Mon, 12 Nov 2001 03:03:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281313AbRKLIDY>; Mon, 12 Nov 2001 03:03:24 -0500
Received: from pizda.ninka.net ([216.101.162.242]:44431 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S281312AbRKLIDO>;
	Mon, 12 Nov 2001 03:03:14 -0500
Date: Mon, 12 Nov 2001 00:03:05 -0800 (PST)
Message-Id: <20011112.000305.45744181.davem@redhat.com>
To: andrea@suse.de
Cc: mathijs@knoware.nl, jgarzik@mandrakesoft.com, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com, kuznet@ms2.inr.ac.ru
Subject: Re: [PATCH] fix loop with disabled tasklets
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20011112021142.O1381@athlon.random>
In-Reply-To: <20011110152845.8328F231A4@brand.mmohlmann.demon.nl>
	<20011110173751.C1381@athlon.random>
	<20011112021142.O1381@athlon.random>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andrea Arcangeli <andrea@suse.de>
   Date: Mon, 12 Nov 2001 02:11:42 +0100

   I'm just guessing: the scheduler isn't yet functional when
   spawn_ksoftirqd is called.

The scheduler is fully functional, this isn't what is going wrong.

Look at my other email from last night.  At this point in the booting
process, what would we possibly switch to if ksoftirqd is in running
state constantly?  No other kernel thread is of a higher priority if
the only things running are the idle threads and ksoftird.  This is
basically what I think is happening on sparc32.

Right?

Franks a lot,
David S. Miller
davem@redhat.com
