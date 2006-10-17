Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751091AbWJQO3a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751091AbWJQO3a (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 10:29:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751093AbWJQO3a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 10:29:30 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:53263 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751091AbWJQO33 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 10:29:29 -0400
Date: Tue, 17 Oct 2006 16:29:26 +0200
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: Linux 2.6.16.30-rc1
Message-ID: <20061017142926.GA3502@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Security fixes since 2.6.16.29:
- CVE-2006-3741: IA64: file descriptor reference counting in perfmon
- CVE-2006-4623: DVB: Proper handling ULE SNDU length of 0
- CVE-2006-4997: ATM CLIP: Do not refer freed skbuff in clip_mkip()


Patch location:
ftp://ftp.kernel.org/pub/linux/kernel/people/bunk/linux-2.6.16.y/testing/

git tree:
git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.16.y.git

RSS feed of the git tree:
http://www.kernel.org/git/?p=linux/kernel/git/stable/linux-2.6.16.y.git;a=rss


Changes since 2.6.16.30-pre1:

Adrian Bunk:
      Linux 2.6.16.30-rc1

Andrew de Quincey:
      v4l/dvb: Fix budget-av frontend detection
      v4l/dvb: Backport fix to artec USB DVB devices

Ang Way Chuang:
      dvb-core: Proper handling ULE SNDU length of 0 (CVE-2006-4623)

David S. Miller:
      [SPARC64]: Fix sched_clock() wrapping every ~17 seconds.
      [SPARC64]: Kill bogus check from bootmem_init().

Kim Nordlund:
      PKT_SCHED: cls_basic: Use unsigned int when generating handle

Kirill Korotaev:
      fix fdset leakage

Michal Ostrowski:
      [PPPOE]: Advertise PPPoE MTU

Olaf Hering:
      fbdev: add modeline for 1680x1050@60

Oliver Endriss:
      v4l/dvb: Backport the budget driver DISEQC instability fix

Rafael J. Wysocki:
      [CIFS] Allow cifsd to suspend if connection is lost

Stephane Eranian:
      [IA64] correct file descriptor reference counting in perfmon (CVE-2006-3741)

Stephen Hemminger:
      sky2: use dev_alloc_skb for receive buffers
      sky2: fix fiber support
      sky2: accept flow control

Steve French:
      [CIFS] fs/cifs/dir.c: fix possible NULL dereference
      [CIFS] Fix unlink oops when indirectly called in rename error path under heavy stress.
      [CIFS] Fix typo in earlier cifs_unlink change and protect one extra path.

YOSHIFUJI Hideaki:
      IPV6: Sum real space for RTAs.
      [ATM] CLIP: Do not refer freed skbuff in clip_mkip() (CVE-2006-4997)


 Makefile                              |    2 
 arch/ia64/kernel/perfmon.c            |    4 -
 arch/sparc64/kernel/time.c            |    2 
 arch/sparc64/mm/init.c                |    3 
 drivers/media/dvb/dvb-core/dvb_net.c  |    3 
 drivers/media/dvb/frontends/dvb-pll.c |   10 +-
 drivers/media/dvb/ttpci/budget-av.c   |    5 -
 drivers/media/dvb/ttpci/budget.c      |    6 -
 drivers/net/pppoe.c                   |    1 
 drivers/net/sky2.c                    |   87 +++++++++++++++-----------
 drivers/net/sky2.h                    |   17 ++++-
 drivers/video/modedb.c                |    4 +
 fs/cifs/connect.c                     |    1 
 fs/cifs/dir.c                         |    3 
 fs/cifs/inode.c                       |   15 ++--
 fs/file.c                             |    4 -
 net/atm/clip.c                        |    2 
 net/ipv6/addrconf.c                   |   28 +++++++-
 net/sched/cls_basic.c                 |    2 
 19 files changed, 131 insertions(+), 68 deletions(-)
