Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263919AbUDHHzJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 03:55:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263973AbUDHHzJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 03:55:09 -0400
Received: from TYO202.gate.nec.co.jp ([210.143.35.52]:38021 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S263919AbUDHHzF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 03:55:05 -0400
To: linux-kernel@vger.kernel.org
Subject: Sys-V IPC and !MMU
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
From: Miles Bader <miles@lsi.nec.co.jp>
Date: 08 Apr 2004 16:55:00 +0900
Message-ID: <buohdvunbu3.fsf@mcspd15.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I notice that if you enable Sys-V IPC support (CONFIG_SYSVIPC) on a
no-MMU arch, the kernel fails to compile because it uses functions
defined in mm/shmem.c, which is not compiled if !MMU.

Is this a fundamental incompatibility?  If so, maybe init/Kconfig should
make SYSVIPC depend on MMU.

Thanks,

-Miles
-- 
I'm beginning to think that life is just one long Yoko Ono album; no rhyme
or reason, just a lot of incoherent shrieks and then it's over.  --Ian Wolff
