Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129780AbQLZSpU>; Tue, 26 Dec 2000 13:45:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129803AbQLZSpJ>; Tue, 26 Dec 2000 13:45:09 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:12306 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129780AbQLZSo6>; Tue, 26 Dec 2000 13:44:58 -0500
Date: Tue, 26 Dec 2000 10:14:03 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Tim Wright <timw@splhi.com>, Kai Henningsen <kaih@khms.westfalen.de>,
        linux-kernel@vger.kernel.org
Subject: Re: About Celeron processor memory barrier problem
In-Reply-To: <E14Ag3l-0000MY-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.10.10012261012330.8122-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 25 Dec 2000, Alan Cox wrote:

> > One thing we _could_ potentially do is to simplify the CPU selection a
> > bit, and make it a two-stage process. Basically have a
> > 
> > 	bool "Optimize for current CPU" CONFIG_CPU_CURRENT
> > 
> > which most people who just want to get the best kernel would use. Less
> > confusion that way.
> 
> If we do that I'd rather see a make autoconfig that does the lot from
> proc/pci etc 8)

Good point. No point in adding a new config option, we should just have a
new configurator instead. Of course, it can't handle many of the
questions, so it would still have to fall back on asking.

That _would_ be a nice addition eventually. It's a bigger project than the
one I envisioned, though.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
