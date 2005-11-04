Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750705AbVKDUWm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750705AbVKDUWm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 15:22:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750759AbVKDUWm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 15:22:42 -0500
Received: from zproxy.gmail.com ([64.233.162.201]:24752 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750705AbVKDUWl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 15:22:41 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=bgzuJba+n2yopSSk0KBhzRaG4WbKRoeywKTOEGe1xhRiu9pFLMzQCaA4JX+0jy1OzKaxIGgfGKpaWTL5N+N8AJ55Z4lfhF0U9X5TEMRKarySEwXVkt95mSTacmtem4gO6phnjcwRhRZsI+gC1I/GaYAeeAWce4oS52sicO6bm5k=
Message-ID: <569d37b00511041222g31ea546ft5adc7c38bdd89dbd@mail.gmail.com>
Date: Fri, 4 Nov 2005 15:22:41 -0500
From: Trevor Woerner <twoerner.k@gmail.com>
To: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Subject: [update] OOM issue with linux-2.6.14-rt6
Cc: Carlos Antunes <cmantunes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As I have mentioned earlier I was having problems with
linux-2.6.14-rt6 preemption settings k3 and k4 running out of memory.
While I don't have a fix I seem to have zeroed in on the problem.

Both my embedded target boards have CF cards which are mounted
read-only. Since I am using busybox-1.01 and because busybox ships
with mkfs.minix I simply used that to create a minix filesystem on
/dev/ram0 which I mount on /tmp. My test programs create named FIFOs
on /tmp which are integral to the tests I was performing.

Normally I can't get either of the above kernels to run for more than
15 minutes without an OOM, but switching from a minix fs to ext2
linux-2.6.14-rt6 k4 has been running on one of my boards for over 2
hours.

This might not be the solution but it's looking hopeful. I wanted to
mention this now, in case anyone else was curious about this issue.
I'll let these kernels run over the weekend to see how they perform.

I'm re-running my latency tests based on 2.6.14-rt6 and will update my
report when I have those results.
