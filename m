Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317568AbSFIGqG>; Sun, 9 Jun 2002 02:46:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317569AbSFIGqF>; Sun, 9 Jun 2002 02:46:05 -0400
Received: from fachschaft.cup.uni-muenchen.de ([141.84.250.61]:7431 "EHLO
	fachschaft.cup.uni-muenchen.de") by vger.kernel.org with ESMTP
	id <S317568AbSFIGqF>; Sun, 9 Jun 2002 02:46:05 -0400
Message-Id: <200206090640.g596e6X14829@fachschaft.cup.uni-muenchen.de>
Content-Type: text/plain; charset=US-ASCII
From: Oliver Neukum <Oliver.Neukum@lrz.uni-muenchen.de>
To: "David S. Miller" <davem@redhat.com>, roland@topspin.com
Subject: Re: PCI DMA to small buffers on cache-incoherent arch
Date: Sun, 9 Jun 2002 08:45:49 +0200
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <52lm9p9tdz.fsf@topspin.com> <52d6v19r9n.fsf@topspin.com> <20020608.222903.122223122.davem@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, 9. Juni 2002 07:29 schrieb David S. Miller:
>    From: Roland Dreier <roland@topspin.com>
>    Date: 08 Jun 2002 18:26:12 -0700
>
>    Just to make sure I'm reading this correctly, you're saying that as
>    long as a buffer is OK for DMA, it should be OK to use a
>    sub-cache-line chunk as a DMA buffer via pci_map_single(), and
>    accessing the rest of the cache line should be OK at any time before,
>    during and after the DMA.
>
> Yes.

Does this mean that this piece of memory does have to be declared
uncacheable until DMA is finished ?
How else do you solve th problem of validity during DMA and
especially after DMA ?

	Regards
		Oliver
