Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750840AbWF2TRP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750840AbWF2TRP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 15:17:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751278AbWF2TRP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 15:17:15 -0400
Received: from rwcrmhc15.comcast.net ([216.148.227.155]:18574 "EHLO
	rwcrmhc15.comcast.net") by vger.kernel.org with ESMTP
	id S1750840AbWF2TRO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 15:17:14 -0400
Message-ID: <44A4273E.2030506@namesys.com>
Date: Thu, 29 Jun 2006 12:17:18 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] batch_write
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

This mail will be followed by two patches against 2.6.17-mm3.
First introduces batch_write method to address space operation which is
to allow filesystems to write more than one page in one call, changes
generic_file_buffered_write to use filesystem's batch_write if it is
available and implements generic_batch_write which writes one page in a
call.
Second patch changes reiser4 to use generic_file_write and reiser4
specific batch_write.

These patches were only tested on one test system so far, and
reiserfs-list failed to elicit any volunteers.  I guess that means it
should go into -mm.:-/

Any feedback on these patches is welcomed.



