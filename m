Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263003AbUC2RMm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 12:12:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262915AbUC2RMZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 12:12:25 -0500
Received: from hauptpostamt.charite.de ([193.175.66.220]:18921 "EHLO
	hauptpostamt.charite.de") by vger.kernel.org with ESMTP
	id S262998AbUC2RIP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 12:08:15 -0500
Date: Mon, 29 Mar 2004 19:08:00 +0200
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: linux-kernel@vger.kernel.org
Subject: ppp_synctty oops
Message-ID: <20040329170800.GF6374@charite.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This one has been around for quite a while in 2.6.x - I get this
whenever my sync ppp connection is torn down:

Badness in local_bh_enable at kernel/softirq.c:122
Call Trace:
 [<c011ee10>] local_bh_enable+0x50/0x60
 [<d8cd3aaf>] ppp_sync_push+0x4f/0x140 [ppp_synctty]
 [<d8cd355c>] ppp_sync_wakeup+0x1c/0x40 [ppp_synctty]
 [<c01c4d53>] do_tty_hangup+0x2d3/0x340
 [<c01c5f31>] release_dev+0x531/0x560
 [<c013bc33>] unmap_page_range+0x33/0x60
 [<c013bd62>] unmap_vmas+0x102/0x220
 [<c01c6267>] tty_release+0x7/0x20
 [<c0149448>] __fput+0xc8/0xe0
 [<c0147ec3>] filp_close+0x43/0x80
 [<c011cafa>] put_files_struct+0x5a/0xc0
 [<c011d5ff>] do_exit+0x13f/0x300
 [<c011d868>] do_group_exit+0x28/0x80
 [<c0106fe7>] syscall_call+0x7/0xb
	      
Linux shawarma.eth0.cxm 2.6.5-rc2-bk8 #1 Sun Mar 28 17:21:43 CEST 2004 i586 GNU/Linux

-- 
Ralf Hildebrandt (Im Auftrag des Referat V a)   Ralf.Hildebrandt@charite.de
Charite - Universitätsmedizin Berlin            Tel.  +49 (0)30-450 570-155
Gemeinsame Einrichtung von FU- und HU-Berlin    Fax.  +49 (0)30-450 570-916
IT-Zentrum Standort Campus Mitte                          AIM.  ralfpostfix
