Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129960AbQLLKIA>; Tue, 12 Dec 2000 05:08:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130121AbQLLKHv>; Tue, 12 Dec 2000 05:07:51 -0500
Received: from [212.172.23.17] ([212.172.23.17]:6916 "EHLO mail.plan9.de")
	by vger.kernel.org with ESMTP id <S129960AbQLLKHk>;
	Tue, 12 Dec 2000 05:07:40 -0500
Date: Tue, 12 Dec 2000 10:36:53 +0100
From: Marc Lehmann <pcg@goof.com>
To: linux-kernel@vger.kernel.org
Subject: recursive exports && linux nfs
Message-ID: <20001212103652.A13501@cerebro.laendle>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux version 2.2.18 (root@cerebro) (gcc version pgcc-2.95.2 19991024 (release)) 
X-Copyright: copyright 2000 Marc Alexander Lehmann - all rights reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi ;)

I am trying to export the whole filesystem hierarchy on one of my servers
(this includes /fs, which is an automounted directory using autofs).

Now I have two problems:

1) exporting: exportfs does not really exports filesystems that are
   not present when exportfs is being called (some of my filesystems
   are only available temporarily). Also, exportfs of course forces the mount
   of all filesystems that are mountable, which can take considerable time.

2) using: I can do cd /nfs/fs, but the directoy is always empty, and when I
   try to step into a subdirectory I always get "No such file or directory".

I am using linux-2.2.18, nfsv3 + nfs-utils-0.2.1.

Thanks a lot for any insights, even if this means "this is not supported"
;)

-- 
      -----==-                                             |
      ----==-- _                                           |
      ---==---(_)__  __ ____  __       Marc Lehmann      +--
      --==---/ / _ \/ // /\ \/ /       pcg@opengroup.org |e|
      -=====/_/_//_/\_,_/ /_/\_\       XX11-RIPE         --+
    The choice of a GNU generation                       |
                                                         |
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
