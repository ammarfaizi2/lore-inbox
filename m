Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266526AbUIEMO0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266526AbUIEMO0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 08:14:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266543AbUIEMO0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 08:14:26 -0400
Received: from math.ut.ee ([193.40.5.125]:20219 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S266526AbUIEMOZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 08:14:25 -0400
Date: Sun, 5 Sep 2004 15:14:22 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Badness in remove_proc_entry
Message-ID: <Pine.GSO.4.44.0409051513220.14314-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Got this while removing the megaraid module in 2.6.9-rc1+BK (about
-bk12):

Badness in remove_proc_entry at fs/proc/generic.c:688
 [<c017dcda>] remove_proc_entry+0xfa/0x130
 [<e090087e>] megaraid_exit+0x1e/0x28 [megaraid]
 [<c012e01f>] sys_delete_module+0x12f/0x170
 [<c0142f2a>] unmap_vma_list+0x1a/0x30
 [<c0143273>] do_munmap+0x123/0x160
 [<c0104049>] sysenter_past_esp+0x52/0x71

-- 
Meelis Roos (mroos@linux.ee)

