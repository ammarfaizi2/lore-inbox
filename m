Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314025AbSDZNMm>; Fri, 26 Apr 2002 09:12:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313996AbSDZNMl>; Fri, 26 Apr 2002 09:12:41 -0400
Received: from web12504.mail.yahoo.com ([216.136.173.196]:262 "HELO
	web12504.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S314025AbSDZNMk>; Fri, 26 Apr 2002 09:12:40 -0400
Message-ID: <20020426131240.11007.qmail@web12504.mail.yahoo.com>
Date: Fri, 26 Apr 2002 06:12:40 -0700 (PDT)
From: sanjay kumar <sanjay_ara_in@yahoo.com>
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Any file system like ext2, JFS etc are aware about the
meta-data of filesystem and file-data, when it writes
some file-blocks on disk. I want to know whether it is
possible to differentiate between meta-data and
file-data in block device layer (I mean without using
file-system specific functions). In other words,
whether it is possible to know that the given buffer
(of buffer cache), contains the meta-data/file-data.
Here meta-data means filesystem specific data like
superblock, group descriptor, bitmap blocks (if file
system supports), blocks containing inode and extent
information, information about directories and files,
blocks containing indirect pointers for any file
(applicable in indirect addressing in ext2), etc.

Is it true that all file systems (if not all, then
mostly), use block_read_full_page() and
block_write_full_page() to read/write the file-data ?
And these functions are not used for reading/writing
the meta-data.

-Sanjay Kumar 

PS - I am not the member of this group, so please CC
me, when you are replying.


__________________________________________________
Do You Yahoo!?
Yahoo! Games - play chess, backgammon, pool and more
http://games.yahoo.com/
