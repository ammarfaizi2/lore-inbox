Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261348AbUCLKqa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 05:46:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261410AbUCLKq3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 05:46:29 -0500
Received: from moutng.kundenserver.de ([212.227.126.171]:59855 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S261348AbUCLKq2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 05:46:28 -0500
To: "Anders K. Pedersen" <akp@cohaesio.com>
Cc: "Jan Kara" <jack@suse.cz>, "Andrew Morton" <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.3 userspace freeze
References: <222BE5975A4813449559163F8F8CF503458441@cohsrv1.cohaesio.com>
From: Olaf Dietsche <olaf+list.linux-kernel@olafdietsche.de>
Date: Fri, 12 Mar 2004 11:46:22 +0100
Message-ID: <87ptbi5on5.fsf@goat.bogus.local>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Portable Code, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:fa0178852225c1084dbb63fc71559d78
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Anders K. Pedersen" <akp@cohaesio.com> writes:

> Last output from top before it froze:
>
[...]
> 23640 root      25   0  3660  752  3388 S     0.3  0.0   0:00   0
> rotatelogs
> 23656 root      25   0  3660  752  3388 S     0.3  0.0   0:00   1
> rotatelogs
> 23684 root      15   0  2696 1416  1712 S     0.3  0.0   0:00   1
> rotatelogspsoft
> 23685 root      15   0  2584 1300  1712 S     0.3  0.0   0:00   1
> rotatelogspsoft
>   939 root      16   0  6132 1824  5788 S     0.1  0.0   0:01   1 sshd
> 23622 root      25   0  3656  748  3388 S     0.1  0.0   0:00   1
> rotatelogs
[many rotatelogs]
> 23643 root      25   0  3660  752  3388 S     0.1  0.0   0:00   1
> rotatelogs
>
> If there is anything I can do to debug the reason for these deadlocks,
> please let me know.

There are always many rotatelogs started. Maybe that's a hint for
further investigation.

Regards, Olaf.
