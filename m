Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279715AbRKAUR6>; Thu, 1 Nov 2001 15:17:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279708AbRKAURs>; Thu, 1 Nov 2001 15:17:48 -0500
Received: from mustard.heime.net ([194.234.65.222]:29348 "EHLO
	mustard.heime.net") by vger.kernel.org with ESMTP
	id <S279700AbRKAURf>; Thu, 1 Nov 2001 15:17:35 -0500
Message-Id: <200111012017.VAA02942@mustard.heime.net>
Date: Thu, 01 Nov 2001 20:17:24 +0000
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Reply-To: roy@karlsbakk.net
To: adilger@turbolabs.com
Cc: reiser@namesys.com, linux-kernel@vger.kernel.org
X-Mailer: phpGroupWare (http://www.phpgroupware.org)
Subject: Re: writing a plugin for reiserfs compression
MIME-version: 1.0
Content-type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger (adilger@turbolabs.com) wrote*: 
>
>On Nov 01, 2001  18:14 +0100, Roy Sigurd Karlsbakk wrote:
>> Novell NetWare has a feature I really like. It's a file compression
>> feature they've been having since version 4.0 (or 4.10) of the OS.
>
>Yes, there is a patch for ext2 that does this as well.

ok...

I just thought there was a patch doing windows nt-like 
compress-em-all-realtime-and-get-doomed!

>> New attributes must be added somehow. 'ls' and 'find' and perhaps other
>> files must be modified to take advantage of this. The compression job can
>> be a simple script with something like
>>
>>  find . -type f ! --compressed ! --dont-compress / -exec fcomp {} \;
>>
>> (and check can't compress and force compression).

There already exists a patch for reiserfs which uses the same interface
to file attributes that ext2 and ext3 use.

ok? with batched compression?

>Also, ext2 already has a "compressed", "do not compress", and "dirty"
>attributes.  They are currently not all user modifyable for ext2
>filesystems via chattr/lsattr, but that doesn't mean they cannot be
>on reiserfs.
>
>> There must be a way to access the compressed files directly to make
>> backups more efficient - backing up already compressed files's a good
>> thing.
>
>Yes, there is also such an attribute for "raw" access I think.
>
>Making the user-space interface and tools as compatible as possible is
>a good thing, IMHO, just like "ls", "cp", etc all work regardless of
>the underlying filesystem.

yes, but it's kinda nice to have some way of checking a file's attributes for a 
sysadmin...

>As a note to whoever at namesys created the reiserfs patch to add the
>"notail" flag (overloading the "nodump" flag).  I would much rather
>that a new "notail" flag be allocated for this.  I will contact Ted
>Ted Ts'o to get a flag assigned.  This will avoid any problems in the
>future, and may also be useful at some time for ext2.

Do you think the other flags I mentioned may be useful?

roy
