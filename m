Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262395AbSKYEGR>; Sun, 24 Nov 2002 23:06:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262414AbSKYEGR>; Sun, 24 Nov 2002 23:06:17 -0500
Received: from jrt.me.vt.edu ([128.173.188.212]:9860 "HELO jrt.me.vt.edu")
	by vger.kernel.org with SMTP id <S262395AbSKYEGQ>;
	Sun, 24 Nov 2002 23:06:16 -0500
Date: Mon, 25 Nov 2002 00:12:55 -0500 (EST)
From: Clemmitt Sigler <siglercm@jrt.me.vt.edu>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>, Ted Tso <tytso@think.thunk.org>,
       Alan Cox <Alan.Cox@linux.org>
Subject: 2.4.20-rc3 ext3 fsck corruption -- tool update warning needed?
Message-ID: <Pine.LNX.4.33L2.0211242351001.2368-100000@jrt.me.vt.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(I'm not subscribed to lkml, please CC: csigler@vt.edu -- Thanks :^)

Hi,

I'd been running 2.4.20-rc3 for two days.  While rebooting it tonight
fsck.ext3 corrupted my / partition during an automatic fsck of the
partition (caused by the maximal mount count being reached).  (I had
backups so I was able to recover :^)  The symptoms were that some files
like /etc/fstab and dirs like /etc/rc2.d disappeared -- not good.

My system is Debian Testing, with Debian e2fsprogs version
1.29+1.30-WIP-0930-1.  I use ext3 partitions with all options set to
the defaults (ordered data mode).  This is an SMP system, in case
that matters.  Please e-mail me for any other details that might help.

I'm wondering if this change between -rc1 and -rc2 might be a factor ->

   <tytso@think.thunk.org>
           HTREE backwards compatibility patch.

Upon rebooting to 2.4.19 (SMP kernel also), the system did another
auto-fsck.ext3, this time on /usr.  I held my breath, but all went fine.
This seems to me to narrow it down to a kernel/e2fsprogs incompatibility
(but I'm not an expert).

If this is indeed the case, please put a LOUD WARNING in the kernel
notes that some versions of e2fsprogs are incompatible.  HTH.

					Clemmitt Sigler

