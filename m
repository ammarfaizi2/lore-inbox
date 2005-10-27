Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751073AbVJ0PZq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751073AbVJ0PZq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 11:25:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751079AbVJ0PZq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 11:25:46 -0400
Received: from xproxy.gmail.com ([66.249.82.199]:58856 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751073AbVJ0PZp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 11:25:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=CICe15FkoOYEDUySdNQqjeeh+VE6j94MA+5eXa9DpJ5HGZ6k/9xN12aV6bDBv50/pGQVXRJBfwUFaxhw5e5QZ4m7YENMVwyrGq2hASE2mmamXa2spac8XRQMtl6j62hHS9Zz0jN0LxCll3tKC3RaxyZOuAXjRW9AOEcdIjH6UxM=
Subject: 2.6.14-rc5: X spinning in the kernel [ Was: 2.6.14-rc5 GPF in
	radeon_cp_init_ring_buffer()]
From: Badari Pulavarty <pbadari@gmail.com>
To: Dave Airlie <airlied@linux.ie>
Cc: torvalds@osdl.org, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <82b32ed40510262111m2e3b749yca4f78982e879e5e@mail.gmail.com>
References: <Pine.LNX.4.58.0510261103510.24177@skynet>
	 <82b32ed40510262111m2e3b749yca4f78982e879e5e@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 27 Oct 2005 08:25:11 -0700
Message-Id: <1130426711.23729.61.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-10-26 at 21:11 -0700, Badari Pulavarty wrote:
> On 10/26/05, Dave Airlie <airlied@linux.ie> wrote:
> >
> > Hi Linus/Andrew,
> >
> > Another 2.6.14 DRM fix.. they always come in 3s.. hopefully thats it..
> >
> > Dave.
> >
> 
> Seems to have fixed my problem.


Spoke too early, with your patch X is spinning in the kernel :(
Could be completely different problem though ..

Thanks,
Badari


top - 08:23:50 up 20 min,  1 user,  load average: 1.51, 1.38, 1.02
Tasks:  60 total,   2 running,  58 sleeping,   0 stopped,   0 zombie
Cpu(s):  0.4% us, 46.1% sy,  0.0% ni, 52.0% id,  1.5% wa,  0.0% hi,
0.0% si
Mem:   4043140k total,   226364k used,  3816776k free,    16156k buffers
Swap:  4192924k total,        0k used,  4192924k free,   139904k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
 3623 root      18   0 51996  11m 2524 R 92.3  0.3  18:43.36 X
 3957 root      16   0  6204  884  688 R  1.6  0.0   0:00.01 top
    1 root      16   0  4820  576  480 S  0.0  0.0   0:00.50 init
    2 root      RT   0     0    0    0 S  0.0  0.0   0:00.00 migration/0
    3 root      34  19     0    0    0 S  0.0  0.0   0:00.00 ksoftirqd/0
    4 root      RT   0     0    0    0 S  0.0  0.0   0:00.00 watchdog/0


sysrq-t shows nothing :(

X             R  running task       0  3623   3620          3910
(NOTLB)


