Return-Path: <linux-kernel-owner+w=401wt.eu-S1753438AbWLRHZF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753438AbWLRHZF (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 02:25:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753439AbWLRHZF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 02:25:05 -0500
Received: from nf-out-0910.google.com ([64.233.182.184]:6200 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753438AbWLRHZD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 02:25:03 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=NRkKyzYmLafS6E5p4YuOzY6ya3IcbrxIImk+jLzTgEtADWWDC4zDVU6LQ4F/cHlk5ebQ9ktTuIuSwQQyxsIep4vpwZEFN5ll/XG0LNx9z8G/1PdPsSL3Xg807NqizMjMQ2XmaxADyU1O0D3kaJHO+YI0NFL9I/Gw1qf5JkjpuyY=
Message-ID: <f1dc79790612172325n54e1e654u76c31120d4153cf5@mail.gmail.com>
Date: Mon, 18 Dec 2006 10:25:01 +0300
From: "Nick Olkin" <nick.olkin@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Q: pages_min determination
Cc: nick.olkin@gmail.com
MIME-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all!

I've a question regarding the work of the Virtual Memory Manager.
Unfortunately reading the "Understanding The Linux Virtual Memory
Manager" (Mel Gorman) didn't help much.

In general the question is how to determine on the working machine
what the number of the pages_min is?

I have a SunFire v20z running the Red Hat Enterprise Linux AS release
3 (Taroon Update 7) 2.4.21-40.ELsmp.

To be honest this question is not of very high urgency and it does not
imply high practical importance. The interest was stimulated by the
observing the VM activities on the machine. The server has 4G of
physical RAM and 4G of swap. A Java App is running on this host. It
works quite stable, but any time I check the memory state I see that
the free memory is quite low, and the swap is not used at all. It does
not worry me as far as I don't see any lack of memory messages, but I
wonder how the zone balancing occurs, how does it determine the way of
freeing pages and how can make the system to start swaping (just for
testing of cause). I tried to load my system a bit more (started
different applications to consume the memory), but as you all guessed,
all I've got is slightly lessened free mem and some reclamation
between cached/used/free.

I thought the value of min_free_kbytes would help me, but I didn't
find it on my system:

ls  /proc/sys/vm/
bdflush
dcache_priority
hugetlb_pool
inactive_clean_percent
kscand_work_percent
kswapd
max_map_count
max-readahead
min-readahead
oom-kill
overcommit_memory
overcommit_ratio
pagecache
page-cluster
pagetable_cache
skip_mapped_pages
stack_defer_threshold

The sample output of free –m

             total       used       free     shared    buffers     cached

Mem:          3955       3927         28          0         65       3611
-/+ buffers/cache:        250       3705
Swap:         4094          0       4094

I will greatly appreciate any assistance although I understand that my
question does not suite this mailing-list entirely.

Thanks a lot!
