Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129510AbRBWWid>; Fri, 23 Feb 2001 17:38:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129822AbRBWWiY>; Fri, 23 Feb 2001 17:38:24 -0500
Received: from m154-mp1-cvx1a.col.ntl.com ([213.104.68.154]:32260 "EHLO
	[213.104.68.154]") by vger.kernel.org with ESMTP id <S129653AbRBWWiL>;
	Fri, 23 Feb 2001 17:38:11 -0500
To: bradley mclain <bradley_kernel@yahoo.com>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: APM suspend system lockup under 2.4.2 and 2.4.2ac1
In-Reply-To: <20010223031521.93782.qmail@web9205.mail.yahoo.com>
From: John Fremlin <chief@bandits.org>
Date: 23 Feb 2001 22:37:36 +0000
In-Reply-To: bradley mclain's message of "Thu, 22 Feb 2001 19:15:21 -0800 (PST)"
Message-ID: <m2snl53u1b.fsf@boreas.yi.org.>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (GTK)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Unfortunately, the APM maintainer, Stephen Rothwell, seems to have
gone into hibernation (pun) and is not responding to emails.

bradley mclain <bradley_kernel@yahoo.com> writes:

> apm --suspend causes my system to hang under 2.4.2 and 2.4.2ac1.  it
> was working fine under 2.4.1ac19. looking at syslog it appears that
> the driver for my xircom pcmcia card may be involved -- it was the
> last entry on two of three occasions.  the latest lockup (under
> 2.4.1ac1) left no trace in syslog.

Are all kernel messages dumped to syslog? See syslog.conf(5).

> upon issuing the command the screen shuts down, but the rest of the
> machine (drive, etc.) fails to, and i cannot get control back.

If the screen shutdown, all the PM enabled drivers OK'd the suspend
and the APM state was changed.

Perhaps the particular driver you used bungled things somehow. You
could try again with the driver/card unloaded, which would help narrow
the cause of the problem down.

[...]

-- 

	http://www.penguinpowered.com/~vii
