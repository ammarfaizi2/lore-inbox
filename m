Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268709AbTBZKuo>; Wed, 26 Feb 2003 05:50:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268711AbTBZKuo>; Wed, 26 Feb 2003 05:50:44 -0500
Received: from mailout07.sul.t-online.com ([194.25.134.83]:63142 "EHLO
	mailout07.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S268709AbTBZKun>; Wed, 26 Feb 2003 05:50:43 -0500
Cc: linux-kernel@vger.kernel.org
References: <20030219112111.GD130@DervishD> <3E5C8682.F5929A04@daimi.au.dk>
	<b3i4nv$sud$1@news.cistron.nl>
From: Olaf Dietsche <olaf.dietsche@t-online.de>
To: miquels@cistron-office.nl (Miquel van Smoorenburg)
Subject: Re: About /etc/mtab and /proc/mounts
Date: Wed, 26 Feb 2003 12:00:43 +0100
In-Reply-To: <b3i4nv$sud$1@news.cistron.nl> (miquels@cistron-office.nl's
 message of "Wed, 26 Feb 2003 10:26:07 +0000 (UTC)")
Message-ID: <87u1er71d0.fsf@goat.bogus.local>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Military
 Intelligence, i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

miquels@cistron-office.nl (Miquel van Smoorenburg) writes:

> In article <3E5C8682.F5929A04@daimi.au.dk>,
> Kasper Dupont  <kasperd@daimi.au.dk> wrote:
>>A simpler solution, that does not require changes to the kernel
>>would be to just move mtab to a more apropriate location. My
>>suggestion would be to change it from /etc/mtab to /mtab.d/mtab.
>>Then you could mount a tmpfs filesystem on /mtab.d. Or by making
>>/mtab.d a symlink, you can get the mtab file whereever you want,
>>including /etc.
>
> /dev/shm ? Supposed to be there on many systems anyway. Fix
> 'mount' and 'umount' so that if they see /etc/mtab is a symlink,
> they follow it and create the temp files etc in the destination
> directory of the link instead of in /etc. Then
> ln -sf /dev/shm/mtab /etc/mtab et voila

I thought, this is what /var is for. So, /var/run, /var/lib/misc or
/var/etc might be more appropriate?

OTOH, "ln -s /proc/mounts /etc/mtab" works just fine here.

Regards, Olaf.
