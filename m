Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278436AbRJMW63>; Sat, 13 Oct 2001 18:58:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278449AbRJMW6T>; Sat, 13 Oct 2001 18:58:19 -0400
Received: from mail.sirinet.net ([198.203.196.92]:44560 "EHLO mail.sirinet.net")
	by vger.kernel.org with ESMTP id <S278442AbRJMW6A>;
	Sat, 13 Oct 2001 18:58:00 -0400
Subject: Re: Maximum size of ext2 files on ia32 is?
From: John J Tobin <ogre@sirinet.net>
To: L A Walsh <law@sgi.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3BC8AE84.48808982@sgi.com>
In-Reply-To: <3BC8AE84.48808982@sgi.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.15 (Preview Release)
Date: 13 Oct 2001 17:52:16 -0500
Message-Id: <1003013547.14180.1.camel@ogre>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2001-10-13 at 16:13, L A Walsh wrote:
> I was hesitantly and pleasantly surprised when I was copying across an
> unmounted 8G unmounted file partition via dump to an NFS partition.  Until
> August, regular backups splitted the dump image (used the "-M" flag to
> dump) to into 4 2G files.  My backup disk died so it took some time to
> replace it and just got around to doing so (I know, running w/out backups
> is like unprotected sex, but lets ignore that critique).  So I startup
> dump and it produced 1 9G file.  I was a bit concerned that NFS had
> a screwed up mapping of the local file, but the server confirmed the file
> size.  'du' confirmed it was 8.8G, I even unmounted, forced an fsck on it
> and remounted -- still 8.8G.  I was allocating special partitions to
> backup non-dump compatible partitions (win) to the server but find now they
> can be backed up into a single 8G+ file.  I notice some utils from my latest
> suse72 install (stat) don't know about it either:
> > du -sh *
> 14M     BOOT_101101.dump
> 8.8G    HOME_101201.dump.001
> ...
> > stat HOME_101201.dump.001
> HOME_101201.dump.001: Value too large for defined data typ
> 
> So, I have been a bit busy and distracted and all, but when did large 
> file support go in for the i386 arch and what is the new max files size?
> 
> Congratulations and great work for addressing that limitation!  
> 
> Linda

I had the same problem awhile back it it was attributed to using
outdated fileutils. I recommend getting new ones from www.gnu.org and
seeing if that fixes the problem. It fixed it when I had a similar
problem.

-- 
John Tobin
ogre@sirinet.net; AOL IM: ogre7929
http://ogre.rocky-road.net
http://ogre.rocky-road.net/cdr.shtml

