Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316804AbSFJKAl>; Mon, 10 Jun 2002 06:00:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316820AbSFJKAk>; Mon, 10 Jun 2002 06:00:40 -0400
Received: from mailout02.sul.t-online.com ([194.25.134.17]:34977 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S316804AbSFJKAj> convert rfc822-to-8bit; Mon, 10 Jun 2002 06:00:39 -0400
Content-Type: text/plain; charset=US-ASCII
From: Oliver Neukum <oliver@neukum.name>
To: "David S. Miller" <davem@redhat.com>
Subject: Re: PCI DMA to small buffers on cache-incoherent arch
Date: Mon, 10 Jun 2002 12:00:14 +0200
X-Mailer: KMail [version 1.4]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <52d6v19r9n.fsf@topspin.com> <200206090640.g596e6X14829@fachschaft.cup.uni-muenchen.de> <20020609.212422.70462475.davem@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200206101200.14109.oliver@neukum.name>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>    Does this mean that this piece of memory does have to be declared
>    uncacheable until DMA is finished ?
>    How else do you solve th problem of validity during DMA and
>    especially after DMA ?
>
> You flush either before/after depending upon whether the cpu caches
> are writeback in nature or not, and the cpu is not allowed to touch
> those addresses while the device is doing the DMA.

So we need some kind of cache_aligned macro in our USB data
structures if they contain a buffer. Which macro would we have to use ?
Is there a macro conditional to incoherent architectures so we don't
have to waste RAM needlessly ?

	Regards
		Oliver

