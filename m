Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318250AbSHZWft>; Mon, 26 Aug 2002 18:35:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318256AbSHZWft>; Mon, 26 Aug 2002 18:35:49 -0400
Received: from smtp.actcom.co.il ([192.114.47.13]:28572 "EHLO
	lmail.actcom.co.il") by vger.kernel.org with ESMTP
	id <S318250AbSHZWft>; Mon, 26 Aug 2002 18:35:49 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Itai Nahshon <nahshon@actcom.co.il>
Reply-To: nahshon@actcom.co.il
To: linux-kernel@vger.kernel.org
Subject: [OT] unable to umount ... device busy
Date: Tue, 27 Aug 2002 01:40:04 +0300
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200208270140.04743.nahshon@actcom.co.il>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, sorry for bringing this up here3 but I do not know
of a better forum for this subject...

Working in an environment of multiple Linux systems
(and wildly using NFS and am-utils) I have hit this problem
many times and in some cases I can describe it as "embarrassing".

The problem is that processes that do not really care about their
working directory are standing in the way of umount.
It is most painful when I cannot eject a CD (or other removable
device) and sometimes with NFS mounted directories.

Most guilty programs:
su + the pam patch (as distributed by redhat) there's a process just
  waiting for the shell to exit.
Daemons - should cd to "/" except if there is some other preferred
  directory.

Related subject and not completely OT: I remember in AIX, umount -f
(forced umount) marked all the open inodes on the device as
STALE and then proceed (and never return EBUSY). Any plans
to implement it also for Linux?

-- Itai

