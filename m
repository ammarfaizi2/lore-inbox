Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284330AbRL0HmW>; Thu, 27 Dec 2001 02:42:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286221AbRL0HmM>; Thu, 27 Dec 2001 02:42:12 -0500
Received: from www.wen-online.de ([212.223.88.39]:5138 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S284330AbRL0Hl7>;
	Thu, 27 Dec 2001 02:41:59 -0500
Date: Thu, 27 Dec 2001 08:42:31 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: "Stolle, Martin (KIV)" <MStolle@kiv.de>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Informix 7.3 and Linux Kernel 2.4
In-Reply-To: <4353BABFDF95D311BFC30004AC4CB22AAE342A@sdar000001.kiv-da.de>
Message-ID: <Pine.LNX.4.33.0112270825040.638-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Dec 2001, Stolle, Martin (KIV) wrote:

> At first, Informix works quite well, but after a while, especially
> after some traffic on the computer (reading the harddisk by "find",
> do a "update statistics" under informix or some exports, the system
> starts thrashing.
>
> I found out, that it starts thrashing with kswapd using 50% of processor
> power and oninit using another 50%, when low memory runs short.

(sounds like much zone_normal unfreeable creating persistant imbalance)

> >From then, the system is very very slow.
> The problem isn't so dramatic with kernel releases <=2.4.9, but with higher
> releases, including 2.4.17, it is not tolerable.
> 2.4.17 does not swap to disk, but is still very slow, but kswapd is always
> active (without swapping to disk!).

What does /proc/slabinfo look like with 2.4.17?  (zillion buffer heads?)

	-Mike

