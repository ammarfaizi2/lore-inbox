Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282988AbRK0WD6>; Tue, 27 Nov 2001 17:03:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282981AbRK0WDt>; Tue, 27 Nov 2001 17:03:49 -0500
Received: from samba.sourceforge.net ([198.186.203.85]:13069 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S282980AbRK0WDd>;
	Tue, 27 Nov 2001 17:03:33 -0500
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15364.3457.368582.994067@gargle.gargle.HOWL>
Date: Wed, 28 Nov 2001 09:02:41 +1100 (EST)
To: torvalds@transmeta.com (Linus Torvalds)
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.1-pre2 does not compile
In-Reply-To: <9u0ua1$1g2$1@penguin.transmeta.com>
In-Reply-To: <200111272044.fARKiTv13653@db0bm.ampr.org>
	<9u0ua1$1g2$1@penguin.transmeta.com>
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds writes:

> The next-generation block-layer support is starting to be merged into
> the 2.5.x tree, and that breaks old drivers that haven't been updated to
> the new locking.
> 
> In particular, there used to be _one_ lock for the whole IO system
> ("io_request_lock"), and these days it's a per-block-queue lock.
> 
> In many cases the fix is as simple as just replacing the
> "io_request_lock" with "host->host_lock", but sometimes this is
> complicated by the need to pass the right data structures down far
> enough..

Is there a description of the new block layer and its interface to
block device drivers somewhere?  That would be helpful, since Ben
Herrenschmidt and I are going to have to convert several
powermac-specific drivers.

Thanks,
Paul.
