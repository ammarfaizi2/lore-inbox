Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267252AbTA0SFf>; Mon, 27 Jan 2003 13:05:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267254AbTA0SFf>; Mon, 27 Jan 2003 13:05:35 -0500
Received: from paloma12.e0k.nbg-hannover.de ([62.181.130.12]:16862 "HELO
	paloma12.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S267252AbTA0SFd> convert rfc822-to-8bit; Mon, 27 Jan 2003 13:05:33 -0500
From: Dieter =?iso-8859-15?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Chris Mason <mason@suse.com>
Subject: Re: [PATCH] data logging patches available for 2.4.21-preX
Date: Mon, 27 Jan 2003 19:14:26 +0100
User-Agent: KMail/1.5
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>,
       Manuel Krause <manuel.krause@mb.tu-ilmenau.de>,
       "J.A. Magallon" <jamagallon@able.es>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200301271914.26312.Dieter.Nuetzel@hamburg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Mason wrote:
> Hello all,
>
> I've updated the data logging patches to 2.4.21-pre3, once the suse
> mirror is done updating, you can download them from:
>
> ftp.suse.com/pub/people/mason/patches/data-logging/2.4.21
>
> Changes:
>
> mount -o remount can switch between data modes.
>
> transaction overflow bug fix (BUG in journal_mark_dirty)
>
> fix for -ENOSPC hang when the block size < page size (ia64, alpha)
>
> integration with akpm's b_journal_head code from -ac.  Should make it
> possible for these patches to work both on vanilla kernels and Alan's
> branch.  I haven't tried this yet though, so testers would be
> appreciated.
>
> commit_super is now sync_fs
>
> I had to rework some of the data=ordered buffer handling code to merge
> with the changes in 2.4.21-preX, so use some caution with this code.

Hello Chris,

as always very nice work!
I have it now running fine on top of 2.4.21-pre3-jam3 (2.4.21-pre3aa1).
Some fiddling was necessary but went smooth after all.
My /home partition is mounted with -o data=ordered and the performance is 
great. Sorry, no real benchmarks, yet.

But some question stay open:
Where is 01-akpm-sync_fs-fix-2.diff and 01-iput-deadlock-fix.diff?
Isn't it needed anylonger 'cause you merged them and SuSE's ftp isn't updated 
yet? All files are the "old" one's from 15. January.
ftp://ftp.suse.com/pub/people/mason/patches/data-logging/2.4.21

What about patch-2.4.20.rfs.06.05-transaction-overflow-fix-0.diff?
Should I put it on top, too?

Thanks,
	Dieter

-- 
Dieter Nützel
Graduate Student, Computer Science

University of Hamburg
Department of Computer Science
@home: Dieter.Nuetzel at hamburg.de (replace at with @)
