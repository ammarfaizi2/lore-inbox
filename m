Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261170AbUDLONE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Apr 2004 10:13:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262870AbUDLONE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Apr 2004 10:13:04 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:19187 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261170AbUDLONA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Apr 2004 10:13:00 -0400
From: Kevin Corry <kevcorry@us.ibm.com>
To: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] Device-Mapper 0/9
Date: Mon, 12 Apr 2004 09:12:45 -0500
User-Agent: KMail/1.6
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200404120912.45870.kevcorry@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Device-Mapper bug-fixes from the -udm tree.

-- 
Kevin Corry
kevcorry@us.ibm.com
http://evms.sourceforge.net/


Revision 1:
  Fix 64/32 bit ioctl problems.

Revision 2:
  Check the uptodate flag in sub-bios to see if there was an error.
  [Mike Christie]

Revision 3:
  Handle interrupts within suspend.

Revision 4:
  dm.c: Use wake_up() rather than wake_up_interruptible() with the
  eventq.

Revision 5:
  Log an error if the target has unknown target type, or zero length.

Revision 6:
  Correctly align the dm_target_spec structures during retrieve_status().
  
Revision 7:
  Clarify the comment regarding the "next" field in struct dm_target_spec. The
  "next" field has different behavior if you're performing a DM_TABLE_STATUS
  command than it does if you're performing a DM_TABLE_LOAD command.
  
  See populate_table() and retrieve_status() in drivers/md/dm-ioctl.c for more
  details on how this field is used.

Revision 8:
  dm-ioctl.c::retrieve_status(): Prevent overrunning the ioctl buffer by
  making sure we don't call the target status routine with a buffer size limit
  of zero. [Kevin Corry, Alasdair Kergon]

Revision 9:
  Striped: Use an EMIT macro in the status function.

