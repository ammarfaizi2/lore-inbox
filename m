Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261231AbVBZQtL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261231AbVBZQtL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Feb 2005 11:49:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261233AbVBZQtK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Feb 2005 11:49:10 -0500
Received: from sccimhc92.asp.att.net ([63.240.76.166]:32477 "EHLO
	sccimhc92.asp.att.net") by vger.kernel.org with ESMTP
	id S261231AbVBZQtB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Feb 2005 11:49:01 -0500
From: Jay Roplekar <jay_roplekar@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Bad page state at prep_new_page
Date: Sat, 26 Feb 2005 10:48:33 -0600
User-Agent: KMail/1.7
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502261048.33591.jay_roplekar@hotmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been getting this error off and on  with vendor kernel 2.6.8, I have 
posted about it on lkml 3/4 times before. Actually I had offered to provide a 
summary of similar reports from the web with no takers, I can still provide 
that to somebody if it is useful.

 I had run memtest overnight with no errors, I use DRM etc..  The reason to 
post this  is  that very first line in the syslog  entries related to this 
error seems to be different  than before.  {It is typically is kernel BUG at 
mm/rmap.c or sth similar}.  Thanks, 

Jay

P.S. I am getting this error once in 3 days on an average (based on grep of 
moths worth syslog)  so I might have dubious distinction of being more 
repeatable.  May be it confirms Hugh's suspicion of hardware misbehaving but 
I am not ready to accept it yet :-)

####
Feb 26 09:37:03 localhost kernel: mm/memory.c:110: bad pmd 00000500.
Feb 26 09:39:58 localhost kernel: Bad page state at prep_new_page (in process 
'X', page c12678e0)
Feb 26 09:39:58 localhost kernel: flags:0x20000004 mapping:0000f700 mapcount:0 
count:0
Feb 26 09:39:58 localhost kernel: Backtrace:
Feb 26 09:39:58 localhost kernel:  [dump_stack+30/32] dump_stack+0x1e/0x20
Feb 26 09:39:58 localhost kernel:  [<c0107bfe>] dump_stack+0x1e/0x20
Feb 26 09:39:58 localhost kernel:  [bad_page+108/160] bad_page+0x6c/0xa0
Feb 26 09:39:58 localhost kernel:  [<c013d63c>] bad_page+0x6c/0xa0
Feb 26 09:39:58 localhost kernel:  [prep_new_page+40/112] 
prep_new_page+0x28/0x70
Feb 26 09:39:58 localhost kernel:  [<c013d968>] prep_new_page+0x28/0x70
Feb 26 09:39:58 localhost kernel:  [buffered_rmqueue+216/384] 
buffered_rmqueue+0xd8/0x180
Feb 26 09:39:58 localhost kernel:  [<c013de58>] buffered_rmqueue+0xd8/0x180
Feb 26 09:39:58 localhost kernel:  [__alloc_pages+161/752] 
__alloc_pages+0xa1/0x2f0
Feb 26 09:39:58 localhost kernel:  [<c013dfa1>] __alloc_pages+0xa1/0x2f0
Feb 26 09:39:58 localhost kernel:  [do_anonymous_page+102/368] 
do_anonymous_page+0x66/0x170
Feb 26 09:39:58 localhost kernel:  [<c0148796>] do_anonymous_page+0x66/0x170
Feb 26 09:39:58 localhost kernel:  [do_no_page+95/816] do_no_page+0x5f/0x330
Feb 26 09:39:58 localhost kernel:  [<c01488ff>] do_no_page+0x5f/0x330
Feb 26 09:39:58 localhost kernel:  [handle_mm_fault+341/416] 
handle_mm_fault+0x155/0x1a0
Feb 26 09:39:58 localhost kernel:  [<c0148e15>] handle_mm_fault+0x155/0x1a0
Feb 26 09:39:58 localhost kernel:  [do_page_fault+396/1456] 
do_page_fault+0x18c/0x5b0
Feb 26 09:39:58 localhost kernel:  [<c01198ec>] do_page_fault+0x18c/0x5b0
Feb 26 09:39:58 localhost kernel:  [error_code+45/56] error_code+0x2d/0x38
Feb 26 09:39:58 localhost kernel:  [<c0107849>] error_code+0x2d/0x38
Feb 26 09:39:58 localhost kernel: Trying to fix it up, but a reboot is needed
