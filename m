Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268729AbTBZMYX>; Wed, 26 Feb 2003 07:24:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268730AbTBZMYX>; Wed, 26 Feb 2003 07:24:23 -0500
Received: from elixir.e.kth.se ([130.237.48.5]:63246 "EHLO elixir.e.kth.se")
	by vger.kernel.org with ESMTP id <S268729AbTBZMYW>;
	Wed, 26 Feb 2003 07:24:22 -0500
To: Olaf Dietsche <olaf.dietsche@t-online.de>
Cc: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=),
       miquels@cistron-office.nl (Miquel van Smoorenburg),
       linux-kernel@vger.kernel.org
Subject: Re: About /etc/mtab and /proc/mounts
References: <20030219112111.GD130@DervishD> <3E5C8682.F5929A04@daimi.au.dk>
	<b3i4nv$sud$1@news.cistron.nl> <87u1er71d0.fsf@goat.bogus.local>
	<yw1xwujn2t0v.fsf@manganonaujakasit.e.kth.se>
	<87el5v6xvj.fsf@goat.bogus.local>
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Date: 26 Feb 2003 13:34:23 +0100
In-Reply-To: Olaf Dietsche's message of "Wed, 26 Feb 2003 13:16:00 +0100"
Message-ID: <yw1xn0kjdxv4.fsf@manganonaujakasit.e.kth.se>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Channel Islands)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olaf Dietsche <olaf.dietsche@t-online.de> writes:

> >> I thought, this is what /var is for. So, /var/run, /var/lib/misc or
> >> /var/etc might be more appropriate?
> >
> > What if /var is mounted separately?
> 
> I didn't think of this, even though I have it separately on my
> machine.
> 
> >> OTOH, "ln -s /proc/mounts /etc/mtab" works just fine here.
> >
> > The only problem I have with that is that option 'user' is lost.  This
> > means that any user can mount /cdrom, but only root can unmount it.
> 
> The 'user' option is in /etc/fstab, so this is not a problem. I can
> mount _and_ umount /cdrom as a simple user.

It's strange if you can.  My mount (fairly recent) looks in fstab to
determine whether a user should be allowed to mount a device.
However, when unmounting it checks /etc/mtab to make sure it was you
who mounted it in the first place, making it impossible to unmount
someone else's cdrom.  If you use the 'users' (note the 's') option
instead any user can mount or unmount the device at any time, mtab
being ignored.

-- 
Måns Rullgård
mru@users.sf.net
