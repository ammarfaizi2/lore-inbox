Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283782AbRK3UQm>; Fri, 30 Nov 2001 15:16:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283776AbRK3UQd>; Fri, 30 Nov 2001 15:16:33 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:8975 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S283780AbRK3UQR>; Fri, 30 Nov 2001 15:16:17 -0500
Message-ID: <3C07E905.DF30E497@zip.com.au>
Date: Fri, 30 Nov 2001 12:16:05 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Steffen Persvold <sp@scali.no>
CC: lkml <linux-kernel@vger.kernel.org>, nfs list <nfs@lists.sourceforge.net>,
        ext2-devel@lists.sourceforge.net
Subject: Re: 2.4.9 kernel crash
In-Reply-To: <3C077FF8.AFBD8DB8@scali.no>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steffen Persvold wrote:
> 
> Hi all,
> 
> This just happened to my RedHat 7.2 box running the 2.4.9-13 update kernel from RedHat. The box is
> running as a NFS server, exporting two ext3 volumes (one 36GB and one 73GB) :
> 
> VFS: Busy inodes after unmount. Self-destruct in 5 seconds.  Have a nice day...

There was a bug in ext3 which was fixed around about the 2.4.9
timeframe.  I don't know if the fix is present in that
particular Red Hat kernel.  It was fixed in ext3 0.9.8.  The
ext3 version number is displayed when you mount a filesystem.

The 0.9.8 changelog says:

- Fix an NFS oops when doing a local delete on an active, nfs-exported
  file.

I never observed this bug - I think the fix came from Ted T'so.  I
do not know whether the bug manifested itself as "busy inodes
after unmount".  Perhaps Ted or Stephen can comment?
