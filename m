Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263785AbSJJUNo>; Thu, 10 Oct 2002 16:13:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263657AbSJJULz>; Thu, 10 Oct 2002 16:11:55 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:44764 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S262209AbSJJUDX>;
	Thu, 10 Oct 2002 16:03:23 -0400
Importance: Normal
Sensitivity: 
Subject: [BK PATCH] CIFS filesystem for Linux 2.5
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Cc: jra@samba.org
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OFFB04937F.1EAC8996-ON87256C4E.006DA4CF@boulder.ibm.com>
From: "Steven French" <sfrench@us.ibm.com>
Date: Thu, 10 Oct 2002 15:08:53 -0500
X-MIMETrack: Serialize by Router on D03NM123/03/M/IBM(Release 5.0.10 |March 22, 2002) at
 10/10/2002 02:08:56 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The CIFS filesystem has been updated to handle yesterday's changes to the
superblock structure and has been added to a new bitkeeper repository as a
single bitkeeper changset in order to be easier to apply.  It is changeset
number 1.747 at bk://cifs.bkbits.net/linux-2.5-with-cifs  and is low risk,
not changing core kernel files.

 Documentation/filesystems/00-INDEX |    2
 Documentation/filesystems/cifs.txt |   26
 fs/Config.help                     |   27
 fs/Config.in                       |    2
 fs/Makefile                        |    1
 fs/cifs/AUTHORS                    |   16
 fs/cifs/CHANGES                    |  142 ++
 fs/cifs/Makefile                   |    8
 fs/cifs/README                     |   94 +
 fs/cifs/TODO                       |   55
 fs/cifs/asn1.c                     |  615 ++++++++++
 fs/cifs/cifs_debug.c               |  546 ++++++++
 fs/cifs/cifs_debug.h               |   74 +
 fs/cifs/cifs_fs_sb.h               |   27
 fs/cifs/cifs_unicode.c             |  136 ++
 fs/cifs/cifs_unicode.h             |  368 ++++++
 fs/cifs/cifs_uniupr.h              |  253 ++++
 fs/cifs/cifsfs.c                   |  433 +++++++
 fs/cifs/cifsfs.h                   |   90 +
 fs/cifs/cifsglob.h                 |  333 +++++
 fs/cifs/cifspdu.h                  | 1527 +++++++++++++++++++++++++
 fs/cifs/cifsproto.h                |  251 ++++
 fs/cifs/cifssmb.c                  | 2155 +++++++++++++++++++++++++++++++++++
 fs/cifs/connect.c                  | 2252 +++++++++++++++++++++++++++++++++++++
 fs/cifs/dir.c                      |  303 ++++
 fs/cifs/file.c                     | 1027 ++++++++++++++++
 fs/cifs/inode.c                    |  691 +++++++++++
 fs/cifs/link.c                     |  219 +++
 fs/cifs/md4.c                      |  209 +++
 fs/cifs/md5.c                      |  363 +++++
 fs/cifs/md5.h                      |   38
 fs/cifs/misc.c                     |  362 +++++
 fs/cifs/netmisc.c                  |  879 ++++++++++++++
 fs/cifs/nterr.c                    |  712 +++++++++++
 fs/cifs/nterr.h                    |  547 ++++++++
 fs/cifs/ntlmssp.h                  |   96 +
 fs/cifs/smbdes.c                   |  416 ++++++
 fs/cifs/smbencrypt.c               |  454 +++++++
 fs/cifs/smberr.h                   |  112 +
 fs/cifs/transport.c                |  245 ++++
 fs/nls/Config.in                   |    2
 41 files changed, 16107 insertions(+), 1 deletion(-)

The CIFS file system is ready to be included in the 2.5 Linux kernel and
only affects the usual small set of files outside its own directory
(fs/cifs) that a filesystem must change (e.g. fs/Config.in, fs/Makefile,
fs/Config.help) but does not require changes to any core kernel code.

The filesystem is designed for remote access to Samba, newer Windows
servers and also the many common CIFS based NAS appliances, but unlike
smbfs is optimized for the current version of the SMB/CIFS protocol.   The
CIFS file system can coexist with smbfs.   The CIFS file system is
reasonably stable, passing most but not all of the standard filesystem test
suites going to either Windows servers or Samba (NB a few Samba bug which I
am working is blocking fsx at the moment and memory mapping support is not
finished) running with the current 2.5 kernel.  It has been tested at both
Connectathon and the CIFS Plugfest this year and has been under development
for over a year with the assistance from some others on the Samba team as
well as feedback from the standards group (SNIA CIFS Technical Workgroup)
and others at IBM.    The project web site has more information on the
project http://us1.samba.org/samba/Linux_CIFS_client.html


Steve French
Senior Software Engineer
Linux Technology Center - IBM Austin
phone: 512-838-2294
email: sfrench@us.ibm.com


