Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268674AbTBZN3x>; Wed, 26 Feb 2003 08:29:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268743AbTBZN3x>; Wed, 26 Feb 2003 08:29:53 -0500
Received: from mailout09.sul.t-online.com ([194.25.134.84]:65254 "EHLO
	mailout09.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S268674AbTBZN3w> convert rfc822-to-8bit; Wed, 26 Feb 2003 08:29:52 -0500
Cc: miquels@cistron-office.nl (Miquel van Smoorenburg),
       linux-kernel@vger.kernel.org
References: <20030219112111.GD130@DervishD> <3E5C8682.F5929A04@daimi.au.dk>
	<b3i4nv$sud$1@news.cistron.nl> <87u1er71d0.fsf@goat.bogus.local>
	<yw1xwujn2t0v.fsf@manganonaujakasit.e.kth.se>
	<87el5v6xvj.fsf@goat.bogus.local>
	<yw1xn0kjdxv4.fsf@manganonaujakasit.e.kth.se>
From: Olaf Dietsche <olaf.dietsche@t-online.de>
To: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: About /etc/mtab and /proc/mounts
Date: Wed, 26 Feb 2003 14:39:31 +0100
In-Reply-To: <yw1xn0kjdxv4.fsf@manganonaujakasit.e.kth.se> (mru@users.sourceforge.net's
 message of "26 Feb 2003 13:34:23 +0100")
Message-ID: <8765r76u0c.fsf@goat.bogus.local>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Military
 Intelligence, i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mru@users.sourceforge.net (Måns Rullgård) writes:

> Olaf Dietsche <olaf.dietsche@t-online.de> writes:
>
>> The 'user' option is in /etc/fstab, so this is not a problem. I can
>> mount _and_ umount /cdrom as a simple user.
>
> It's strange if you can.  My mount (fairly recent) looks in fstab to
> determine whether a user should be allowed to mount a device.
> However, when unmounting it checks /etc/mtab to make sure it was you
> who mounted it in the first place, making it impossible to unmount
> someone else's cdrom.  If you use the 'users' (note the 's') option
> instead any user can mount or unmount the device at any time, mtab
> being ignored.

I just verified it. I and anybody else can mount and umount /cdrom. If
I mounted /cdrom, someone else can umount it.

$ mount -V
mount: mount-2.11n

$ grep user /etc/fstab
/dev/hdb/0 /cdrom iso9660 defaults,ro,unhide,user,noauto,noexec,nosuid 0 2

$ ls -l /etc/mtab 
lrwxrwxrwx    1 root     root           12 2002-09-22 02:58 /etc/mtab -> /proc/mounts

When /etc/mtab is a regular file, it works as you described.

Regards, Olaf.
