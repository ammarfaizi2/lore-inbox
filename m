Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261247AbRELNp6>; Sat, 12 May 2001 09:45:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261250AbRELNps>; Sat, 12 May 2001 09:45:48 -0400
Received: from www.wen-online.de ([212.223.88.39]:31240 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S261248AbRELNpm>;
	Sat, 12 May 2001 09:45:42 -0400
Date: Sat, 12 May 2001 15:45:17 +0200 (CEST)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Vincent Stemen <linuxkernel@AdvancedResearch.org>,
        Jacky Liu <jq419@my-deja.com>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.4 kernel freeze for unknown reason
In-Reply-To: <E14yXPt-00044K-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0105121504560.365-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 May 2001, Alan Cox wrote:

> > > > If I turn swap off all together or turn it off and back on
> > > > periodically to clear the swap before it gets full, I do not seem to
> > > > experience the lockups.
> >
> > Why do I not see this behavior with a heavy swap throughput test load?
> > It seems decidedly odd to me that swapspace should remain allocated on
> > other folks lightly loaded boxen given that my heavily loaded box does
> > release swapspace quite regularly.  What am I missing?
>
> If you swap really hard it seems much happier. If you vaguely swap stuff out
> over time then I too see the description above only I have Rik's dont deadlock
> on oom tweak so I see apps die.

Does any swap write/release if you hit such a box with heavy duty IO?
(pages on dirty list, swapspace allocated but writeout defered?)

If not, I'd be interested in seeing sysrq-m of a box in such a state..
particularly so if the total pages on active, dirty and clean lists is
only a small fraction of total pages.  (information leak?)

	-Mike

