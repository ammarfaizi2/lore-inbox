Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266864AbUIORIp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266864AbUIORIp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 13:08:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266626AbUIORIp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 13:08:45 -0400
Received: from sweetums.bluetronic.net ([24.199.150.42]:29899 "EHLO
	sweetums.bluetronic.net") by vger.kernel.org with ESMTP
	id S266845AbUIORBr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 13:01:47 -0400
Date: Wed, 15 Sep 2004 12:58:57 -0400 (EDT)
From: Ricky Beam <jfbeam@bluetronic.net>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Lee Revell <rlrevell@joe-job.com>, Zilvinas Valinskas <zilvinas@gemtek.lt>,
       Erik Tews <erik@debian.franken.de>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9 rc2 freezing
In-Reply-To: <414869AB.5070307@pobox.com>
Message-ID: <Pine.GSO.4.33.0409151255240.10693-100000@sweetums.bluetronic.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Sep 2004, Jeff Garzik wrote:
>Lee Revell wrote:
>> Anyway, if you are running anything on your server that breaks under
>> PREEMPT, it will break anyway as soon as you add another processor.
>
>Incorrect.  The spinlock behavior is very different.

Indeed.  Enable PREEMPT (my default for some time now) and the machine
will lockup after spewing pages of scheduling while atomic's.  Disable
PREEMPT and the machine is stable again:

[jfbeam:pts/2{2}]gir:~/[12:55pm]:uname -a
Linux gir 2.6.9-SMP-rc2+BK@1.1455 #71 SMP BK[20040914173940] Tue Sep 14 16:14:33 EDT 2004 i686 athlon i386 GNU/Linux
[jfbeam:pts/2{2}]gir:~/[12:55pm]:uptime
 12:55pm  up 19:54,  2 users,  load average: 0.01, 0.02, 0.00
[jfbeam:pts/2{2}]gir:~/[12:55pm]:grep ^proc /proc/cpuinfo
processor       : 0
processor       : 1

--Ricky


