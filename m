Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964903AbVJZT42@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964903AbVJZT42 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 15:56:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964904AbVJZT41
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 15:56:27 -0400
Received: from ms005msg.fastwebnet.it ([213.140.2.50]:55982 "EHLO
	ms005msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S964903AbVJZT41 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 15:56:27 -0400
Date: Wed, 26 Oct 2005 21:56:32 +0200
From: Paolo Ornati <ornati@fastwebnet.it>
To: Dave Airlie <airlied@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [2.6.14-rc? on x86-64] Total machine freeze
Message-ID: <20051026215632.447c96e4@localhost>
In-Reply-To: <21d7e9970510260320w5d9e9e6fvcfdf16f29366a03f@mail.gmail.com>
References: <20051022124306.36d13c39@localhost>
	<21d7e9970510260320w5d9e9e6fvcfdf16f29366a03f@mail.gmail.com>
X-Mailer: Sylpheed-Claws 1.9.13 (GTK+ 2.6.8; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Oct 2005 20:20:44 +1000
Dave Airlie <airlied@gmail.com> wrote:

> > 2.6.14-rc[45] works fine here, usually. But sometimes (~2 times in a
> > week) I get an hard-freeze:
> >         Sys-RQ doesn't work
> >         machine doesn't reply to ping / ssh
> >         nothing in the logs
> >
> > Seems like it loops somewhere with interrupt disabled... but I don't
> > know.
> >
> Does it get into X and crash?, did it do it with 2.6.13?

I got every crash under X so far (but I run X all the time so I can't
tell if it is related to X or not).

The crash doesn't happen when X starts, it happens at RANDOM times,
without any particular workload. Now it's some days that I don't see
the crash (from when I updated to 2.6.14-rc5-gd475f3f4)... so five days
without crash. I'm waiting to see if it happens again.

The last kernel that crashed was 2.6.14-rc5-g93918e9a.

I don't remember to have seen this crash with 2.6.13... so I suppose
2.6.13 is OK.

> 
> Do you have any "ricer" X options turned on like AGPFastWrite..

No.

	$ grep "AGP Fast" /var/log/Xorg.0.log
	(II) RADEON(0): AGP Fast Write disabled by default

I have other issues with AGP Fast Write: if it is DISABLED in BIOS I
can enable it in Xorg config without problems. If it's enabled in BIOS
and I enable it in Xorg config I get this:
	when X starts the screen goes in SUSPEND mode and X eats all
	the CPU (I've seen this whith ssh). X is unkillable and I
	cannot debug it with gdb... only a reboot kills it! But this is
	another issue.

The current AGP Fast Write config is:
	- enabled in BIOS	(don't ask me why...)
	- disabled in xorg.conf

-- 
	Paolo Ornati
	Linux 2.6.14-rc5-gd475f3f4 on x86_64
