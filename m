Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317566AbSFIG52>; Sun, 9 Jun 2002 02:57:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317571AbSFIG51>; Sun, 9 Jun 2002 02:57:27 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:61446 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S317566AbSFIG51>;
	Sun, 9 Jun 2002 02:57:27 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200206090657.g596vQj403167@saturn.cs.uml.edu>
Subject: Re: PCI DMA to small buffers on cache-incoherent arch
To: Oliver.Neukum@lrz.uni-muenchen.de (Oliver Neukum)
Date: Sun, 9 Jun 2002 02:57:26 -0400 (EDT)
Cc: davem@redhat.com (David S. Miller), linux-kernel@vger.kernel.org
In-Reply-To: <200206090644.g596iMX14841@fachschaft.cup.uni-muenchen.de> from "Oliver Neukum" at Jun 09, 2002 08:50:04 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Neukum writes:

>> For memory --> device DMA:
>>
>> 1. write back all cache lines affected by the DMA
>> 2. start the DMA
>> 3. invalidate the above cache lines
>
> Why the third step ? That data should still
> be valid.

I made a mistake, but perhaps it is a good one.
There is no need to invalidate the cache lines,
but I'd guess that commonly the data won't be
used again. Doing the invalidate would free up
some cache lines, meaning that the CPU would
have empty slots to use for other stuff.
