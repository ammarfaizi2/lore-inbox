Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266968AbTAKBE5>; Fri, 10 Jan 2003 20:04:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266971AbTAKBE4>; Fri, 10 Jan 2003 20:04:56 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:26898 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S266968AbTAKBEz>;
	Fri, 10 Jan 2003 20:04:55 -0500
Date: Fri, 10 Jan 2003 17:12:51 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, linux-security-module@wirex.com
Subject: [BK PATCH] LSM changes for 2.5.56
Message-ID: <20030111011251.GK22363@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This changset includes security hooks for the remaining System V IPC
hooks.  The patch has been posted for discussion a few weeks ago, and
there were no objections to it being included.

Please pull from:
	bk://lsm.bkbits.net/linus-2.5

thanks,

greg k-h

 CREDITS                  |    3 
 include/linux/msg.h      |    1 
 include/linux/security.h |  244 +++++++++++++++++++++++++++++++++++++++++++++++
 ipc/msg.c                |   41 +++++++
 ipc/sem.c                |   32 +++++-
 ipc/shm.c                |   41 +++++++
 security/dummy.c         |   77 ++++++++++++++
 7 files changed, 429 insertions(+), 10 deletions(-)
-----

ChangeSet@1.889.20.2, 2003-01-10 12:33:40-08:00, sds@epoch.ncsc.mil
  [PATCH] CREDITS patch
  
  The attached patch against 2.5.55 updates my CREDITS entry for my current email
  address.

 CREDITS |    3 +--
 1 files changed, 1 insertion(+), 2 deletions(-)
------

ChangeSet@1.889.20.1, 2003-01-10 12:30:59-08:00, sds@epoch.ncsc.mil
  [PATCH] 2.5.52-lsm-{dummy,ipc}.patch
  
  This patch adds the remaining System V IPC hooks, including the inline
  documentation for them in security.h.  This includes a restored
  sem_semop hook, as it does seem to be necessary to support fine-grained
  access.
  
  All of these System V IPC hooks are used by SELinux.  The SELinux System
  V IPC access controls were originally described in the technical report
  available from http://www.nsa.gov/selinux/slinux-abs.html, and the
  LSM-based implementation is described in the technical report available
  from http://www.nsa.gov/selinux/module-abs.html.

 include/linux/msg.h      |    1 
 include/linux/security.h |  244 +++++++++++++++++++++++++++++++++++++++++++++++
 ipc/msg.c                |   41 +++++++
 ipc/sem.c                |   32 +++++-
 ipc/shm.c                |   41 +++++++
 security/dummy.c         |   77 ++++++++++++++
 6 files changed, 428 insertions(+), 8 deletions(-)
------

