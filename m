Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263246AbRFLUj5>; Tue, 12 Jun 2001 16:39:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263250AbRFLUjq>; Tue, 12 Jun 2001 16:39:46 -0400
Received: from mercury.ultramaster.com ([208.222.81.163]:37504 "EHLO
	mercury.ultramaster.com") by vger.kernel.org with ESMTP
	id <S263246AbRFLUjd>; Tue, 12 Jun 2001 16:39:33 -0400
Message-ID: <3B267DE6.FC6A2281@dm.ultramaster.com>
Date: Tue, 12 Jun 2001 16:39:02 -0400
From: David Mansfield <lkml@dm.ultramaster.com>
Organization: Ultramaster Group LLC
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>, jfs-discussion@oss.lotus.com
Subject: severe FS corruption with 2.4.6-pre2 + IBM jfs 0.3.4 patch
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It's probably a JFS issue, but I thought I'd report this in case someone
is collecting and correlating filesystem corruption messages (Alan?). 
Here is my sad story.

I have an Athlon 700MHZ, 256mb ram, AIC7XXX w 2/U2W drives system.  I've
been running JFS on a small partition for a few weeks, JFS 0.3.1 under
2.4.5, 0.3.3 with 2.4.6-pre1 and yesterday I tried 2.4.6-pre2 with jfs
0.3.4.

I rebooted into the new kernel, and noticed one of those Red Hat [FAIL]
messages that pops up during the rc/init stages.  It's a config problem
I've had for months, nothing new, but I decided I'd take care of it.  I
logged into the console, ran emacs and it segfaulted.  I ran 'dmesg' but
there was nothing (I was expecting to see an oops).  I ran emacs again,
segfault.  I tried logging in to another console, hang.  

At this point I hit sysrq-T, and of everything that spewed by, I noticed
one process (which had scrolled to far off the screen to see the PID)
with a whole lot of
<dbdbdbdb> <dbdbdbdb> <dbdbdbdb> in the stack trace.

At this point I did sysrq-S-U-B and rebooted.  End of story.

My filesystems were severely f***ed at this point.  A total of about 60
seconds running this kernel and I was dead.  My OS partition was
trashed, about 1/2 of it was unrecoverable.  My home partition fared
better (good luck) but still had plenty of trashed inodes.

I've never had problems with any kernels before this...

That's my story,
David


-- 
David Mansfield                                           (718) 963-2020
david@ultramaster.com
Ultramaster Group, LLC                               www.ultramaster.com
