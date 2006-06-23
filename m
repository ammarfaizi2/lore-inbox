Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751818AbWFWRhc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751818AbWFWRhc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 13:37:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751821AbWFWRhc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 13:37:32 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:40343 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751818AbWFWRhc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 13:37:32 -0400
Date: Fri, 23 Jun 2006 19:37:03 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Brian Hall <brihall@pcisys.net>
cc: Sebastian Noack <xaon.seb@gmx.net>, ck@vds.kolivas.org,
       linux-kernel@vger.kernel.org
Subject: Re: [ck] problem burning DVDs with 2.6.17-ck1 (mlockall?)
In-Reply-To: <20060623145903.GA12719@pcisys.net>
Message-ID: <Pine.LNX.4.61.0606231936150.26864@yvahk01.tjqt.qr>
References: <200606230819.44551.xaon.seb@gmx.net> <20060623145903.GA12719@pcisys.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>Aha! Solved, thanks.
>
>echo "ulimit -l unlimited" >> /etc/conf.d/local.start
>
>Thanks to all for the quick replies.

That seems strange. This is on SUSE Linux 10.1, using the root account:

19:36 shanghai:/J/kernel/linux-2.6.17+ # ulimit -a
core file size          (blocks, -c) 0
data seg size           (kbytes, -d) unlimited
file size               (blocks, -f) unlimited
pending signals                 (-i) 6143
max locked memory       (kbytes, -l) 32
max memory size         (kbytes, -m) unlimited
open files                      (-n) 1024
pipe size            (512 bytes, -p) 8
POSIX message queues     (bytes, -q) 819200
stack size              (kbytes, -s) 8192
cpu time               (seconds, -t) unlimited
max user processes              (-u) 6143
virtual memory          (kbytes, -v) unlimited
file locks                      (-x) unlimited

and I have no problems with cdrecord-prodvd wrt. mmap or memlocking.



Jan Engelhardt
-- 
