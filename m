Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274829AbRIZE7w>; Wed, 26 Sep 2001 00:59:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274830AbRIZE7m>; Wed, 26 Sep 2001 00:59:42 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:11723 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S274829AbRIZE7f>; Wed, 26 Sep 2001 00:59:35 -0400
Date: Wed, 26 Sep 2001 10:34:24 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: davem@redhat.com
Cc: marcelo@connectiva.com.br, riel@connectiva.com.br,
        Andrea Arcangeli <andrea@suse.de>, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org, hawkes@engr.sgi.com
Subject: Re: Locking comment on shrink_caches()
Message-ID: <20010926103424.A8893@in.ibm.com>
Reply-To: dipankar@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20010925.132816.52117370.davem@redhat.com> David S. Miller wrote:
>    From: Rik van Riel <riel@conectiva.com.br>
>    Date: Tue, 25 Sep 2001 17:24:21 -0300 (BRST)
>    
>    Or were you measuring loads which are mostly read-only ?

> When Kanoj Sarcar was back at SGI testing 32 processor Origin
> MIPS systems, pagecache_lock was at the top.

John Hawkes from SGI had published some AIM7 numbers that showed
pagecache_lock to be a bottleneck above 4 processors. At 32 processors,
half the CPU cycles were spent on waiting for pagecache_lock. The
thread is at -

http://marc.theaimsgroup.com/?l=lse-tech&m=98459051027582&w=2

Thanks
Dipankar
-- 
Dipankar Sarma  <dipankar@in.ibm.com> Project: http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.
