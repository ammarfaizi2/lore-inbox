Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263743AbUFNSGc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263743AbUFNSGc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 14:06:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263714AbUFNSG2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 14:06:28 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:63471 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263640AbUFNSGZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 14:06:25 -0400
From: Kevin Corry <kevcorry@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] DM 0/5: Device-mapper cleanups
Date: Mon, 14 Jun 2004 13:09:31 +0000
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200406141309.31127.kevcorry@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanups for Device-Mapper based on feedback from kcopyd, dm-io, and 
dm-mirror. These are based on 2.6.7-rc3-mm2.

-- 
Kevin Corry
kevcorry@us.ibm.com
http://evms.sourceforge.net/


Revision 1:
  Create/destroy kcopyd on demand.

Revision 2:
  Use structure assignments instead of memcpy's.

Revision 3:
  dm-io: Proper error handling when trying to read from multiple regions.

Revision 4:
  dm-raid1.c: Make struct region::delayed_bios a bio_list instead of a bio*.

Revision 5:
  dm-raid1.c: In rh_exit(), use list_for_each_entry_safe
