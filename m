Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287200AbSAGVvW>; Mon, 7 Jan 2002 16:51:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287203AbSAGVvN>; Mon, 7 Jan 2002 16:51:13 -0500
Received: from mail.vr-web.de ([195.243.197.42]:45831 "HELO mail.VR-Web.de")
	by vger.kernel.org with SMTP id <S287200AbSAGVvB>;
	Mon, 7 Jan 2002 16:51:01 -0500
Date: Mon, 7 Jan 2002 22:43:46 +0100 (CET)
From: Matthias Hanisch <mjh@vr-web.de>
To: Davide Libenzi <davidel@xmailserver.org>
cc: Matthias Hanisch <mjh@vr-web.de>, Mikael Pettersson <mikpe@csd.uu.se>,
        Jens Axboe <axboe@suse.de>, Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.2-pre performance degradation on an old 486
In-Reply-To: <Pine.LNX.4.40.0201071030210.1612-100000@blue1.dev.mcafeelabs.com>
Message-ID: <Pine.LNX.4.10.10201072236430.238-100000@pingu.franken.de>
Organization: Matze at his stone-old Linux Box
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Jan 2002, Davide Libenzi wrote:

> In sched.c::init_idle() :
> 
> current->dyn_prio = -100;
> 
> Let me know.

Aehm. I already added the same line at the beginning of cpu_idle() in
arch/i386/process.c, which brought back the old performance. Your patch
should be analogous, but cleaner.

So: Bingo!!!!

I just wonder, why only two people with slow machines saw this behavior...

Now 2.5.2 can come :)

Regards,
	Matze


