Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269406AbRHCP37>; Fri, 3 Aug 2001 11:29:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269408AbRHCP3u>; Fri, 3 Aug 2001 11:29:50 -0400
Received: from mg02.austin.ibm.com ([192.35.232.12]:17104 "EHLO
	mg02.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S269406AbRHCP3g>; Fri, 3 Aug 2001 11:29:36 -0400
Content-Type: text/plain; charset=US-ASCII
From: Andrew Theurer <andrewt@austin.rr.com>
Reply-To: andrewt@austin.rr.com
To: linux-kernel@vger.kernel.org
Subject: Re: TCP zero-copy
Date: Fri, 3 Aug 2001 10:28:53 -0500
X-Mailer: KMail [version 1.2]
In-Reply-To: <663CE32D.1D4A9213.0F45C3B8@netscape.net> <3B6A7B96.1591.241743@localhost>
In-Reply-To: <3B6A7B96.1591.241743@localhost>
MIME-Version: 1.0
Message-Id: <01080310285302.02989@linux>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 03 August 2001 04:23,  wrote:
> I believe this behaviour is only possible for cards which have the
> ability to dma what appears as a list of skb data fragments and
> also has the ability to checksum the data. Namely the Alteon, now
> 3com, ACENIC and the sun hme device.

Intel now has an e1000 driver as well.

> Does this kernel modification completely remove the need for a
> copy/checksum of the data between user and kernel space on both
> transmit and receive ?

Transmit for sure.  You should no longer see csum_partial_copy_generic() when 
using zerocopy.

> I have written a driver for an Intel ixf1002 chip, which has some
> surrounding HW, and is capable of checksumming and processing
> dma in fragments. Is there any information on what changes I
> would have to make to the driver to support zerocopy/checksum ?

Which card is this?

Andrew Theurer
