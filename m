Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261985AbVAYPxb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261985AbVAYPxb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 10:53:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261989AbVAYPxb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 10:53:31 -0500
Received: from fw.osdl.org ([65.172.181.6]:49363 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261985AbVAYPxY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 10:53:24 -0500
Date: Tue, 25 Jan 2005 07:52:39 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Bill Davidsen <davidsen@tmr.com>
cc: Valdis.Kletnieks@vt.edu, John Richard Moser <nigelenki@comcast.net>,
       Arjan van de Ven <arjan@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       Christoph Hellwig <hch@infradead.org>, Dave Jones <davej@redhat.com>,
       Andrew Morton <akpm@osdl.org>, marcelo.tosatti@cyclades.com,
       Greg KH <greg@kroah.com>, chrisw@osdl.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: thoughts on kernel security issues 
In-Reply-To: <41F6604B.4090905@tmr.com>
Message-ID: <Pine.LNX.4.58.0501250741210.2342@ppc970.osdl.org>
References: <1106157152.6310.171.camel@laptopd505.fenrus.org>
 <200501191947.j0JJlf3j024206@turing-police.cc.vt.edu> <41F6604B.4090905@tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 25 Jan 2005, Bill Davidsen wrote:
> 
> Unfortunately if A depends on B to work at all, you have to put A and B 
> in as a package.

No. That's totally bogus. You can put in B on its own. You do not have to 
make A+B be one patch.

> There is no really good way (AFAIK) to submit a bunch of patches and
> say "if any one of these is rejected the whole thing should be ignored."

But that's done ALL THE TIME. Claiming that there is no good way is not 
only disingenious (we call them "numbers", and they start at 1, go to 2, 
then 3. Then there's usually a 0-patch which only contains explanations 
of the series), but it's clearly not true, since we have patches like that 
weekly. 

In the last seven days the kernel mailing list has seen at least four
such series where patches depend at least partly on each other:
 - Kay Sievers: driver core: export MAJOR/MINOR to the hotplug (0-7)
 - Andreas Gruenbacher: NFSACL protocol extension for NFSv3 (0-13)
 - Roland Dreier: InfiniBand updates for 0-12
 - Roland McGrath: per-process timers (1-7)

and that was from just a quick look. It seems to be almost a daily 
occurrence.

In short: listen to Arjan, because he is wise. And stop making totally 
idiotic excuses that are clearly not true.

		Linus
