Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261316AbSJIH3B>; Wed, 9 Oct 2002 03:29:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261360AbSJIH3B>; Wed, 9 Oct 2002 03:29:01 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:33030 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S261316AbSJIH3A>; Wed, 9 Oct 2002 03:29:00 -0400
Message-ID: <3DA3DC25.F383E92D@aitel.hist.no>
Date: Wed, 09 Oct 2002 09:35:01 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.40mm1 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: Brad Chapman <jabiru_croc@yahoo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [QUESTION] Is 2.5.41 useable?
References: <20021008105729.79814.qmail@web40019.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brad Chapman wrote:
> 
> Sir,
> 
> --- jbradford@dial.pipex.com wrote:
> > > Is 2.5.41 useable, i.e. will it mostly work without Oopsing or crashing?
> >
> > It is way too soon for anybody to be able to say - it's only been released
> > for a day!
> 
> Hmmm. Perhaps I should have asked the question, "Does 2.5.41 contain any code
> that would be likely to impact performance or stability?"

Depends on what you use.  Much of 2.5.41 is great, but RAID is
broken in several ways:

1. raid-0 simply doesn't work.  There is an excellent patch 
   fixing it, but it isn't in 2.5.41.
2. raid-1 kills the kernel after a minute or so 
   if it need to resync a array big enough to take that much 
   time with my 20MB/s disks.
   If you need a "big" resync, reboot to something safe like 2.5.7
   or earlier.
3. raid-1 on the root is always dirty needing a resync after shutdown,
   so a root-raid1 had better be "small".  Or you can't boot it.

This should not bother you if you don't use software raid.

The nfs client have some trouble too, see the thread called
"invalidate_inode_pages".  I were unable to reproduce
my problems on 2.5.41 so perhaps it is fixed and I
missed the announcement.

Again, nothing to worry about if you don't use a nfs client.

2.5.41 seems just fine otherwise for my uses.

Helge Hafting
