Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267386AbSLRXOA>; Wed, 18 Dec 2002 18:14:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267387AbSLRXOA>; Wed, 18 Dec 2002 18:14:00 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:43281 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S267386AbSLRXN6>;
	Wed, 18 Dec 2002 18:13:58 -0500
Date: Wed, 18 Dec 2002 15:19:17 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, linux-security-module@wirex.com
Subject: [BK PATCH] LSM changes for 2.5.52
Message-ID: <20021218231917.GA1782@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are some minor cleanups for the existing LSM code, and a
capabilities patch from Bill Irwin.

Please pull from:
	bk://lsm.bkbits.net/linus-2.5

thanks,

greg k-h

 kernel/capability.c  |   14 +++---
 security/Kconfig     |    7 ++-
 security/dummy.c     |  108 ---------------------------------------------------
 security/root_plug.c |    3 +
 security/security.c  |    8 +++
 5 files changed, 25 insertions(+), 115 deletions(-)
-----

ChangeSet@1.901, 2002-12-18 15:10:25-08:00, greg@kroah.com
  LSM: update the copyright dates for my entry.

 security/dummy.c    |    2 +-
 security/security.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
------

ChangeSet@1.900, 2002-12-18 15:09:33-08:00, greg@kroah.com
  LSM: Fix up the description of the root_plug code to try to make it clearer.

 security/Kconfig     |    7 +++++--
 security/root_plug.c |    3 +++
 2 files changed, 8 insertions(+), 2 deletions(-)
------

ChangeSet@1.899, 2002-12-18 14:58:27-08:00, wli@holomorphy.com
  [PATCH] converting cap_set_pg() to for_each_task_pid()
  
  cap_set_pg() wants to find all processes in a given process group. This
  converts it to use for_each_task_pid().

 kernel/capability.c |   14 ++++++++------
 1 files changed, 8 insertions(+), 6 deletions(-)
------

ChangeSet@1.898, 2002-12-18 14:57:38-08:00, greg@kroah.com
  LSM: changed the dummy code to use the default operations logic.

 security/dummy.c    |  106 ----------------------------------------------------
 security/security.c |    6 ++
 2 files changed, 7 insertions(+), 105 deletions(-)
------

