Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263857AbTLOSwY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 13:52:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263871AbTLOSwY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 13:52:24 -0500
Received: from fw.osdl.org ([65.172.181.6]:8896 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263857AbTLOSwW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 13:52:22 -0500
Date: Mon, 15 Dec 2003 10:52:19 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Toad <toad@amphibian.dyndns.org>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jens Axboe <axboe@suse.de>
Subject: Re: 'bad: scheduling while atomic!', preempt kernel, 2.6.1-test11,
 reading an apparently duff DVD-R
In-Reply-To: <20031215154654.GA7760@amphibian.dyndns.org>
Message-ID: <Pine.LNX.4.58.0312151046430.1631@home.osdl.org>
References: <20031215135802.GA4332@amphibian.dyndns.org>
 <20031215154654.GA7760@amphibian.dyndns.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 15 Dec 2003, Toad wrote:
>
> I recompiled the kernel with IDE-SCSI, preemption, taskfile, and a few
> other things disabled. With the result that it worked. But of course I
> can't _write_ DVDs without IDE-SCSI (short of obtaining a SCSI
> writer)...

Well, that "of course" shouldn't be there - it should work, using the
standard cdrecord.

You don't even need to recompile a cdrecord if you have a reasonably
recent distibution. Just use

	cdrecord dev=/dev/hdc

and it should "just work".

There's been at least one report that trying to write a DVD with packet
writing (ie by just mounting it read-write and writing to it) doesn't
work. That one seems to be due to the generic cdrom.c code getting the
size of the disk wrong. There was a patch floating around for testing, but
I never got any feedback on that apart from the original success story.

But if you have a DVD-R, then that shouldn't even be an issue, methinks.

			Linus
