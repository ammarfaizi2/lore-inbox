Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266730AbRGFPRf>; Fri, 6 Jul 2001 11:17:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266729AbRGFPRZ>; Fri, 6 Jul 2001 11:17:25 -0400
Received: from horus.its.uow.edu.au ([130.130.68.25]:28032 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S266728AbRGFPRS>; Fri, 6 Jul 2001 11:17:18 -0400
Message-ID: <3B45D6DB.70B9D754@uow.edu.au>
Date: Sat, 07 Jul 2001 01:18:51 +1000
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
CC: "Stephen C. Tweedie" <sct@redhat.com>,
        Andreas Dilger <adilger@turbolinux.com>,
        "Peter J. Braam" <braam@clusterfilesystem.com>,
        "ext3-users@redhat.com" <ext3-users@redhat.com>
Subject: ext3-2.4-0.9.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

An update of the ext3 journalling filesystem for 2.4 kernels
is available at

	http://www.uow.edu.au/~andrewm/linux/ext3/

Patches are against 2.4.6-ac1 and 2.4.6.

Changes since 0.0.8 include:

- Multiplied the version numbering by ten to cater for bugfix
  releases against the 0.9.0 stream.

- The main thrust has been the removal of a number of changes in
  the core kernel which were required for to support the journalling
  of data.  This has caused some duplication of core code within
  ext3, but it's not too bad.

- A number of cleanups and resyncs with latest ext2. (Thanks, Al).

- Reorganised and optimised ext3_write_inode() and the handling
  of files which were opened O_SYNC.

- Move quota operations outside lock_super() - fixes last known
  source of quota deadlocks in -ac kernels.

- Deleted large chunks of debug/development support code.

- Improved handling of corner-case errors.

- Improved robustness in out-of-memory situations.

The last change is probably the most significant - it prevents
possible crashes and fs corruption under extreme workloads.

-
