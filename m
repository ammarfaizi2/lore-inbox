Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264276AbTEPF34 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 01:29:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264124AbTEPF34
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 01:29:56 -0400
Received: from webhaste.com ([64.62.134.242]:51983 "HELO vortex.webhaste.com")
	by vger.kernel.org with SMTP id S264276AbTEPF3x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 01:29:53 -0400
Message-ID: <23493.65.122.196.250.1053063209.squirrel@mail.webhaste.com>
Date: Thu, 15 May 2003 22:33:29 -0700 (PDT)
Subject: FAT32 problems with kernel 2.4.19
From: <esp@pyroshells.com>
To: <linux-kernel@vger.kernel.org>
X-Priority: 3
Importance: Normal
X-Mailer: SquirrelMail (version 1.2.9)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(I'm forwarding this from comp.os.linux.help - I'm having the same issue
with FAT32)

hey all,

I have a removable, USB disk (ikebana) that I'm trying to use as a
portable storage device (ie: developing programs for Win32, macosx and linux
simultaneously)

Anyways, everything is sort of working except for execute privileges
on linux (win32 works, macosx works). When I try to execute something, I get:

bash-: ./a.out: Permission Denied

When I try to execute a shell script (even as root), I get:

-bash: ./aa.sh: /bin/bash: bad interpreter: Permission denied

Now, I understand that FAT32 has no execute bit.. however I explicitly set
(or an automatic process on SuSe linux set the fstab entry for the drive
to be:

/dev/sda1            /windows/D           vfat
users,gid=users,umask=0002,iocharset=iso8859-1,code=437 0 0

which as I understand it sets the permissions to be 775.

Argh! so I would expect this to work transparently.

So... is there a bug in the kernel, default settings, is something
missing in the above entries, or what? I'll escalate this to
linux-devel if it looks like there is nothing wrong with the above..

forgot to mention -

When I'm writing to FAT32 partition, there seems to be a 300% incurred
size penalty over the equivalent files on ext2 (when unpacking a
source distribution like boost, gcc, etc)

Is this an artifact of the FAT32 file system, a bug in the linux IO to
the FAT32 file system, or a local bug in my system?

I'd like to get this resolved, but understand if its a microsoft
issue...
however it would be really, really nice if NTFS was supported (ie: if
linux could write files on NTFS..) I have a sneaky suspicion that
FAT32 isn't the greatest and only used on these drives because it is
the lowest common denominator.

jon


