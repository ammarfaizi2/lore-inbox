Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132142AbRCVSYh>; Thu, 22 Mar 2001 13:24:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132124AbRCVSYU>; Thu, 22 Mar 2001 13:24:20 -0500
Received: from www.wen-online.de ([212.223.88.39]:5136 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S132139AbRCVSWx>;
	Thu, 22 Mar 2001 13:22:53 -0500
Date: Thu, 22 Mar 2001 19:22:08 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: "Stephen C. Tweedie" <sct@redhat.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <arjanv@redhat.com>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: Thinko in kswapd?
In-Reply-To: <E14g9X7-00030H-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0103221911230.999-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Mar 2001, Alan Cox wrote:

> > pull it all right back in again.  It continues through the entire
> > build with the cost seen in the time numbers.  (the ac20.virgin run
> > was worse by 30 secs than average, but that doesn't matter much)
>
> Using my reference interactive test (An application which renders 3D graphics
> and generates fairly measurable VM traffic with AGP texture mapping)[1] the
> graphical flow is noticably stalling where it didn't before.
>
> Throughput seems to be up but interactivity is bad.

If you set the amount that kswapd goes after to be a fraction of
inactive_target and leave Stephens change in but ensure that a
schedule happens between loops, IIRC interactive is pretty nice
while swapping.  (haven't tried that particular variant in a while)

	-Mike

