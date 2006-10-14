Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030350AbWJNRkH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030350AbWJNRkH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Oct 2006 13:40:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030352AbWJNRkH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Oct 2006 13:40:07 -0400
Received: from c-71-197-74-6.hsd1.ca.comcast.net ([71.197.74.6]:55953 "EHLO
	nofear.bounceme.net") by vger.kernel.org with ESMTP
	id S1030354AbWJNRkF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Oct 2006 13:40:05 -0400
Message-ID: <4531210B.9050205@syphir.sytes.net>
Date: Sat, 14 Oct 2006 10:40:27 -0700
From: "C.Y.M" <syphir@syphir.sytes.net>
Reply-To: syphir@syphir.sytes.net
Organization: CooLNeT
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>, linux-kernel@vger.kernel.org
Subject: Re: BUG: warning at fs/inotify.c:181 with linux-2.6.18
References: <452581D7.5020907@syphir.sytes.net> <4525B546.7070305@yahoo.com.au> <4525BD61.80400@syphir.sytes.net>
In-Reply-To: <4525BD61.80400@syphir.sytes.net>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

C.Y.M wrote:
> Nick Piggin wrote:
>> C.Y.M wrote:
>>> Since I updated to 2.6.18, I have had the following warnings in my
>>> syslog.  Is
>>> this a known problem? Better yet, is there a solution to this?  I am
>>> running on
>>> a i686 (Athlon XP) 32 bit cpu compiled under gcc-3.4.6.
>>>
>>>
>>> Oct  5 08:27:31 sid kernel: BUG: warning at
>>> fs/inotify.c:181/set_dentry_child_flags()
>>> Oct  5 08:27:31 sid kernel:  [<c0182a10>]
>>> set_dentry_child_flags+0x170/0x190
>>> Oct  5 08:27:31 sid kernel:  [<c0182adf>] remove_watch_no_event+0x5f/0x70
>>> Oct  5 08:27:31 sid kernel:  [<c0182b08>]
>>> inotify_remove_watch_locked+0x18/0x50
>>> Oct  5 08:27:31 sid kernel:  [<c01833dc>] inotify_rm_wd+0x6c/0xb0
>>> Oct  5 08:27:31 sid kernel:  [<c0183e98>] sys_inotify_rm_watch+0x38/0x60
>>> Oct  5 08:27:31 sid kernel:  [<c0102d8f>] syscall_call+0x7/0xb
>> I don't think it is a known problem. Is it reproduceable? Any idea what
>> is making the inotify syscalls?
>>
> 
> The warning messages start about an hour or two after I boot into the 2.6.18
> kernel.  I am not doing anything on the machine when it happens.  I don't see
> any new processes starting up at that time either.  As soon as I boot back to
> 2.6.17.13, there are no more problems.  Also, the machine is not running X when
> it occurs.
> 
> root@sid:~$ grep BUG /var/log/syslog
> Oct  5 08:27:31 sid kernel: BUG: warning at
> fs/inotify.c:181/set_dentry_child_flags()
> Oct  5 11:46:36 sid kernel: BUG: warning at
> fs/inotify.c:181/set_dentry_child_flags()
> Oct  5 13:24:50 sid kernel: BUG: warning at
> fs/inotify.c:181/set_dentry_child_flags()
> Oct  5 15:17:55 sid kernel: BUG: warning at
> fs/inotify.c:181/set_dentry_child_flags()
> Oct  5 16:40:10 sid kernel: BUG: warning at
> fs/inotify.c:181/set_dentry_child_flags()
> 

This bug just happened again with 2.6.18.1.  Has anyone else noticed this in
their logs?  I would really like to make that error go away. Any Ideas?  I do
not see anything that would cause this to happen.

Best Regards.
