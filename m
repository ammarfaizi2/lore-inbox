Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261610AbUF3Tvo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261610AbUF3Tvo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 15:51:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261857AbUF3Tvo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 15:51:44 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:34203 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S261610AbUF3Tvc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 15:51:32 -0400
From: Kevin Corry <kevcorry@us.ibm.com>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] 0/4: Device-Mapper: Minor cleanups and fixes
Date: Wed, 30 Jun 2004 14:52:16 -0500
User-Agent: KMail/1.6.2
Cc: LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200406301452.16886.kevcorry@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patches against 2.6.7-bk13.

Revision 1:
  kcopyd.c: Remove unused #include.

Revision 2:
  kcopyd.c: client_add() can return void instead of an int, which will
  eliminate an unnecessary error path in kcopyd_client_create().

Revision 3:
  dm-raid1.c: Since kcopyd can currently only handle 1 source and up to 8
  destinations, enforce a max of 9 mirrors when creating a dm-mirror device.

Revision 4:
  dm-raid1.c: Declare fixed-sized (instead of variable-sized) arrays on the
  stack in recover() and do_write().

-- 
Kevin Corry
kevcorry@us.ibm.com
http://evms.sourceforge.net/
