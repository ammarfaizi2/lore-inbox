Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129828AbRCGBL4>; Tue, 6 Mar 2001 20:11:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129830AbRCGBLq>; Tue, 6 Mar 2001 20:11:46 -0500
Received: from [62.122.1.32] ([62.122.1.32]:27397 "HELO milkplus")
	by vger.kernel.org with SMTP id <S129828AbRCGBL0>;
	Tue, 6 Mar 2001 20:11:26 -0500
Subject: Re: Interesting fs corruption story
From: Ettore Perazzoli <ettore@ximian.com>
To: timw@splhi.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010306170102.B1095@kochanski.internal.splhi.com>
In-Reply-To: <Pine.LNX.4.21.0103042043320.27829-100000@trna.ximian.com> 
	<20010306170102.B1095@kochanski.internal.splhi.com>
Content-Type: text/plain
X-Mailer: Evolution/0.8 (Preview Release)
Date: 06 Mar 2001 20:10:10 -0500
Message-Id: <983927410.11517.0.camel@milkplus.unknown.domain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 06 Mar 2001 17:01:02 -0800, Tim Wright wrote:
> Hi Ettore,
> I have no idea if this is related to your problem since you didn't mention
> that key part, but with the same drive, I managed to trash my root partition
> incredibly badly by trying to use DMA and then do APM suspend or hibernate.
> On wakeup, I'd get an 'hda: lost interrupt' but then things would appear to
> carry on.
> 
> The fix for me was to rebuild the kernel and make sure CONFIG_APM_ALLOW_INTS
> was enabled. So, do you ever use power management and is this similar, or do
> you have a completely different problem ?

  Wow, this sounds like this might be the problem.  I just checked my
`.config' and indeed `CONFIG_APM_ALLOW_INTS' is not enabled.  And indeed
I have been suspending/resuming the machine a few times before the
partition got corrupted.

  So, does DMA work correctly on your system after setting this option?
I have now disabled it completely as a safety measure (and as suggested
by somebody else on this list), and indeed I have not had any more
troubles for now.  (I have been forcing a fsck every day before turning
the machine off.)

  Thanks a lot for the hint!  I will now rebuild my kernel with that
option turned on.

-- 
Ettore
