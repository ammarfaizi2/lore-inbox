Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264303AbRF2Xu1>; Fri, 29 Jun 2001 19:50:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263675AbRF2XuQ>; Fri, 29 Jun 2001 19:50:16 -0400
Received: from otto.colonization.com ([128.171.80.37]:40964 "EHLO
	otto.cfht.hawaii.edu") by vger.kernel.org with ESMTP
	id <S264389AbRF2XuG>; Fri, 29 Jun 2001 19:50:06 -0400
From: Sidik Isani <isani@cfht.hawaii.edu>
Message-Id: <200106292350.NAA08050@otto.cfht.hawaii.edu>
Subject: CRAMFS error "attempt to access beyond end of device"
To: linux-kernel@vger.kernel.org
Date: Fri, 29 Jun 2001 13:50:04 -1000 (HST)
X-Mailer: ELM [version 2.5 PL0]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello -

  Is there maybe a missing boundary check in cramfs that causes
  accesses slightly past (up to 24 or 32K?) the end of a device?
  Here's an example of a cramfs image mounted on a loop device
  (the same thing happens with other block devices, and when the
  kernel itself mounts a partition as cramfs-root.)

attempt to access beyond end of device
07:01: rw=0, want=1156, limit=1152
attempt to access beyond end of device
07:01: rw=0, want=1160, limit=1152
attempt to access beyond end of device
07:01: rw=0, want=1164, limit=1152

  The messages appear while running "diff -r" against the original tree.
  The diff itself doesn't find any problems with the filesystem.
  The size of the cramfs is 1179648 bytes, or exactly 1152 * 1024.
  My kernel version is 2.4.5, but this behavior has existed since
  the 2.4.0-test kernels.

  If anyone has ideas on this, please let me know.

- Sidik
