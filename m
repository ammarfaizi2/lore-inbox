Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266928AbRGMErR>; Fri, 13 Jul 2001 00:47:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266929AbRGMErH>; Fri, 13 Jul 2001 00:47:07 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:5384 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S266928AbRGMEq7>; Fri, 13 Jul 2001 00:46:59 -0400
Date: Fri, 13 Jul 2001 00:15:25 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: lkml <linux-kernel@vger.kernel.org>
Cc: linux-mm@kvack.org
Subject: Updated VM statistics patch
Message-ID: <Pine.LNX.4.21.0107130003030.2821-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, 

I've updated the VM statistics patch. The following changed:

- Added CONFIG_VM_STATS option and Configure.help documentation
- Added Documentation/vm/statistics file which has a description
  of each stats field.
- Added more statistics:

vm_pgagescan: pages scanned by refill_inactive_scan()
vm_pgagedown: pages aged down by refill_inative_scan()
vm_pgageup: pages aged up by refill_inactive_scan()/try_to_swap_out()
vm_pgdeactfail_age: nr of deactivation failures on refill_inactive_scan()
due to >0 age
vm_pgdeactfail_ref: nr of deactivation failures on refill_inactive_scan()
due to zero aged pages with more users than the pagecache
vm_ptescan: nr of present ptes scanned by swap_out()
vm_pteunmap: nr of present ptes unmapped by swap_out()

- Changed the vmstat.c hack to not report separated per-zone information
by default, making the output more readable. If needed the per-zone
information can be seen with the "-z" option. 

Kernel patch (vmstatistics.patch) plus vmstat patch (vmstat.patch) plus
vmstat.c itself at 
http://bazar.conectiva.com.br/~marcelo/patches/v2.4/2.4.7pre5/

