Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264402AbUEPRo6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264402AbUEPRo6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 May 2004 13:44:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264622AbUEPRo6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 May 2004 13:44:58 -0400
Received: from main.gmane.org ([80.91.224.249]:48818 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S264402AbUEPRo4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 May 2004 13:44:56 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: sean <seandarcy@hotmail.com>
Subject: 2.6.6 bk3 make really broken at mm/fault.o
Date: Sun, 16 May 2004 13:44:52 -0400
Message-ID: <c889al$rcb$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: ool-4356fe48.dyn.optonline.net
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a) Gecko/20040501
X-Accept-Language: en-us, en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

building bk3:

.............................
  CC      arch/i386/mm/init.o
   CC      arch/i386/mm/pgtable.o
   CC      arch/i386/mm/fault.o
In file included from arch/i386/mm/fault.c:7:
include/linux/signal.h:4:24: include/linux/list.h: File too large
In file included from arch/i386/mm/fault.c:7:
include/linux/signal.h:15: error: field `list' has incomplete type
include/linux/signal.h:25: error: field `list' has incomplete type
include/linux/signal.h: In function `init_sigpending':
include/linux/signal.h:207: warning: implicit declaration of function 
`INIT_LIST_HEAD'
In file included from include/asm/semaphore.h:41,
                  from include/linux/sched.h:18,
                  from arch/i386/mm/fault.c:8:
include/linux/wait.h: At top level:
include/linux/wait.h:28: error: field `task_list' has incomplete type
include/linux/wait.h:33: error: field `task_list' has incomplete type
................................

and everything's broken from then on.

sean

