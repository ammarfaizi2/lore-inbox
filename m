Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271557AbTGQWTf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 18:19:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271593AbTGQWRm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 18:17:42 -0400
Received: from lindsey.linux-systeme.com ([80.190.48.67]:43785 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S271585AbTGQWQw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 18:16:52 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org,
       Chris Mason <mason@suse.com>
Subject: Re: 2.4.22pre6aa1
Date: Fri, 18 Jul 2003 00:30:45 +0200
User-Agent: KMail/1.5.2
References: <20030717102857.GA1855@dualathlon.random> <200307180013.38078.m.c.p@wolk-project.de>
In-Reply-To: <200307180013.38078.m.c.p@wolk-project.de>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200307180024.17523.m.c.p@wolk-project.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 18 July 2003 00:13, Marc-Christian Petersen wrote:

> On Thursday 17 July 2003 12:28, Andrea Arcangeli wrote:
>
> Hi Andrea,
>
> > Only in 2.4.22pre6aa1: 00_elevator-lowlatency-1
> > Only in 2.4.22pre6aa1: 00_elevator-read-reservation-axboe-2l-1
>
> Hmm, this is now my first day testing out .22-pre6 and .22-pre6aa1 with the
> new I/O stall fixes. At a first look & feel it's very good, but I've
> noticed a side effect (if it can be called so):
>
> VMware4 Workstation
> -------------------
>
> 2.4.22-pre[6|6aa1]: ~ 1 minute 02 seconds from: Start this virtual machine
> ... 2.4.22-pre2       : ~          30 seconds from: Start this virtual
> machine ...
>
> ... to start up Windows 2000 Professional completely.
>
> Well, personally I don't care about the slowdown of vmware startup with a
> VM but there may be many other slowdows?!
hmmm:

2.4.22-pre[6|6aa1]:
-------------------
root@codeman:[/] # dd if=/dev/zero of=/home/largefile bs=16384 count=131072
131072+0 records in
131072+0 records out
2147483648 bytes transferred in 128.765686 seconds (16677453 bytes/sec)

2.4.22-pre2:
------------
root@codeman:[/] # dd if=/dev/zero of=/home/largefile bs=16384 count=131072
131072+0 records in
131072+0 records out
2147483648 bytes transferred in 98.489331 seconds (21804226 bytes/sec)

both kernels freshly rebooted.


Machine:
--------
Celeron 1,3GHz
512MB RAM
2x IDE (UDMA100) 60/40 GB
1GB SWAP, 512MB on each disk (same priority)
ext3fs (data=ordered)
XFree 4.3
WindowMaker 0.82-CVS


ciao, Marc

