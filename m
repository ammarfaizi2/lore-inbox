Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292336AbSCRTRn>; Mon, 18 Mar 2002 14:17:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292368AbSCRTRa>; Mon, 18 Mar 2002 14:17:30 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:46769 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S292336AbSCRTRF>; Mon, 18 Mar 2002 14:17:05 -0500
Date: Mon, 18 Mar 2002 11:16:16 -0800
From: Hanna Linder <hannal@us.ibm.com>
To: Andrew Morton <akpm@zip.com.au>, lkml <linux-kernel@vger.kernel.org>
cc: hannal@us.ibm.com
Subject: Re: [CFT] delayed allocation and multipage I/O patches for 2.5.6.
Message-ID: <7820000.1016478976@w-hlinder.des>
In-Reply-To: <3C8D9999.83F991DB@zip.com.au>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--On Monday, March 11, 2002 22:00:57 -0800 Andrew Morton <akpm@zip.com.au> wrote:

>    "help, help - there's no point in just one guy testing this" (thanks Randy). 

	Will you accept the testing of a gal? ;)
> 
> This is an update of the delayed-allocation and multipage pagecache I/O
> patches.  I'm calling this a beta, because it all works, and I have
> other stuff to do for a while.
> 

	Here are the dbench throughput results on an 8-way SMP with 2GB memory.
These are run with 64 then 128 clients 15 times each averaged. It looked 
pretty good.
	Running with more than 180 clients caused the system to hang, after 
a reset there was much filesystem corruption. This happened twice. Probably
related to filling up disk space. There are no ServerRaid drivers for 2.5 yet 
so the biggest disks on this system are unusable. lockmeter results are forthcoming (day or two). 

Running dbench on an 8-way SMP 15 times each.

2.5.6 clean

Clients		Avg

64		37.9821
128		29.8258

2.5.6 with everything.patch

Clients		Avg

64		41.0204
128		30.6431

Hanna 


