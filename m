Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313818AbSDFAky>; Fri, 5 Apr 2002 19:40:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313823AbSDFAko>; Fri, 5 Apr 2002 19:40:44 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:29079 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S313818AbSDFAkZ>; Fri, 5 Apr 2002 19:40:25 -0500
Message-ID: <3CAE43FA.8010608@us.ibm.com>
Date: Fri, 05 Apr 2002 16:40:26 -0800
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9+) Gecko/20020405
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] remove initialization from removed sem
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,
   The last patch I sent still initialized the semaphore that I removed.

--- fs/inode.c.orig	Fri Apr  5 16:36:11 2002
+++ fs/inode.c	Fri Apr  5 16:36:21 2002
@@ -143,7 +143,6 @@
  	INIT_LIST_HEAD(&inode->i_dirty_data_buffers);
  	INIT_LIST_HEAD(&inode->i_devices);
  	sema_init(&inode->i_sem, 1);
- 
sema_init(&inode->i_attr_lock, 1);
  	spin_lock_init(&inode->i_data.i_shared_lock);
  	INIT_LIST_HEAD(&inode->i_data.i_mmap);
  	INIT_LIST_HEAD(&inode->i_data.i_mmap_shared);

-- 
Dave Hansen
haveblue@us.ibm.com

