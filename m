Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267364AbTBZLEM>; Wed, 26 Feb 2003 06:04:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268711AbTBZLEM>; Wed, 26 Feb 2003 06:04:12 -0500
Received: from elixir.e.kth.se ([130.237.48.5]:43268 "EHLO elixir.e.kth.se")
	by vger.kernel.org with ESMTP id <S267364AbTBZLEL>;
	Wed, 26 Feb 2003 06:04:11 -0500
To: Olaf Dietsche <olaf.dietsche@t-online.de>
Cc: miquels@cistron-office.nl (Miquel van Smoorenburg),
       linux-kernel@vger.kernel.org
Subject: Re: About /etc/mtab and /proc/mounts
References: <20030219112111.GD130@DervishD> <3E5C8682.F5929A04@daimi.au.dk>
	<b3i4nv$sud$1@news.cistron.nl> <87u1er71d0.fsf@goat.bogus.local>
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Date: 26 Feb 2003 12:14:24 +0100
In-Reply-To: Olaf Dietsche's message of "Wed, 26 Feb 2003 12:00:43 +0100"
Message-ID: <yw1xwujn2t0v.fsf@manganonaujakasit.e.kth.se>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Channel Islands)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olaf Dietsche <olaf.dietsche@t-online.de> writes:

> >>A simpler solution, that does not require changes to the kernel
> >>would be to just move mtab to a more apropriate location. My
> >>suggestion would be to change it from /etc/mtab to /mtab.d/mtab.
> >>Then you could mount a tmpfs filesystem on /mtab.d. Or by making
> >>/mtab.d a symlink, you can get the mtab file whereever you want,
> >>including /etc.
> >
> > /dev/shm ? Supposed to be there on many systems anyway. Fix
> > 'mount' and 'umount' so that if they see /etc/mtab is a symlink,
> > they follow it and create the temp files etc in the destination
> > directory of the link instead of in /etc. Then
> > ln -sf /dev/shm/mtab /etc/mtab et voila
> 
> I thought, this is what /var is for. So, /var/run, /var/lib/misc or
> /var/etc might be more appropriate?

What if /var is mounted separately?

> OTOH, "ln -s /proc/mounts /etc/mtab" works just fine here.

The only problem I have with that is that option 'user' is lost.  This
means that any user can mount /cdrom, but only root can unmount it.

-- 
Måns Rullgård
mru@users.sf.net
