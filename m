Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274079AbRISOkJ>; Wed, 19 Sep 2001 10:40:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274077AbRISOkA>; Wed, 19 Sep 2001 10:40:00 -0400
Received: from lilly.ping.de ([62.72.90.2]:46095 "HELO lilly.ping.de")
	by vger.kernel.org with SMTP id <S274076AbRISOjw>;
	Wed, 19 Sep 2001 10:39:52 -0400
Date: 19 Sep 2001 16:38:14 +0200
Message-ID: <20010919163814.A3610@planetzork.spacenet>
From: jogi@planetzork.ping.de
To: "Andrea Arcangeli" <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.10-pre11: alsaplayer skiping during kernel build (-pre10 did not)
In-Reply-To: <20010918171416.A6540@planetzork.spacenet> <20010918172500.F19092@athlon.random> <20010918173515.B6698@planetzork.spacenet> <20010918174434.I19092@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <20010918174434.I19092@athlon.random>; from andrea@suse.de on Tue, Sep 18, 2001 at 05:44:34PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2001 at 05:44:34PM +0200, Andrea Arcangeli wrote:
> certainly not from the console locking changes. Can you just go back to
> pre10 and verify you don't get those skips to just to be 100% sure the
> userspace config is the same?

Hello Andrea,

forget about the scheduler changes. I did the following change and the
problem is almost solved. Before I had both kernel and wav files on

/dev/hda6              4200828   1745204   2455624  42% /usr
/dev/hda6 on /usr type reiserfs (rw)

I copied kernel source and wav files to

/dev/hda8              8989695   2907606   5615804  34% /mnt
/dev/hda8 on /mnt type ext2 (rw)

and it skipped only three (very short) times. So it seems to be a problem
of reiserfs in combination with your memory management changes. Dang!
Can someone of the reiserfs people comment on this?

Regards,

   Jogi

-- 

Well, yeah ... I suppose there's no point in getting greedy, is there?

    << Calvin & Hobbes >>
