Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281301AbRKLHxe>; Mon, 12 Nov 2001 02:53:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281302AbRKLHxY>; Mon, 12 Nov 2001 02:53:24 -0500
Received: from femail30.sdc1.sfba.home.com ([24.254.60.20]:32435 "EHLO
	femail30.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S281301AbRKLHxF>; Mon, 12 Nov 2001 02:53:05 -0500
Message-ID: <3BEF7FD8.D9FFB716@home.com>
Date: Sun, 11 Nov 2001 23:52:56 -0800
From: Nicholas Miell <nmiell@home.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.13-ac4 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Linux ACL designe - why the POSIX draft?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With all the recent discussion about ACLs and Linux on
linux-kernel, I was wondering why the ACL implementations
for Linux are based off the withdrawn POSIX 1003.1e draft
17?

Is there any particular reason why this was chosen for
the basis for the Linux ACL system, besides the fact
that its what everybody else did? (It is a only a
withdrawn draft after all, there's no reason to actually
follow it...)

Wouldn't a more flexible solution, perhaps one based on 
the NFSv4 ACL design[1] be better?

Because the NFSv4 design is in effect a superset of the
POSIX 1003.1e draft functionality, all Unix filesystems
with ACLs could be easily supported by the Linux VFS, and
the task of implementing NFSv4, NTFS, and SMB would be
made easier[2] because of it.

Thanks, Nicholas



[1] Actually, it was the Windows NT/2000/XP design first...

[2] The VFS would still need some means of mapping the SIDs
used by SMB and NTFS and the UTF-8 strings used by NFSv4 to
usable uid_t's and gid_t's, but at least the ACLs would be
easy.
