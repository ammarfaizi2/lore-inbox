Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263188AbSKYNOs>; Mon, 25 Nov 2002 08:14:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263276AbSKYNOs>; Mon, 25 Nov 2002 08:14:48 -0500
Received: from jrt.me.vt.edu ([128.173.188.212]:10884 "HELO jrt.me.vt.edu")
	by vger.kernel.org with SMTP id <S263188AbSKYNOr>;
	Mon, 25 Nov 2002 08:14:47 -0500
Date: Mon, 25 Nov 2002 09:21:26 -0500 (EST)
From: Clemmitt Sigler <siglercm@jrt.me.vt.edu>
To: Hugo Mills <hugo-lkml@carfax.org.uk>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>, Ted Tso <tytso@think.thunk.org>,
       Alan Cox <Alan.Cox@linux.org>
Subject: Re: 2.4.20-rc3 ext3 fsck corruption -- tool update warning needed?
In-Reply-To: <20021125105739.GA7531@carfax.org.uk>
Message-ID: <Pine.LNX.4.33L2.0211250908190.2368-100000@jrt.me.vt.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hugo et al,

On Mon, 25 Nov 2002, Hugo Mills wrote:
>    Did you also get some duplicated entries in /etc? I've had a
> similar problem, with some files in /etc vanishing entirely, and
> others being duplicated (so I got, for example, /etc/fstab appearing
> twice in `ls /etc`).

Unfortunately, I didn't check thoroughly to see if duplicate files were
listed by ls.  I wish I had known to look!  This is my production
workstation.  It needed to get back up and running, so I didn't save
the "evidence." :^(

> This has happened, as far as I can tell, spontaneously
>    Running fsck recovers the missing files into lost+found, but
> doesn't remove the duplicated filenames.

My problem was clearly related to fsck.ext3 which ran automatically upon
a reboot.  Before that, no problems whatsoever.  After the boot-time
fsck was over, the system failed to finish coming up.  The boot output
contained the surprising error "Can't find /etc/fstab" and complained
about the rc script being missing (entire /etc/rc2.d dir was gone).

>    I remember seeing a comment about HTREE running past when I tried
> the e2fsck for the first time. Don't know if this is relevant.

Neither do I (not enough in-depth knowledge to know), but that info may
be of use to Ted and Marcelo(?)  If my conclusions about 2.4.20-rc3 and
some e2fsprogs tools being incompatable are erroneous, my apologies.

					Clemmitt Sigler

