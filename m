Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030456AbWHXTnL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030456AbWHXTnL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 15:43:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030467AbWHXTnL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 15:43:11 -0400
Received: from mx1.redhat.com ([66.187.233.31]:11164 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030456AbWHXTnK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 15:43:10 -0400
Message-ID: <44EE014C.5020303@redhat.com>
Date: Thu, 24 Aug 2006 14:43:08 -0500
From: Eric Sandeen <esandeen@redhat.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] - more ext3 16T fixes
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These two patches address a few more issues when using 16T ext3 filesystems on 
32-bit systems.

These are based in large part on the work Takashi Sato did earlier[1] - I tried 
to distill out just the large filesystem fixes, leaving large files for later.

These apply on top of fix-ext3-mounts-at-16t.patch already in the -mm tree

1: Fix one more overflow in reservation code (plus cosmetic changes) and test 
   for overflows when resizing
2: Treat all inode numbers as unsigned longs - fix formats and a couple of types

If these pass muster I'll send analogous patches for ext2.

-Eric

[1] http://marc.theaimsgroup.com/?l=ext2-devel&m=114856080926308&w=2

