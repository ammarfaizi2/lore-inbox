Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316953AbSEWQpq>; Thu, 23 May 2002 12:45:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316957AbSEWQpp>; Thu, 23 May 2002 12:45:45 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:17869 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S316953AbSEWQpo>; Thu, 23 May 2002 12:45:44 -0400
Date: Thu, 23 May 2002 09:46:08 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>, linux-kernel@vger.kernel.org
Subject: Re: [BUG] 2.4 VM sucks. Again
Message-ID: <399720000.1022172368@flay>
In-Reply-To: <200205231629.g4NGTWE22956@mail.pronto.tv>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > Starting up 30 downloads from a custom HTTP server (or Tux - or Apache -
>> > doesn't matter), file size is 3-6GB, download speed = ~4.5Mbps. After
>> > some time the kernel (a) goes bOOM (out of memory) if not having any
>> > swap, or (b) goes gong swapping out anything it can.
>> 
>> How much RAM do you have, and what does /proc/meminfo
>> and /proc/slabinfo say just before the explosion point?
> 
> I have 1 gig - highmem (not enabled) - 900 megs.
> for what I can see, kernel can't reclaim buffers fast enough.
> ut looks better on -aa.

Sounds like exactly the same problem we were having. There are two
approaches to solving this - Andrea has a patch that tries to free them
under memory pressure, akpm has a patch that hacks them down as soon
as you've fininshed with them (posted to lse-tech mailing list). Both approaches
seemed to work for me, but the performance of the fixes still has to be established.

I've seen over 1Gb of buffer_heads ;-)

M.

