Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317172AbSEXPxV>; Fri, 24 May 2002 11:53:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317175AbSEXPxU>; Fri, 24 May 2002 11:53:20 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:13509 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S317172AbSEXPxS>; Fri, 24 May 2002 11:53:18 -0400
Date: Fri, 24 May 2002 08:53:38 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Roy Sigurd Karlsbakk <roy@karlsbakk.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] 2.4 VM sucks. Again
Message-ID: <421830000.1022255618@flay>
In-Reply-To: <E17BGj9-0006VQ-00@the-village.bc.nu>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > How much RAM do you have, and what does /proc/meminfo
>> > and /proc/slabinfo say just before the explosion point?
>> 
>> I have 1 gig - highmem (not enabled) - 900 megs.
>> for what I can see, kernel can't reclaim buffers fast enough.
>> ut looks better on -aa.
>> 
> 
> What sort of setup. I can't duplicate the problem here ?

I'm not sure exactly what Roy was doing, but we were taking a machine
with 16Gb of RAM, and reading files into the page cache - I think we built up
8 million buffer_heads according to slabinfo ... on a P4 they're 128 bytes each,
on a P3 96 bytes.

M.


