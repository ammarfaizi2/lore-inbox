Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267545AbUBRPhx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 10:37:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267543AbUBRPhx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 10:37:53 -0500
Received: from hauptpostamt.charite.de ([193.175.66.220]:2225 "EHLO
	hauptpostamt.charite.de") by vger.kernel.org with ESMTP
	id S267545AbUBRPhv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 10:37:51 -0500
Date: Wed, 18 Feb 2004 16:37:31 +0100
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: linux-kernel@vger.kernel.org
Subject: Kernel 2.6.3 and ppp_synctty badness
Message-ID: <20040218153731.GA31346@charite.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Today I had connection problems (due to the provider) and whenever
pppd tried to connect, I got:

Badness in local_bh_enable at kernel/softirq.c:121
Call Trace:
 [<c011f384>] local_bh_enable+0x74/0x80
 [<ccb2dc21>] ppp_sync_push+0x51/0x140 [ppp_synctty]
 [<ccb2d63d>] ppp_sync_wakeup+0x2d/0x60 [ppp_synctty]
 [<c01ce883>] do_tty_hangup+0x323/0x380
 [<c01cfb72>] release_dev+0x5d2/0x610
 [<c013f33b>] zap_pmd_range+0x4b/0x70
 [<c013f3ab>] unmap_page_range+0x4b/0x80
 [<c01cff2f>] tty_release+0xf/0x20
 [<c014e52e>] __fput+0xde/0xf0
 [<c014ccf9>] filp_close+0x59/0x90
 [<c011ce14>] put_files_struct+0x64/0xd0
 [<c011d9e9>] do_exit+0x149/0x330
 [<c011dc74>] do_group_exit+0x34/0x80
 [<c010915f>] syscall_call+0x7/0xb

$ uname -a
Linux hummus 2.6.3 #1 Wed Feb 18 08:51:40 CET 2004 i686 GNU/Linux

-- 
Ralf Hildebrandt (Im Auftrag des Referat V a)   Ralf.Hildebrandt@charite.de
Charite - Universitätsmedizin Berlin            Tel.  +49 (0)30-450 570-155
Gemeinsame Einrichtung von FU- und HU-Berlin    Fax.  +49 (0)30-450 570-916
IT-Zentrum Standort Campus Mitte                          AIM.  ralfpostfix
