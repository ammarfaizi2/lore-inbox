Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317338AbSFLJnZ>; Wed, 12 Jun 2002 05:43:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317678AbSFLJnY>; Wed, 12 Jun 2002 05:43:24 -0400
Received: from s2.relay.oleane.net ([195.25.12.49]:59401 "HELO
	s2.relay.oleane.net") by vger.kernel.org with SMTP
	id <S317338AbSFLJnX>; Wed, 12 Jun 2002 05:43:23 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "David S. Miller" <davem@redhat.com>, <david-b@pacbell.net>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: PCI DMA to small buffers on cache-incoherent arch
Date: Tue, 11 Jun 2002 19:33:47 +0200
Message-Id: <20020611173347.21348@smtp.adsl.oleane.com>
In-Reply-To: <20020611.202553.28822742.davem@redhat.com>
X-Mailer: CTM PowerMail 3.1.2 F <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Remember please that specifically the DMA mapping APIs encourage use
>of consistent memory for small data objects.  It is specifically
>because non-consistent DMA accesses to small bits are going to be very
>slow (ie. the PCI controller is going to prefetch further cache lines
>for no reason, for example).  The non-consistent end of the APIs is
>meant for long contiguous buffers, not small chunks.
>
>This is one of the reasons I want to fix this by making people use
>either consistent memory or PCI pools (which is consistent memory
>too).

Please don't limit the API design to PCI ;)

There are more and more embedded CPUs out there with their own
bunch of on-chip devices that are neither consistent nor PCI based,
their drivers will have the exact same problem to deal with though.

Ben.

