Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292917AbSB0T7K>; Wed, 27 Feb 2002 14:59:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292918AbSB0T6t>; Wed, 27 Feb 2002 14:58:49 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:17094 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S292917AbSB0T6U>;
	Wed, 27 Feb 2002 14:58:20 -0500
Date: Wed, 27 Feb 2002 11:57:57 -0800
From: Hanna Linder <hannal@us.ibm.com>
To: Andrew Morton <akpm@zip.com.au>,
        "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
cc: Hanna Linder <hannal@us.ibm.com>, linux-kernel@vger.kernel.org,
        lse-tech@lists.sourceforge.net, viro@math.psu.edu
Subject: Re: [Lse-tech] lockmeter results comparing 2.4.17, 2.5.3, and 2.5.5
Message-ID: <19890000.1014839877@w-hlinder.des>
In-Reply-To: <3C7D374B.4621F9BA@zip.com.au>
In-Reply-To: <10460000.1014833979@w-hlinder.des>,	<10460000.1014833979@w-hlinder.des> <67850000.1014834875@flay> <3C7D374B.4621F9BA@zip.com.au>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On Wednesday, February 27, 2002 11:45:15 -0800 Andrew Morton <akpm@zip.com.au> wrote:

> The big one is lru_list_lock, of course.  I'll be releasing code in
> the next couple of days which should take that off the map.  Testing
> would be appreciated.

	Ill be glad to run this again with your patch. Also, John Hawkes
has an even bigger system and keeps hitting lru_list_lock too.
> 
> I have a concern about the lockmeter results.  Lockmeter appears
> to be measuring lock frequency and hold times and contention.  But
> is it measuring the cost of the cacheline transfers?   

	This has come up a few times on lse-tech. Lockmeter doesnt
measure cacheline hits/misses/bouncing. However, someone said
kernprof could be used to access performance registers on the Pentium
chip to get this info. I don't know anyone who has tried that though.
	I am working on a patch to decrease cacheline bouncing and it
would be great to see some specific results. Is anyone working on a tool 
that could measure cache hits/misses/bouncing?

Hanna



