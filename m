Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261441AbTCYEKY>; Mon, 24 Mar 2003 23:10:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261442AbTCYEKY>; Mon, 24 Mar 2003 23:10:24 -0500
Received: from TYO201.gate.nec.co.jp ([210.143.35.51]:29839 "EHLO
	TYO201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S261441AbTCYEKX>; Mon, 24 Mar 2003 23:10:23 -0500
To: Christoph Hellwig <hch@lst.de>
Cc: linux-kernel@vger.kernel.org
Subject: !CONFIG_MMU stubs in 2.5.66
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
From: Miles Bader <miles@lsi.nec.co.jp>
Date: 25 Mar 2003 13:20:16 +0900
Message-ID: <buod6kgaxhb.fsf@mcspd15.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following change in 2.5.66:

   [PATCH] a few missing stubs for !CONFIG_MMU

   Patch from Christoph Hellwig <hch@lst.de>

   This is from the uClinux patches - there are a few more stubs needed
   in nommu.c to get the mmuless plattforms working.

Adds definitions for vmalloc_to_page, follow_page, and remap_page_range,
to mm/mmnommu.c.  However, there are already inline definitions of those
functions (predicated on !CONFIG_MMU) in linux/mm.h, so compilation
fails.

Which is the correct location?

[I locally removed the defs in linux/mm.h to get things to compile]

Thanks,

-Miles
-- 
[|nurgle|]  ddt- demonic? so quake will have an evil kinda setting? one that 
            will  make every christian in the world foamm at the mouth? 
[iddt]      nurg, that's the goal 
