Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278181AbRJRWg2>; Thu, 18 Oct 2001 18:36:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278187AbRJRWgS>; Thu, 18 Oct 2001 18:36:18 -0400
Received: from caracal.noc.ucla.edu ([169.232.10.11]:55509 "EHLO
	caracal.noc.ucla.edu") by vger.kernel.org with ESMTP
	id <S278181AbRJRWgD>; Thu, 18 Oct 2001 18:36:03 -0400
Message-ID: <3BCF5973.8020705@ucla.edu>
Date: Thu, 18 Oct 2001 15:36:35 -0700
From: Benjamin Redelings I <bredelin@ucla.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5+) Gecko/20011015
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.3.13-pre4 rather unstable?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi, I was using 2.3.14-pre4 here, but I had to reboot twice although I 
didn't get an OOPS, so I reverted to 2.4.11-pre6.
	1) first, my login to kde got stuck.  I had a lot of unkillable "kdeinit: 
" processes, which were waiting in (I think) lockp and pipe_write, or 
maybe pipe_way or something.
	2) I rebooted and it seems to be OK.  However, when installing stuff 
using dpkg one of the scripts hung.  My open konsole windows turned 
unresponsive.  I tried to log in text mode, but it hung after printing 
the motd.  Then I tried to log in as root - same thing!  Then the whole 
system hung.  I couldn't get back into X on vt7...

	The only modifications that I made were to
	a) called mark_page_accessed if pte_young is true in do_try_to_free_pages 
in vmscan.c
	b) add 'if (PageActive(page)) return 0;' to the same function.
	These modifications haven't caused any problem in previous kernels, and 
seem to work fine.

	One thing which may be relevant is that home dirs are on nfs.  Any ideas? 
  Anyone else have similar problems?

-BenRI

128MB RAM, IDE, Intel PIII, ethernet rltk8139
-- 
"At this time Frodo was still in his 'tweens', as the hobbits called
the irresponsible twenties between childhood and coming-of-age at
thirty three" - The Fellowship of the Ring, J.R.R. Tolkein
Benjamin Redelings I      <><     http://www.bol.ucla.edu/~bredelin/

