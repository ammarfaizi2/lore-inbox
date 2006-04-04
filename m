Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751830AbWDDHjJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751830AbWDDHjJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 03:39:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751834AbWDDHjI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 03:39:08 -0400
Received: from mail.knowledgetools.de ([212.5.29.62]:48817 "EHLO
	isoconazol.knowledgetools.de") by vger.kernel.org with ESMTP
	id S1751830AbWDDHjI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 03:39:08 -0400
From: Thomas Stein <thomas.stein@knowledgetools.de>
To: linux-kernel@vger.kernel.org
Subject: dma_map_sg badness
Date: Tue, 4 Apr 2006 09:39:13 +0200
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604040939.13912.thomas.stein@knowledgetools.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everybody.

I have some weird messages in my systemlog since upgrading to kernel 2.6.16.

Badness in dma_map_sg at include/asm/dma-mapping.h:47
 [<c02893da>] ide_build_sglist+0x7f/0xb6
 [<c028944e>] ide_build_dmatable+0x3d/0x12d
 [<c0289780>] ide_dma_setup+0x22/0x8a
 [<c0290ecf>] idetape_issue_packet_command+0x122/0x20a
 [<c02917e2>] idetape_do_request+0x29f/0x2a9
 [<c02836c4>] start_request+0x189/0x1a7
 [<c02839e4>] ide_do_request+0x2da/0x31e
 [<c0283a3f>] do_ide_request+0x17/0x1a
 [<c0224015>] elv_insert+0x5c/0x141
 [<c0283ec4>] ide_do_drive_cmd+0x96/0xd6
 [<c0291914>] __idetape_kmalloc_stage+0x128/0x19e
 [<c02921ea>] idetape_insert_pipeline_into_queue+0x39/0x3f
 [<c02923d2>] idetape_add_chrdev_write_request+0x105/0x141
 [<c029300f>] idetape_chrdev_write+0x1ea/0x22d
 [<c0140796>] vfs_write+0x88/0x11c
 [<c01408c8>] sys_write+0x3b/0x63
 [<c01029e1>] syscall_call+0x7/0xb

Its a regular x86 machine (athlon-xp) with a IDE Tape Writer ( Sony 
Storestation) connected to the Secondary IDE channel. Someone knows whats 
causing this? 

Oh before i forget, i am not subscribed to the list. Please CC me if you 
answer to that posting. Thanks.

best regards
t.
