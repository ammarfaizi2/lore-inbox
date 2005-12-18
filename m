Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965286AbVLRWDA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965286AbVLRWDA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 17:03:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965287AbVLRWDA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 17:03:00 -0500
Received: from mtao02.charter.net ([209.225.8.187]:58335 "EHLO
	mtao02.charter.net") by vger.kernel.org with ESMTP id S965286AbVLRWC7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 17:02:59 -0500
X-BrightmailFiltered: true
X-Brightmail-Tracker: AAAAAQAAA+k=
Message-ID: <43A5DBF0.6030801@cybsft.com>
Date: Sun, 18 Dec 2005 16:00:16 -0600
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Thunderbird 1.5 (X11/20051025)
MIME-Version: 1.0
To: Florian Schmidt <mista.tapas@gmx.net>
CC: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-rc5-rt2 build error
References: <20051218210614.75f424eb@mango.fruits.de>
In-Reply-To: <20051218210614.75f424eb@mango.fruits.de>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Florian Schmidt wrote:
> config attached [cat .config|grep -v "#" >config]
> 
>   CC      lib/rwsem.o
> lib/rwsem.c: In function '__rwsem_do_wake':
> lib/rwsem.c:57: warning: implicit declaration of function 'rwsem_atomic_update'
> lib/rwsem.c:57: error: 'RWSEM_ACTIVE_BIAS' undeclared (first use in this function)
> lib/rwsem.c:57: error: (Each undeclared identifier is reported only once
> lib/rwsem.c:57: error: for each function it appears in.)
> lib/rwsem.c:59: error: 'RWSEM_ACTIVE_MASK' undeclared (first use in this function)
> lib/rwsem.c:62: error: 'struct rw_semaphore' has no member named 'wait_list'
> lib/rwsem.c:85: error: 'struct rw_semaphore' has no member named 'wait_list'
> lib/rwsem.c:99: error: 'struct rw_semaphore' has no member named 'wait_list'
> lib/rwsem.c:108: error: 'RWSEM_WAITING_BIAS' undeclared (first use in this function)
> lib/rwsem.c:113: warning: implicit declaration of function 'rwsem_atomic_add'
> lib/rwsem.c:115: error: 'struct rw_semaphore' has no member named 'wait_list'
> lib/rwsem.c:126: error: 'struct rw_semaphore' has no member named 'wait_list'
> lib/rwsem.c:127: error: 'struct rw_semaphore' has no member named 'wait_list'
> lib/rwsem.c: In function 'rwsem_down_failed_common':
> lib/rwsem.c:153: error: 'struct rw_semaphore' has no member named 'wait_lock'
> lib/rwsem.c:153: warning: type defaults to 'int' in declaration of 'type name'
> lib/rwsem.c:153: error: 'struct rw_semaphore' has no member named 'wait_lock'
> lib/rwsem.c:153: error: 'struct rw_semaphore' has no member named 'wait_lock'
> lib/rwsem.c:153: warning: type defaults to 'int' in declaration of 'type name'
> lib/rwsem.c:153: error: 'struct rw_semaphore' has no member named 'wait_lock'
> lib/rwsem.c:157: error: 'struct rw_semaphore' has no member named 'wait_list'
> lib/rwsem.c:163: error: 'RWSEM_ACTIVE_MASK' undeclared (first use in this function)
> lib/rwsem.c:166: error: 'struct rw_semaphore' has no member named 'wait_lock'
> lib/rwsem.c:166: warning: type defaults to 'int' in declaration of 'type name'
> lib/rwsem.c:166: error: 'struct rw_semaphore' has no member named 'wait_lock'
> lib/rwsem.c:166: error: 'struct rw_semaphore' has no member named 'wait_lock'
> lib/rwsem.c:166: warning: type defaults to 'int' in declaration of 'type name'
> lib/rwsem.c:166: error: 'struct rw_semaphore' has no member named 'wait_lock'
> lib/rwsem.c: In function 'rwsem_down_read_failed':
> lib/rwsem.c:193: error: 'RWSEM_WAITING_BIAS' undeclared (first use in this function)
> lib/rwsem.c:193: error: 'RWSEM_ACTIVE_BIAS' undeclared (first use in this function)
> lib/rwsem.c: In function 'rwsem_down_write_failed':
> lib/rwsem.c:210: error: 'RWSEM_ACTIVE_BIAS' undeclared (first use in this function)
> lib/rwsem.c: In function 'rwsem_wake':
> lib/rwsem.c:226: error: 'struct rw_semaphore' has no member named 'wait_lock'
> lib/rwsem.c:226: warning: type defaults to 'int' in declaration of 'type name'
> lib/rwsem.c:226: error: 'struct rw_semaphore' has no member named 'wait_lock'
> lib/rwsem.c:226: error: 'struct rw_semaphore' has no member named 'wait_lock'
> lib/rwsem.c:226: warning: type defaults to 'int' in declaration of 'type name'
> lib/rwsem.c:226: error: 'struct rw_semaphore' has no member named 'wait_lock'
> lib/rwsem.c:229: error: 'struct rw_semaphore' has no member named 'wait_list'
> lib/rwsem.c:232: error: 'struct rw_semaphore' has no member named 'wait_lock'
> lib/rwsem.c:232: warning: type defaults to 'int' in declaration of 'type name'
> lib/rwsem.c:232: error: 'struct rw_semaphore' has no member named 'wait_lock'
> lib/rwsem.c:232: error: 'struct rw_semaphore' has no member named 'wait_lock'
> lib/rwsem.c:232: warning: type defaults to 'int' in declaration of 'type name'
> lib/rwsem.c:232: error: 'struct rw_semaphore' has no member named 'wait_lock'
> lib/rwsem.c: In function 'rwsem_downgrade_wake':
> lib/rwsem.c:250: error: 'struct rw_semaphore' has no member named 'wait_lock'
> lib/rwsem.c:250: warning: type defaults to 'int' in declaration of 'type name'
> lib/rwsem.c:250: error: 'struct rw_semaphore' has no member named 'wait_lock'
> lib/rwsem.c:250: error: 'struct rw_semaphore' has no member named 'wait_lock'
> lib/rwsem.c:250: warning: type defaults to 'int' in declaration of 'type name'
> lib/rwsem.c:250: error: 'struct rw_semaphore' has no member named 'wait_lock'
> lib/rwsem.c:253: error: 'struct rw_semaphore' has no member named 'wait_list'
> lib/rwsem.c:256: error: 'struct rw_semaphore' has no member named 'wait_lock'
> lib/rwsem.c:256: warning: type defaults to 'int' in declaration of 'type name'
> lib/rwsem.c:256: error: 'struct rw_semaphore' has no member named 'wait_lock'
> lib/rwsem.c:256: error: 'struct rw_semaphore' has no member named 'wait_lock'
> lib/rwsem.c:256: warning: type defaults to 'int' in declaration of 'type name'
> lib/rwsem.c:256: error: 'struct rw_semaphore' has no member named 'wait_lock'
> make[1]: *** [lib/rwsem.o] Error 1
> make: *** [lib] Error 2
> ~/source/kernel/linux-2.6.14$ 
> 
> Regards,
> Flo
> 

Flo,

Look back through the mailing list for the past week for a thread
entitled "kernel-2.6.15-rc5-rt2 - compilation error" and check out
Steven's patches in that thread. If you can't find it let me know.

-- 
   kr
