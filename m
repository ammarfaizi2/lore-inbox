Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261862AbTJRSQm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 14:16:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261863AbTJRSQm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 14:16:42 -0400
Received: from deepthot.org ([68.14.232.127]:23216 "EHLO dent.deepthot.org")
	by vger.kernel.org with ESMTP id S261862AbTJRSQk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 14:16:40 -0400
From: Jay Denebeim <denebeim@deepthot.org>
X-Newsgroups: dt.kernel
Subject: Re: Problems with Maxtor 120 GB drive
Date: Sat, 18 Oct 2003 17:28:27 +0000 (UTC)
Organization: Deep Thought
Message-ID: <slrnbp2u1r.38d.denebeim@hotblack.deepthot.org>
References: <slrnbohfu7.1mb.denebeim@hotblack.deepthot.org> <slrnbol9rf.1uu.denebeim@hotblack.deepthot.org> <slrnboph07.2kt.denebeim@hotblack.deepthot.org>
X-Complaints-To: news@deepthot.org
User-Agent: slrn/0.9.7.4 (Linux)
To: linuxkernel@deepthot.org
X-SA-Exim-Mail-From: news@deepthot.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi it's me again,

I'm still having problems with my Maxtor drive.  Again, my
configuration is as follows: 

1) motherboard: ECS K7S5A Pro latest firmware from their website
2) distribution: Redhat 9 (Tom's rtbt does the same thing)
3) kernel: 2.4.20
4) Harddrive Maxtor 120GB MXTL01P120

Note, there's also a western digital 20gig in the system that exibits
the same problems.

Problem:
Disk druid and fdisk only own up to there being 8 gig on the drives.
There seems to be no way to force it to other values.

I've tried:

1) turning the knobs in the bios.
2) saying 'lba32' to the kernel during boot.  (I've since found out
   that this is not a switch to the kernel, it's to lilo)
3) Switching the master/slavedness of the drives.
4) Trying 1 and 2 with each drive separately.

It should be noted that before I changed out the motherboard the 20gig
drive worked fine.  We had a power hit which is what started all
this.  Since then we've replaced the CPU, memory, motherboard, and
finally one of the hard drives which has put us in this state.

New things I've discovered.

1) Windows XP has no problem with this system.
2) the information in /proc/ide/hd? is incorrect
3) hdparm -I gives the correct data

I really, really need help.  For instance, where does the data in
/proc/ide/hd? come from?  What code derives it?  Is there any way to
force good values into it?

My theory is that this data is coming from the CMOS somewhere.  I was
talking with a maxtor engineer about this and he mentioned something
about this, but when I tried to pin him down to something I could
actually investigate he couldn't help me.  That seems to mean if I get
another motherboard I could make this problem go away.  Only problem
is this is the only SDRAM motherboard Fry's carries, so I'll have to
buy new ram as well.  (since it's all brand new I'm hesitant to just
pitch this stuff, unfortunately we can't find the receipt for the mobo
so I've alreaday poured that $60 down the drain)

Anyway, if anyone has any ideas I'd greatly appreciate a hand.

Jay

-- 
* Jay Denebeim  Moderator       rec.arts.sf.tv.babylon5.moderated *
* newsgroup submission address: b5mod@deepthot.org                *
* moderator contact address:    b5mod-request@deepthot.org        *
* personal contact address:     denebeim@deepthot.org             *
