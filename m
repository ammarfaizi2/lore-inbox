Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262899AbVCDM0Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262899AbVCDM0Q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 07:26:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262882AbVCDMVx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 07:21:53 -0500
Received: from smtp08.auna.com ([62.81.186.18]:61391 "EHLO smtp08.retemail.es")
	by vger.kernel.org with ESMTP id S262892AbVCDL6b convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 06:58:31 -0500
Date: Fri, 04 Mar 2005 11:58:30 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: nothing in /proc/fs/nfs/exports ?
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
X-Mailer: Balsa 2.3.0
Message-Id: <1109937510l.11030l.0l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all...

I have problems with NFS in 2.6.11. Just a simple test:

#!/bin/bash

service nfslock stop
service nfs stop
rm -rf /var/lib/nfs/*
service nfs start
service nfslock start
echo "===== /etc/exports"
cat /etc/exports
echo "===== exportsfs -v"
exportfs -v
echo "===== /var/lib/nfs/xtab"
cat /var/lib/nfs/xtab
echo "===== /proc/fs/nfs/exports"
cat /proc/fs/nfs/exports


Results are:

Stopping NFS statd:                                             [  OK  ]
Shutting down NFS mountd:                                       [  OK  ]
Shutting down NFS daemon:                                       [  OK  ]
Shutting down NFS services:                                     [  OK  ]
Starting NFS services:                                          [  OK  ]
Starting NFS daemon:                                            [  OK  ]
Starting NFS mountd:                                            [  OK  ]
Starting NFS statd:                                             [  OK  ]
===== /etc/exports
/store/media/music      192.168.0.2(ro,no_root_squash,no_subtree_check,insecure)
===== exportsfs -v
/store/media/music
                ibook(ro,wdelay,insecure,no_root_squash,no_subtree_check)
===== /var/lib/nfs/xtab
===== /proc/fs/nfs/exports
# Version 1.1
# Path Client(Flags) # IPs

Nothing in xtab ? Nothing in /proc ? Why ?

werewolf:~# df /store
Filesystem    Type   1K-blocks      Used Available Use% Mounted on
/dev/hda1     ext3   115377640  39848024  69668704  37% /store

Any hint ?

--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandrakelinux release 10.2 (Cooker) for i586
Linux 2.6.11-jam1 (gcc 3.4.3 (Mandrakelinux 10.2 3.4.3-3mdk)) #1


