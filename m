Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965284AbWHWWeA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965284AbWHWWeA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 18:34:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965301AbWHWWd7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 18:33:59 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:33546 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S965298AbWHWWd5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 18:33:57 -0400
Date: Thu, 24 Aug 2006 00:33:55 +0200
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: Linux 2.6.16.28-rc3
Message-ID: <20060823223355.GC19810@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There are still several patches pending - they will go into 2.6.16.29.

Security fixes since 2.6.16.27:
- CVE-2006-2935: cdrom: fix bad cgc.buflen assignment
- CVE-2006-3745: Fix sctp privilege elevation
- CVE-2006-4093: powerpc: Clear HID0 attention enable on PPC970 at boot time
- CVE-2006-4145: Fix possible UDF deadlock and memory corruption


Patch location:
ftp://ftp.kernel.org/pub/linux/kernel/people/bunk/linux-2.6.16.y/testing/

git tree:
git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.16.y.git

RSS feed of the git tree:
http://www.kernel.org/git/?p=linux/kernel/git/stable/linux-2.6.16.y.git;a=rss


Changes since 2.6.16.28-rc3:

Adrian Bunk:
      Linux 2.6.16.28-rc3

Danny Tholen:
      1394: fix for recently added firewire patch that breaks things on ppc

Jan Kara:
      Fix possible UDF deadlock and memory corruption (CVE-2006-4145)

Sridhar Samudrala:
      Fix sctp privilege elevation (CVE-2006-3745)


 Makefile                    |    2 -
 drivers/ieee1394/ohci1394.c |    4 +-
 fs/udf/super.c              |    2 -
 fs/udf/truncate.c           |   64 +++++++++++++++++++++---------------
 include/net/sctp/sctp.h     |   13 -------
 include/net/sctp/sm.h       |    3 -
 net/sctp/sm_make_chunk.c    |   30 +++++-----------
 net/sctp/sm_statefuns.c     |   20 ++---------
 net/sctp/socket.c           |   10 +++++
 9 files changed, 66 insertions(+), 82 deletions(-)

