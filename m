Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268657AbTBZF5x>; Wed, 26 Feb 2003 00:57:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268659AbTBZF5w>; Wed, 26 Feb 2003 00:57:52 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:39564 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id <S268657AbTBZF5v>;
	Wed, 26 Feb 2003 00:57:51 -0500
Date: Wed, 26 Feb 2003 06:07:59 +0000 (GMT)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: linux-kernel@vger.kernel.org
Subject: holding kernel semaphores while in userspace ...
Message-ID: <Pine.LNX.4.44.0302260551030.14299-100000@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've two processes that both read/write a shared resource (read via mmap,
write via write) that my device driver controls...

Now I know I could use SYSV semaphores and a shared mem region to
implement read/write semaphores but this seems to me to be a bit
heavyweight - I know I probably want futexes also (but this is 2.4 and I
probably wouldn't get that patch past the people here..)

So I was wondering if I added a couple of ioctls to my driver to wrap
access to a rwsem in the kernel, so four ioctls doing read/write up/down
combinations (are there interruptible versions for rwsems??), or is what
I'm doing stupid and evil .. and should I just be happy with my SYSV
semaphores or just use futexes (do these work acroess processes??)

Dave.

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied@skynet.ie
pam_smb / Linux DecStation / Linux VAX / ILUG person


