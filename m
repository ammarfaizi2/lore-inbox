Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317222AbSEXShu>; Fri, 24 May 2002 14:37:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317243AbSEXSht>; Fri, 24 May 2002 14:37:49 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:39631 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S317222AbSEXShs>;
	Fri, 24 May 2002 14:37:48 -0400
Subject: [ANNOUNCE]  Journaled File System (JFS)  release 1.0.18
To: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
Message-ID: <OFD7E93986.34A72BB5-ON85256BC3.00661BF9@pok.ibm.com>
From: "Steve Best" <sbest@us.ibm.com>
Date: Fri, 24 May 2002 13:37:36 -0500
X-MIMETrack: Serialize by Router on D01ML072/01/M/IBM(Release 5.0.10 |March 28, 2002) at
 05/24/2002 02:37:40 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Release 1.0.18 of JFS was made available today.

Drop 56 on May 24, 2002 (jfs-2.4-1.0.18.tar.gz
and jfsutils-1.0.18.tar.gz) includes fixes to the file
system and utilities.

The new feature in this release is the capability to have the
log on and external device. The -j journal device option in
mkfs.jfs allows you to specify the external log device. The
utilities now require libuuid and this is packaged with
e2fsprogs-devel that ships with most distros.

Utilities changes

- add support for external log
- endian code cleanup
- fix typo in fsck.jfs help
- fix fsck.jfs bug on big endian machines

File System changes

- File truncate was not always enough space from the block map.
- Bring 2.4 code in line with 2.5 and various cleanups (Christoph Hellwig)
- JFS metapage changes (Christoph Hellwig)
   use the bdev mapping instead of JFS-private device mapping/inode
   add metapages to -> mp_list of the inode passed to __get_metpage
- Reduce number of return paths in dbAlloc to two. This is in preparation
  for quota support. (Christoph Hellwig)
- External journal support
    Add uuid to file system and journal
- Add additional debug code to help debug mysterious uncommitted anonymous
  txns
- Add xtAppend
- Add lmLogFromat which is used to format the file system log
- Add extern for diExtendFS
- Increase number of transaction locks in JFS txnmgr
- Make license boilerplate uniform, update copyright dates
- No need to handle regular files in jfs_mknod (Christoph Hellwig)
- Remove register keyword (Christoph Hellwig)
- Simplify sync_metapage (Christoph Hellwig)

For more details about JFS, please see the patch instructions or
changelog.jfs
files.


Steve Best
Linux Technology Center
JFS for Linux http://oss.software.ibm.com/jfs






