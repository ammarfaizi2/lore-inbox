Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272093AbRIJWpX>; Mon, 10 Sep 2001 18:45:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272088AbRIJWpN>; Mon, 10 Sep 2001 18:45:13 -0400
Received: from red.csi.cam.ac.uk ([131.111.8.70]:9393 "EHLO red.csi.cam.ac.uk")
	by vger.kernel.org with ESMTP id <S272079AbRIJWo5>;
	Mon, 10 Sep 2001 18:44:57 -0400
Message-Id: <5.1.0.14.2.20010910234129.05133ec0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 10 Sep 2001 23:45:13 +0100
To: Wayne.Brown@altec.com
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: ntfs problem with 2.4.10-pre7
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <86256AC3.0069F85E.00@smtpnotes.altec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

At 20:15 10/09/2001, Wayne.Brown@altec.com wrote:
>Since upgrading to 2.4.10-pre7, accessing my Win2000 ntfs partition (mounted
>read-only) causes a lockup.  There are no oops messages on the console or 
>in the
>logs; if I'm in text mode when it happens the system still responds to 
><alt-f1>
>etc. and to <alt-sysrq> but not to anything else.  If I'm in X nether the 
>mouse
>nor the keyboard respond.  This is on a ThinkPad 600X with a kernel compiled
>with egcs-2.91.66.  The last kernel that worked correctly for me was
>2.4.10-pre4.  I skipped -pre5; -pre6 (with Anton's one-line patch applied to
>allow compiling with egcs-2.91.66) gives the same lockup as -pre7.

When does the lockup occur? When mounting? Later? What is the command that 
triggers it?

Could you edit fs/ntfs/Makefile and remove the hash in front of the -DDEBUG 
in the EXTRA_CFLAGS line? Then recompile, insert the module and as root issue:

echo -1 > /proc/sys/fs/ntfs-debug

This will activate extensive logging in NTFS. If you now can reproduce the 
hang and send me the syslog output (which hopefully will be captured) I 
should be able to figgure out where and why it crashes.

Thanks in advance,

         Anton


-- 
   "Nothing succeeds like success." - Alexandre Dumas
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

