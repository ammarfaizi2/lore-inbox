Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265091AbUGIQnG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265091AbUGIQnG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 12:43:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265098AbUGIQnG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 12:43:06 -0400
Received: from bigapple.newyorkcity.de ([192.76.147.50]:24252 "EHLO
	bigapple.newyorkcity.de") by vger.kernel.org with ESMTP
	id S265091AbUGIQkv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 12:40:51 -0400
Date: Fri, 09 Jul 2004 18:40:28 +0200
From: Martin Ziegler <mz@newyorkcity.de>
To: linux-kernel@vger.kernel.org
cc: mz@newyorkcity.de
Subject: NFS no longer working ?
Message-ID: <8232A615C6D0B05C09DBF242@soho>
X-Mailer: Mulberry/3.1.5 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

just installed kernel version 2.6.7 on RedHat 8.0. Unfortunately i'm no 
longer able to use NFS. Are there any recent issues ? For a detailed 
problem description please see below. Any help is appreciated.

Thanks

  Martin


I have two machines..let's say A and B. On A / /boot and /sys are exported 
via /etc/exports. Machine B are mouting these sources when booting via NFS. 
Since i updated the kernel i get the following errors when machine A is 
starting the NFS services :

---
Jul 8 09:30:13 hostA exportfs: hostB:/boot: No such device
Jul 8 09:30:13 hostA exportfs: hostB:/sys: No such device
Jul 8 09:30:13 hosta exportfs: hostB:/: No such device
Jul 8 09:30:13 hostA nfs: Starting NFS services: succeeded
Jul 8 09:30:13 hostA nfs: rpc.rquotad startup succeeded
Jul 8 09:30:13 hostA nfsd[6376]: nfssvc: No such device
Jul 8 09:30:13 hosta nfs: rpc.nfsd startup failed
Jul 8 09:30:13 hostA nfs: rpc.mountd startup succeeded

----

cat /etc/exports:

/ hostB(ro,sync,no_root_squash) /sys hostB(ro,sync,no_root_squash) /boot 
hostB(ro,sync,no_root_squash)

----

cat /etc/hosts.allow

ALL:hostB

----

With the old kernel 2.4.20-8 i had no problems.

NFS support is compiled into the new kernel.

