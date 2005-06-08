Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261215AbVFHNiu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261215AbVFHNiu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 09:38:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261244AbVFHNiU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 09:38:20 -0400
Received: from unthought.net ([212.97.129.88]:45759 "EHLO unthought.net")
	by vger.kernel.org with ESMTP id S261242AbVFHNhw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 09:37:52 -0400
Date: Wed, 8 Jun 2005 15:37:48 +0200
From: Jakob Oestergaard <jakob@unthought.net>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: segfaults suddenly appearing
Message-ID: <20050608133748.GJ422@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0506061104190.1876@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0506061104190.1876@ppc970.osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 06, 2005 at 11:08:25AM -0700, Linus Torvalds wrote:
> 
> It's being uploaded right now, the git tree is already up-to-date, and by 
> the time this hits the mailing list the mirroring of the tar-ball will 
> hopefully be done too.
...

Guys, here's a (yes I know, fairly vague) error report - I'm just
beginning to narrow this down.  Any suggestions would be greatly
appreciated.

Dual opteron (Sun Fire v20z), 2G RAM, untainted x86_64 kernels (no
preempt or other fancy stuff, just plain and simple K8 NUMA ACPI
configs);

Problem with 2.6.11.11:  Machine hangs during backup (amanda) - right
after the estimates are done the box will freeze hard, nothing on
console.

Tried 2.6.12-rc6 in the hope that it would at least print out a panic or
oops for me:  Haven't tried the backup yet, but I got the following in
the logs which I've never seen before:

gcc[18818]: segfault at 00000000332c8e54 rip 000000005555a0a8 rsp 00000000ffffba4c error 6
klogd[3116]: segfault at 000000003ef1b373 rip 000000000804a3b3 rsp 00000000ffffbbe0 error 4
gcc[18857]: segfault at 00000000332c8e54 rip 000000005555a0a8 rsp 00000000ffffbedc error 6
gcc[19049]: segfault at 00000000332c8e54 rip 000000005555a0a8 rsp 00000000ffffaefc error 6
gcc[19097]: segfault at 00000000332c8e54 rip 000000005555a0a8 rsp 00000000ffffb1fc error 6
gcc[19251]: segfault at 00000000332c8e54 rip 000000005555a0a8 rsp 00000000ffffc9dc error 6
gcc[19272]: segfault at 00000000332c8e54 rip 000000005555a0a8 rsp 00000000ffffb1bc error 6
gcc[1569]: segfault at 00000000332c8e54 rip 000000005555a0a8 rsp 00000000ffffb56c error 6
gcc[16458]: segfault at 00000000332c8e54 rip 000000005555a0a8 rsp 00000000ffffc9ac error 6

So, with 2.6.12-rc6 all of the sudden klogd and gcc starts
segfaulting...

No ECC errors or other anormalities reported via the service processor.

Anything you want me to try?  Need more information?

-- 

 / jakob

