Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268751AbTBZNoe>; Wed, 26 Feb 2003 08:44:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268750AbTBZNob>; Wed, 26 Feb 2003 08:44:31 -0500
Received: from elixir.e.kth.se ([130.237.48.5]:46859 "EHLO elixir.e.kth.se")
	by vger.kernel.org with ESMTP id <S268749AbTBZNo3>;
	Wed, 26 Feb 2003 08:44:29 -0500
To: Olaf Dietsche <olaf.dietsche@t-online.de>
Cc: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=),
       miquels@cistron-office.nl (Miquel van Smoorenburg),
       linux-kernel@vger.kernel.org
Subject: Re: About /etc/mtab and /proc/mounts
References: <20030219112111.GD130@DervishD> <3E5C8682.F5929A04@daimi.au.dk>
	<b3i4nv$sud$1@news.cistron.nl> <87u1er71d0.fsf@goat.bogus.local>
	<yw1xwujn2t0v.fsf@manganonaujakasit.e.kth.se>
	<87el5v6xvj.fsf@goat.bogus.local>
	<yw1xn0kjdxv4.fsf@manganonaujakasit.e.kth.se>
	<8765r76u0c.fsf@goat.bogus.local>
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Date: 26 Feb 2003 14:54:23 +0100
In-Reply-To: Olaf Dietsche's message of "Wed, 26 Feb 2003 14:39:31 +0100"
Message-ID: <yw1xlm03uoz4.fsf@manganonaujakasit.e.kth.se>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Channel Islands)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olaf Dietsche <olaf.dietsche@t-online.de> writes:

> >> The 'user' option is in /etc/fstab, so this is not a problem. I can
> >> mount _and_ umount /cdrom as a simple user.
> >
> > It's strange if you can.  My mount (fairly recent) looks in fstab to
> > determine whether a user should be allowed to mount a device.
> > However, when unmounting it checks /etc/mtab to make sure it was you
> > who mounted it in the first place, making it impossible to unmount
> > someone else's cdrom.  If you use the 'users' (note the 's') option
> > instead any user can mount or unmount the device at any time, mtab
> > being ignored.
> 
> I just verified it. I and anybody else can mount and umount /cdrom. If
> I mounted /cdrom, someone else can umount it.
> 
> $ mount -V
> mount: mount-2.11n
> 
> $ grep user /etc/fstab
> /dev/hdb/0 /cdrom iso9660 defaults,ro,unhide,user,noauto,noexec,nosuid 0 2
> 
> $ ls -l /etc/mtab 
> lrwxrwxrwx    1 root     root           12 2002-09-22 02:58 /etc/mtab -> /proc/mounts
> 
> When /etc/mtab is a regular file, it works as you described.

What does your /proc/mounts look like when the cdrom is mounted?  Are
you using a standard mount, or something hacked up by RH or others?

-- 
Måns Rullgård
mru@users.sf.net
