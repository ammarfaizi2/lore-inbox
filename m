Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263789AbSJHUwM>; Tue, 8 Oct 2002 16:52:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263784AbSJHUwG>; Tue, 8 Oct 2002 16:52:06 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:44797 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S262690AbSJHUvV>;
	Tue, 8 Oct 2002 16:51:21 -0400
Importance: Normal
Sensitivity: 
Subject: CIFS remote file system client for Linux 2.5 ready
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OFF54E6E1F.C55312F0-ON87256C4C.006CDAC9@boulder.ibm.com>
From: "Steven French" <sfrench@us.ibm.com>
Date: Tue, 8 Oct 2002 15:56:46 -0500
X-MIMETrack: Serialize by Router on D03NM123/03/M/IBM(Release 5.0.10 |March 22, 2002) at
 10/08/2002 02:56:50 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Resending for those of you who are not on the fsdevel and samba-technical
mailing lists where earlier announcements about the new CIFS VFS were made
and which generated some useful feedback which has been incorporated in the
updated code.

The CIFS file system at http://cifs.bkbits.net/linux-2.5 is ready to be
included in the 2.5 Linux kernel.   The filesystem affects the usual small
set of files outside its own directory (fs/cifs) that a filesystem must
change (e.g. fs/Config.in, fs/Makefile, fs/Config.help) but does not
require changes to other kernel code.

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
project http://us1.samba.org/samba/Linux_CIFS_client.html and the current
source code is available from bitkeeper at http://cifs.bkbits.net/linux-2.5

I have also added a tar ball of the 2.5 version of the cifs vfs source to
the cifs project on the Samba site to make it easier for those without
bitkeeper.

   http://us1.samba.org/samba/ftp/cifs-cvs/linux25.cifs-0.5.3.tar.gz

The tarball contains a small patch to patch the usual few files that
filesystems have to touch outside their own directory (fs/Config.in etc.)
and also has the filesysystem's source (in the fs/cifs directory).

Steve French
Senior Software Engineer
Linux Technology Center - IBM Austin
phone: 512-838-2294
email: sfrench@us.ibm.com


